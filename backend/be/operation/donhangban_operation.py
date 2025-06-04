# backend/sales_order_operations.py
import psycopg2
import psycopg2.extras
from datetime import date
from be.db_connection import get_db_connection, close_db_connection


# --- Hàm nội bộ để lấy thông tin sản phẩm cần cho việc bán hàng ---
def _get_soluongtonkho(conn, id_san_pham):
    """
    Hàm nội bộ để lấy số lượng tồn kho và tên sản phẩm.
    """
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            cur.execute("SELECT id, ten_san_pham, so_luong_ton_kho FROM SanPham WHERE id = %s;", (id_san_pham,))
            product = cur.fetchone()
            if product:
                return dict(product)
            print(f"Sản phẩm với ID {id_san_pham} không tồn tại.")
            return None
    except psycopg2.Error as e:
        print(f"Lỗi khi lấy thông tin sản phẩm ID {id_san_pham} để bán: {e}")
        return None


# --- Các hàm quản lý Đơn Hàng Bán ---

def create_donhangban(id_nhan_vien, id_khach_hang=None,
                       ngay_dat_hang_str=None,
                       trang_thai_don_hang='Chờ xác nhận',
                       phuong_thuc_thanh_toan='Tiền mặt',  # Sửa từ hinh_thuc_thanh_toan
                       trang_thai_thanh_toan='Chưa thanh toán',
                       ghi_chu_don_hang=None, dia_chi_giao_hang=None):
    """
    Tạo một Đơn Hàng Bán mới.
    Schema DonHangBan (Source 1, page 4) được giả định không còn các cột tổng ở cấp đơn hàng
    hoặc chúng sẽ không được Python cập nhật trực tiếp khi tạo/thêm chi tiết.
    """
    conn = get_db_connection()
    if not conn:
        return None

    allowed_order_statuses = ['Chờ xác nhận', 'Đã xác nhận', 'Đang giao hàng', 'Đã giao', 'Hoàn tất', 'Đã hủy',
                              'Trả hàng']
    if trang_thai_don_hang not in allowed_order_statuses:
        print(f"Lỗi: Trạng thái đơn hàng '{trang_thai_don_hang}' không hợp lệ.")
        close_db_connection(conn)
        return None

    allowed_payment_methods = ['Tiền mặt', 'Chuyển khoản', 'Thẻ tín dụng', 'COD']
    if phuong_thuc_thanh_toan not in allowed_payment_methods:
        print(f"Lỗi: Phương thức thanh toán '{phuong_thuc_thanh_toan}' không hợp lệ.")
        close_db_connection(conn)
        return None

    allowed_payment_statuses = ['Chưa thanh toán', 'Đã thanh toán']
    if trang_thai_thanh_toan not in allowed_payment_statuses:
        print(f"Lỗi: Trạng thái thanh toán '{trang_thai_thanh_toan}' không hợp lệ.")
        close_db_connection(conn)
        return None

    actual_ngay_dat_hang_for_sql = None
    if ngay_dat_hang_str:
        try:
            actual_ngay_dat_hang_for_sql = date.fromisoformat(ngay_dat_hang_str)
        except ValueError:
            print(f"Lỗi: Định dạng ngày đặt hàng '{ngay_dat_hang_str}' không hợp lệ (YYYY-MM-DD).")
            close_db_connection(conn)
            return None

    new_donhangban_id = None
    # Câu lệnh INSERT không bao gồm các cột tổng ở cấp DonHangBan nữa
    # (tong_doanh_thu, tong_gia_von theo schema đã được bạn thông báo loại bỏ hoặc không tính ở backend)
    # ngay_dat_hang là TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    sql = """
        INSERT INTO DonHangBan (
            id_khach_hang, id_nhan_vien, ngay_dat_hang, 
            trang_thai_don_hang, phuong_thuc_thanh_toan, trang_thai_thanh_toan, 
            ghi_chu_don_hang, dia_chi_giao_hang
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s) 
        RETURNING id;
    """
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (id_khach_hang, id_nhan_vien, actual_ngay_dat_hang_for_sql,
                              trang_thai_don_hang, phuong_thuc_thanh_toan, trang_thai_thanh_toan,
                              ghi_chu_don_hang, dia_chi_giao_hang))
            fetch_result = cur.fetchone()
            if fetch_result:
                new_donhangban_id = fetch_result[0]
            conn.commit()
            print(f"Đơn Hàng Bán mới đã được tạo với ID: {new_donhangban_id}.")
    except psycopg2.Error as e:
        print(f"Lỗi khi tạo Đơn Hàng Bán mới: {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return new_donhangban_id


def add_item_to_donhangban(id_don_hang_ban, id_san_pham, so_luong,
                            gia_ban_niem_yet_don_vi, giam_gia,  # giam_gia là tỷ lệ thập phân (0.0 - 1.0)
                            ghi_chu_item=None):
    """
    Thêm một sản phẩm vào ChiTietDonHangBan.
    Kiểm tra số lượng tồn kho.
    Các trường tính toán của ChiTietDonHangBan (gia_ban_cuoi_cung_don_vi, tong_gia_ban, tong_gia_von)
    sẽ do trigger SQL xử lý. Python chỉ insert dữ liệu thô.
    """
    conn = get_db_connection()
    if not conn:
        return None

    # Validate giam_gia (phù hợp với CHECK constraint 0-1 của trigger trg_tinh_gia_ban_cuoi_cung )
    if not (0 <= giam_gia <= 1):
        print(f"Lỗi: Tỷ lệ giảm giá '{giam_gia}' không hợp lệ. Phải từ 0.0 đến 1.0 (ví dụ: 0.1 cho 10%).")
        close_db_connection(conn)
        return None

    id_chi_tiet_don_hang_ban_moi = None
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            # Bước 1: Kiểm tra số lượng tồn kho
            product_info = _get_soluongtonkho(conn, id_san_pham)
            if not product_info:
                # Lỗi đã được in trong _get_product_details_for_sale
                close_db_connection(conn)
                return None

            current_stock = product_info['so_luong_ton_kho']
            if current_stock < so_luong:
                # Yêu cầu của bạn: "hãy in ra thông báo là số lượng tồn kho không đủ"
                print(f"Số lượng tồn kho không đủ cho sản phẩm '{product_info['ten_san_pham']}' (ID {id_san_pham}). "
                      f"Hiện có: {current_stock}, Yêu cầu: {so_luong}.")
                close_db_connection(conn)
                return None

            # Bước 2: Thêm chi tiết đơn hàng bán
            # Python chỉ insert các giá trị đầu vào cơ bản. Các trigger sẽ lo phần còn lại.
            # Schema ChiTietDonHangBan (Source 1, page 5) gồm:
            # id, id_don_hang_ban, id_san_pham, so_luong, gia_ban_niem_yet_don_vi, giam_gia,
            # gia_ban_cuoi_cung_don_vi (tính bởi trigger trg_tinh_gia_ban_cuoi_cung ),
            # tong_gia_von (tính bởi trigger trg_tinh_tong_gia_von_ban ),
            # tong_gia_ban (tính bởi trigger trg_tinh_tong_gia_ban_ban ),
            # ghi_chu.
            # Hàm INSERT sẽ cung cấp những gì cần thiết cho các trigger này hoạt động.
            sql_add_item = """
                INSERT INTO ChiTietDonHangBan 
                    (id_don_hang_ban, id_san_pham, so_luong, 
                     gia_ban_niem_yet_don_vi, giam_gia, ghi_chu) 
                VALUES (%s, %s, %s, %s, %s, %s)
                RETURNING id;
            """
            cur.execute(sql_add_item, (id_don_hang_ban, id_san_pham, so_luong,
                                       gia_ban_niem_yet_don_vi, giam_gia, ghi_chu_item))
            fetch_result = cur.fetchone()
            if fetch_result:
                id_chi_tiet_don_hang_ban_moi = fetch_result[0]
            else:
                raise psycopg2.Error("Không thể thêm chi tiết đơn hàng bán, không nhận được ID trả về.")

            # Không còn gọi hàm Python để cập nhật tổng cho DonHangBan nữa.
            conn.commit()
            print(f"Sản phẩm ID {id_san_pham} (SL: {so_luong}) đã được thêm vào Đơn Hàng Bán ID {id_don_hang_ban} "
                  f"(Chi tiết ID: {id_chi_tiet_don_hang_ban_moi}). Trigger SQL sẽ xử lý các tính toán chi tiết.")
    except psycopg2.Error as e:
        print(f"Lỗi khi thêm sản phẩm vào Đơn Hàng Bán: {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return id_chi_tiet_don_hang_ban_moi


def get_donhangban(status_don_hang_filter=None, trang_thai_thanh_toan_filter=None,
                     customer_id_filter=None, date_from_str=None, date_to_str=None):
    conn = get_db_connection()
    if not conn:
        return None

    orders = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            # Schema DonHangBan (Source 1, page 4) có id_nhan_vien
            base_sql = """
                SELECT dhb.*, kh.ten_khach_hang, nv.ten_nhan_vien
                FROM DonHangBan dhb
                LEFT JOIN KhachHang kh ON dhb.id_khach_hang = kh.id
                JOIN NhanVien nv ON dhb.id_nhan_vien = nv.id 
            """
            conditions = []
            params = []

            if status_don_hang_filter:
                conditions.append("dhb.trang_thai_don_hang = %s")
                params.append(status_don_hang_filter)
            if trang_thai_thanh_toan_filter:
                conditions.append("dhb.trang_thai_thanh_toan = %s")
                params.append(trang_thai_thanh_toan_filter)
            if customer_id_filter is not None:
                if customer_id_filter == 0 or str(customer_id_filter).lower() == 'null':
                    conditions.append("dhb.id_khach_hang IS NULL")
                else:
                    conditions.append("dhb.id_khach_hang = %s")
                    params.append(customer_id_filter)

            if date_from_str:
                try:
                    date_from = date.fromisoformat(date_from_str)
                    conditions.append("DATE(dhb.ngay_dat_hang) >= %s")
                    params.append(date_from)
                except ValueError:
                    print(f"Lỗi: Định dạng ngày bắt đầu '{date_from_str}' không hợp lệ.")

            if date_to_str:
                try:
                    date_to = date.fromisoformat(date_to_str)
                    conditions.append("DATE(dhb.ngay_dat_hang) <= %s")
                    params.append(date_to)
                except ValueError:
                    print(f"Lỗi: Định dạng ngày kết thúc '{date_to_str}' không hợp lệ.")

            if conditions:
                base_sql += " WHERE " + " AND ".join(conditions)

            base_sql += " ORDER BY dhb.ngay_dat_hang DESC, dhb.id DESC;"

            cur.execute(base_sql, tuple(params))
            # Các cột tổng (tong_doanh_thu, tong_gia_von) nếu có trong DonHangBan sẽ được lấy từ DB.
            # Nếu không có, chúng sẽ không xuất hiện ở đây.
            orders = [dict(row) for row in cur.fetchall()]
            print(f"Đã truy vấn được {len(orders)} đơn hàng bán.")

    except psycopg2.Error as e:
        print(f"Lỗi khi truy vấn danh sách đơn hàng bán: {e}")
        return None
    finally:
        close_db_connection(conn)
    return orders


def get_chitietdonhangban(id_don_hang_ban):
    """
    Xem chi tiết một Đơn Hàng Bán.
    Tính toán động tổng doanh thu và tổng giá vốn của toàn bộ đơn hàng bằng cách SUM từ các chi tiết.
    """
    conn = get_db_connection()
    if not conn:
        return None

    order_info = None
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            # 1. Lấy thông tin chung của Đơn Hàng Bán
            sql_order = """
                SELECT dhb.*, kh.ten_khach_hang, kh.so_dien_thoai AS sdt_khach_hang, 
                       nv.ten_nhan_vien
                FROM DonHangBan dhb
                LEFT JOIN KhachHang kh ON dhb.id_khach_hang = kh.id
                JOIN NhanVien nv ON dhb.id_nhan_vien = nv.id 
                WHERE dhb.id = %s;
            """
            cur.execute(sql_order, (id_don_hang_ban,))
            order_data = cur.fetchone()
            if not order_data:
                print(f"Không tìm thấy Đơn Hàng Bán với ID: {id_don_hang_ban}")
                return None
            order_info = dict(order_data)

            # 2. Lấy danh sách sản phẩm chi tiết
            # Các cột tong_gia_ban, tong_gia_von của ChiTietDonHangBan được tính bởi trigger SQL
            sql_items = """
                SELECT ctdhb.*, sp.ten_san_pham, sp.don_vi_tinh
                FROM ChiTietDonHangBan ctdhb
                JOIN SanPham sp ON ctdhb.id_san_pham = sp.id
                WHERE ctdhb.id_don_hang_ban = %s
                ORDER BY sp.ten_san_pham;
            """
            cur.execute(sql_items, (id_don_hang_ban,))
            order_items = [dict(row) for row in cur.fetchall()]
            order_info['chi_tiet_san_pham'] = order_items

            # 3. Tính toán tổng doanh thu và tổng giá vốn của đơn hàng bằng SQL từ các chi tiết
            # ChiTietDonHangBan có cột tong_gia_ban và tong_gia_von được tính bởi trigger
            #
            cur.execute("""
                SELECT 
                    COALESCE(SUM(tong_gia_ban), 0) AS calculated_total_revenue,
                    COALESCE(SUM(tong_gia_von), 0) AS calculated_total_cogs
                FROM ChiTietDonHangBan
                WHERE id_don_hang_ban = %s;
            """, (id_don_hang_ban,))
            calculated_totals = cur.fetchone()

            order_info['calculated_total_order_revenue'] = calculated_totals[
                'calculated_total_revenue'] if calculated_totals else 0
            order_info['calculated_total_order_cogs'] = calculated_totals[
                'calculated_total_cogs'] if calculated_totals else 0

    except psycopg2.Error as e:
        print(f"Lỗi khi lấy chi tiết Đơn Hàng Bán ID {id_don_hang_ban}: {e}")
        return None
    finally:
        close_db_connection(conn)
    return order_info


def update_donhangban_status(id_don_hang_ban, new_trang_thai_don_hang,
                              new_trang_thai_thanh_toan=None,
                              ngay_giao_hang_du_kien_str=None,
                              ngay_giao_hang_thuc_te_str=None):
    conn = get_db_connection()
    if not conn:
        return False

    allowed_order_statuses = ['Chờ xác nhận', 'Đã xác nhận', 'Đang giao hàng', 'Đã giao', 'Hoàn tất', 'Đã hủy',
                              'Trả hàng']
    if new_trang_thai_don_hang not in allowed_order_statuses:
        print(f"Lỗi: Trạng thái đơn hàng '{new_trang_thai_don_hang}' không hợp lệ.")
        close_db_connection(conn)
        return False

    update_fields_sql_parts = ["trang_thai_don_hang = %s"]
    params = [new_trang_thai_don_hang]

    if new_trang_thai_thanh_toan:
        allowed_payment_statuses = ['Chưa thanh toán', 'Đã thanh toán']
        if new_trang_thai_thanh_toan not in allowed_payment_statuses:
            print(f"Lỗi: Trạng thái thanh toán '{new_trang_thai_thanh_toan}' không hợp lệ.")
        else:
            update_fields_sql_parts.append("trang_thai_thanh_toan = %s")
            params.append(new_trang_thai_thanh_toan)

    if ngay_giao_hang_du_kien_str:  # ngay_giao_hang_du_kien trong DonHangBan là DATE
        try:
            ngay_giao_du_kien = date.fromisoformat(ngay_giao_hang_du_kien_str)
            update_fields_sql_parts.append("ngay_giao_hang_du_kien = %s")
            params.append(ngay_giao_du_kien)
        except ValueError:
            print(
                f"Cảnh báo: Định dạng ngày giao hàng dự kiến '{ngay_giao_hang_du_kien_str}' không hợp lệ. Bỏ qua cập nhật trường này.")

    if ngay_giao_hang_thuc_te_str:  # ngay_giao_hang_thuc_te trong DonHangBan là DATE
        try:
            ngay_giao_thuc_te = date.fromisoformat(ngay_giao_hang_thuc_te_str)
            update_fields_sql_parts.append("ngay_giao_hang_thuc_te = %s")
            params.append(ngay_giao_thuc_te)
        except ValueError:
            print(
                f"Cảnh báo: Định dạng ngày giao hàng thực tế '{ngay_giao_hang_thuc_te_str}' không hợp lệ. Bỏ qua cập nhật trường này.")

    if len(params) == 1 and params[0] == new_trang_thai_don_hang and len(
            update_fields_sql_parts) == 1:  # Chỉ cập nhật trạng thái đơn hàng
        pass  # Vẫn tiếp tục vì trạng thái đơn hàng thay đổi
    elif len(params) == 0:  # Nếu không có gì để cập nhật
        print("Không có thông tin hợp lệ để cập nhật cho đơn hàng.")
        close_db_connection(conn)
        return False

    update_fields_sql_parts.append(
        "ngay_cap_nhat_ban_ghi = CURRENT_TIMESTAMP")  # Luôn cập nhật thời gian (trigger xử lý)
    # Nếu không có trigger, ta tự cập nhật

    params.append(id_don_hang_ban)
    # Trigger trg_donhangban_cap_nhat_ngay_gio_sua sẽ tự động cập nhật ngay_cap_nhat_ban_ghi
    # nên ta có thể bỏ phần "ngay_cap_nhat_ban_ghi = CURRENT_TIMESTAMP" nếu trigger đó hoạt động.
    # Giả sử trigger hoạt động:
    if "ngay_cap_nhat_ban_ghi = CURRENT_TIMESTAMP" in update_fields_sql_parts:
        update_fields_sql_parts.remove("ngay_cap_nhat_ban_ghi = CURRENT_TIMESTAMP")

    if not update_fields_sql_parts:  # Nếu chỉ còn id_don_hang_ban trong params sau khi loại bỏ ngay_cap_nhat
        print("Không có thông tin nào để cập nhật (ngoại trừ ngày cập nhật tự động bởi trigger).")
        close_db_connection(conn)
        return True  # Coi như thành công vì không có gì để thay đổi từ phía Python

    sql = f"UPDATE DonHangBan SET {', '.join(update_fields_sql_parts)} WHERE id = %s;"

    try:
        with conn.cursor() as cur:
            cur.execute(sql, tuple(params))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Thông tin Đơn Hàng Bán ID {id_don_hang_ban} đã được cập nhật.")
                return True
            else:
                # Kiểm tra xem đơn hàng có tồn tại không
                cur_check = conn.cursor()
                cur_check.execute("SELECT 1 FROM DonHangBan WHERE id = %s", (id_don_hang_ban,))
                order_exists = cur_check.fetchone()
                cur_check.close()
                if not order_exists:
                    print(f"Không tìm thấy Đơn Hàng Bán ID {id_don_hang_ban} để cập nhật.")
                    conn.rollback()
                    return False
                else:
                    print(
                        f"Không có thay đổi dữ liệu nào cho Đơn Hàng Bán ID {id_don_hang_ban} (có thể các giá trị mới giống giá trị cũ). Trigger ngay_cap_nhat_ban_ghi vẫn sẽ chạy.")
                    conn.commit()  # Commit để trigger ngay_cap_nhat_ban_ghi chạy
                    return True
    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật Đơn Hàng Bán ID {id_don_hang_ban}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)