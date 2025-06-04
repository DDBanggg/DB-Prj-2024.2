import psycopg2
import psycopg2.extras
from datetime import date
# Giả sử 'be' là thư mục gốc của backend trong PYTHONPATH của bạn
# Nếu file này nằm trong thư mục 'backend' và db_connection.py cũng vậy,
# thì import nên là from .db_connection import ... (relative import)
# Hoặc nếu chạy từ thư mục gốc của project, và 'be' là một package:
from be.db_connection import get_db_connection, close_db_connection  # Giữ nguyên theo code của bạn


# Hàm _update_donhangnhap_total_value ĐÃ ĐƯỢC LOẠI BỎ
# vì trigger trg_cap_nhat_tong_gia_tri_nhap sẽ xử lý việc này.

# --- Các hàm quản lý Đơn Hàng Nhập ---

def create_donhangnhap(id_nha_cung_cap, id_nhan_vien,
                       ngay_dat_hang_str=None, ngay_du_kien_nhan_hang_str=None,
                       trang_thai='Chờ xác nhận', ghi_chu=None):
    """
    Tạo một Đơn Hàng Nhập mới.
    tong_gia_tri ban đầu sẽ là 0, trigger sẽ cập nhật sau khi chi tiết được thêm.
    Schema DonHangNhap (Source 1, page 3)
    """
    conn = get_db_connection()
    if not conn:
        return None

    # Xử lý ngày tháng
    actual_ngay_dat_hang_for_sql = None
    if ngay_dat_hang_str:
        try:
            actual_ngay_dat_hang_for_sql = date.fromisoformat(ngay_dat_hang_str)
        except ValueError:
            print(f"Lỗi: Định dạng ngày đặt hàng '{ngay_dat_hang_str}' không hợp lệ (YYYY-MM-DD).")
            close_db_connection(conn)
            return None
    # Nếu actual_ngay_dat_hang_for_sql là None, psycopg2 sẽ truyền NULL,
    # và DB sẽ sử dụng DEFAULT CURRENT_DATE cho cột ngay_dat_hang (kiểu DATE).

    ngay_du_kien_nhan_h = None
    if ngay_du_kien_nhan_hang_str:
        try:
            ngay_du_kien_nhan_h = date.fromisoformat(ngay_du_kien_nhan_hang_str)
        except ValueError:
            print(f"Lỗi: Định dạng ngày dự kiến nhận hàng '{ngay_du_kien_nhan_hang_str}' không hợp lệ (YYYY-MM-DD).")
            close_db_connection(conn)
            return None

    # Xác thực trạng thái (VARCHAR(50) với CHECK constraint)
    allowed_statuses = ['Chờ xác nhận', 'Đã đặt hàng', 'Đang giao hàng', 'Hoàn tất', 'Đã hủy']
    if trang_thai not in allowed_statuses:
        print(f"Lỗi: Trạng thái '{trang_thai}' không hợp lệ. Các trạng thái được phép: {', '.join(allowed_statuses)}")
        close_db_connection(conn)
        return None

    new_donhangnhap_id = None
    # tong_gia_tri mặc định là 0 khi tạo mới.
    # ngay_nhan_hang_thuc_te sẽ NULL ban đầu.
    # ma_don_hang_nhap không có trong schema DonHangNhap (Source 1, page 3).
    # ngay_tao_ban_ghi, ngay_cap_nhat_ban_ghi có DEFAULT.
    sql = """
        INSERT INTO DonHangNhap 
            (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, 
             ngay_du_kien_nhan_hang, trang_thai, ghi_chu, tong_gia_tri)
        VALUES (%s, %s, %s, %s, %s, %s, 0) 
        RETURNING id;
    """
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (id_nha_cung_cap, id_nhan_vien, actual_ngay_dat_hang_for_sql,
                              ngay_du_kien_nhan_h, trang_thai, ghi_chu))
            fetch_result = cur.fetchone()
            if fetch_result:
                new_donhangnhap_id = fetch_result[0]
            conn.commit()
            print(
                f"Đơn Hàng Nhập mới đã được tạo với ID: {new_donhangnhap_id} (Tổng giá trị ban đầu là 0, sẽ được trigger cập nhật).")
    except psycopg2.Error as e:
        print(f"Lỗi khi tạo Đơn Hàng Nhập mới: {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return new_donhangnhap_id


def add_sanpham_to_donhangnhap(id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu_item=None):
    """
    Thêm một sản phẩm vào ChiTietDonHangNhap.
    Trigger 'trg_tinh_tong_gia_nhap' sẽ tính ChiTietDonHangNhap.tong_gia_nhap.
    Trigger 'trg_cap_nhat_tong_gia_tri_nhap' sẽ cập nhật DonHangNhap.tong_gia_tri.
    Schema ChiTietDonHangNhap (Source 1, page 3-4)
    """
    conn = get_db_connection()
    if not conn:
        return None

    # new_sanpham_id thực chất là id của ChiTietDonHangNhap
    id_chi_tiet_don_hang_nhap_moi = None

    # Cột tong_gia_nhap trong ChiTietDonHangNhap sẽ được trigger 'trg_tinh_tong_gia_nhap' tự động tính.
    # Python chỉ cần insert các giá trị cơ bản.
    # So_luong_con_lai cũng sẽ được trigger 'trigger_set_so_luong_con_lai' tự động gán bằng so_luong khi INSERT.
    sql_add_item = """
        INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu)
        VALUES (%s, %s, %s, %s, %s)
        RETURNING id; 
    """
    try:
        with conn.cursor() as cur:
            cur.execute(sql_add_item, (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu_item))
            fetch_result = cur.fetchone()
            if fetch_result:
                id_chi_tiet_don_hang_nhap_moi = fetch_result[0]
            else:
                # Nếu không có ID trả về, có lỗi insert, cần rollback
                raise psycopg2.Error("Không thể thêm chi tiết đơn hàng nhập, không nhận được ID trả về.")

            # Không cần gọi _update_donhangnhap_total_value ở đây nữa.
            # Trigger trg_cap_nhat_tong_gia_tri_nhap sẽ được kích hoạt sau khi INSERT vào ChiTietDonHangNhap thành công.
            conn.commit()
            print(
                f"Sản phẩm ID {id_san_pham} đã được thêm vào Đơn Hàng Nhập ID {id_don_hang_nhap} "
                f"(Chi tiết ID: {id_chi_tiet_don_hang_nhap_moi}). "
                "Trigger sẽ tự động cập nhật tổng giá trị."
            )
    except psycopg2.Error as e:
        print(f"Lỗi khi thêm sản phẩm vào Đơn Hàng Nhập: {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return id_chi_tiet_don_hang_nhap_moi  # Trả về ID của ChiTietDonHangNhap


def get_donhangnhap(status_filter=None, date_from_str=None, date_to_str=None):  # Sửa tên hàm
    """
    Xem danh sách Đơn Hàng Nhập, có thể lọc theo trạng thái và khoảng ngày đặt hàng.
    Bao gồm tên nhà cung cấp và tên nhân viên.
    """
    conn = get_db_connection()
    if not conn:
        return None

    orders = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            # Schema DonHangNhap (Source 1, page 3) có id_nhan_vien
            base_sql = """
                SELECT dhn.*, ncc.ten_nha_cung_cap, nv.ten_nhan_vien
                FROM DonHangNhap dhn
                JOIN NhaCungCap ncc ON dhn.id_nha_cung_cap = ncc.id
                JOIN NhanVien nv ON dhn.id_nhan_vien = nv.id 
            """
            conditions = []
            params = []

            if status_filter:
                conditions.append("dhn.trang_thai = %s")
                params.append(status_filter)

            if date_from_str:
                try:
                    date_from = date.fromisoformat(date_from_str)
                    conditions.append("dhn.ngay_dat_hang >= %s")  # ngay_dat_hang là DATE
                    params.append(date_from)
                except ValueError:
                    print(f"Lỗi: Định dạng ngày bắt đầu '{date_from_str}' không hợp lệ (YYYY-MM-DD).")
                    # Có thể return None hoặc bỏ qua điều kiện lọc này

            if date_to_str:
                try:
                    date_to = date.fromisoformat(date_to_str)
                    conditions.append("dhn.ngay_dat_hang <= %s")  # ngay_dat_hang là DATE
                    params.append(date_to)
                except ValueError:
                    print(f"Lỗi: Định dạng ngày kết thúc '{date_to_str}' không hợp lệ (YYYY-MM-DD).")
                    # Có thể return None hoặc bỏ qua điều kiện lọc này

            if conditions:
                base_sql += " WHERE " + " AND ".join(conditions)

            base_sql += " ORDER BY dhn.ngay_dat_hang DESC, dhn.id DESC;"

            cur.execute(base_sql, tuple(params))
            orders = [dict(row) for row in cur.fetchall()]
            print(f"Đã truy vấn được {len(orders)} đơn hàng nhập.")

    except psycopg2.Error as e:
        print(f"Lỗi khi truy vấn danh sách đơn hàng nhập: {e}")
        return None
    finally:
        close_db_connection(conn)
    return orders


def get_chitietdonhangnhap(id_don_hang_nhap):  # Giữ tên hàm của bạn
    """
    Xem chi tiết một Đơn Hàng Nhập, bao gồm thông tin chung và danh sách sản phẩm.
    """
    conn = get_db_connection()
    if not conn:
        return None

    order_info = None
    # order_items đã bị xóa khỏi đây vì nó không được sử dụng trực tiếp trong hàm này nữa
    # mà được gán vào order_info['chi_tiet_san_pham']
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql_order = """
                SELECT dhn.*, ncc.ten_nha_cung_cap, nv.ten_nhan_vien
                FROM DonHangNhap dhn
                JOIN NhaCungCap ncc ON dhn.id_nha_cung_cap = ncc.id
                JOIN NhanVien nv ON dhn.id_nhan_vien = nv.id 
                WHERE dhn.id = %s;
            """
            cur.execute(sql_order, (id_don_hang_nhap,))
            order_data = cur.fetchone()
            if not order_data:
                print(f"Không tìm thấy Đơn Hàng Nhập với ID: {id_don_hang_nhap}")
                return None
            order_info = dict(order_data)

            # ChiTietDonHangNhap có cột tong_gia_nhap (tính bằng trigger)
            sql_items = """
                SELECT ctdhn.*, sp.ten_san_pham, sp.don_vi_tinh
                FROM ChiTietDonHangNhap ctdhn
                JOIN SanPham sp ON ctdhn.id_san_pham = sp.id
                WHERE ctdhn.id_don_hang_nhap = %s
                ORDER BY sp.ten_san_pham;
            """
            cur.execute(sql_items, (id_don_hang_nhap,))
            order_items_list = [dict(row) for row in cur.fetchall()]  # Đổi tên biến để tránh nhầm lẫn

            order_info['chi_tiet_san_pham'] = order_items_list  # Gắn danh sách sản phẩm vào thông tin đơn hàng

    except psycopg2.Error as e:
        print(f"Lỗi khi lấy chi tiết Đơn Hàng Nhập ID {id_don_hang_nhap}: {e}")
        return None
    finally:
        close_db_connection(conn)
    return order_info


def update_donhangnhap_status(id_don_hang_nhap, new_status, ngay_nhan_hang_thuc_te_str=None):
    """
    Cập nhật trạng thái Đơn Hàng Nhập.
    Có thể cập nhật ngày nhận hàng thực tế khi trạng thái là 'Hoàn tất'.
    Trigger trg_after_update_donhangnhap_hoantat sẽ cập nhật tồn kho khi new_status='Hoàn tất'.
    Trigger trg_donhangnhap_cap_nhat_ngay_gio_sua sẽ cập nhật ngay_cap_nhat_ban_ghi.
    """
    conn = get_db_connection()
    if not conn:
        return False

    allowed_statuses = ['Chờ xác nhận', 'Đã đặt hàng', 'Đang giao hàng', 'Hoàn tất', 'Đã hủy']  #
    if new_status not in allowed_statuses:
        print(f"Lỗi: Trạng thái '{new_status}' không hợp lệ. Các trạng thái được phép: {', '.join(allowed_statuses)}")
        close_db_connection(conn)
        return False

    ngay_nhan_thuc_te = None
    update_fields_sql_parts = ["trang_thai = %s"]
    params = [new_status]

    if ngay_nhan_hang_thuc_te_str:
        try:
            ngay_nhan_thuc_te = date.fromisoformat(ngay_nhan_hang_thuc_te_str)
            update_fields_sql_parts.append("ngay_nhan_hang_thuc_te = %s")
            params.append(ngay_nhan_thuc_te)
        except ValueError:
            print(f"Lỗi: Định dạng ngày nhận hàng thực tế '{ngay_nhan_hang_thuc_te_str}' không hợp lệ (YYYY-MM-DD).")
            # Không đóng connection, cho phép các cập nhật khác vẫn diễn ra nếu có
            # Tuy nhiên, nếu đây là lỗi nghiêm trọng, có thể xem xét return False
            # close_db_connection(conn)
            # return False

    # ngay_cap_nhat_ban_ghi sẽ được cập nhật bởi trigger trg_donhangnhap_cap_nhat_ngay_gio_sua
    # theo tài liệu trigger, nên không cần thêm vào đây.

    if not update_fields_sql_parts:  # Sẽ không bao giờ rỗng vì trạng thái luôn được cập nhật
        print("Không có thông tin để cập nhật.")
        close_db_connection(conn)
        return False

    params.append(id_don_hang_nhap)
    sql = f"UPDATE DonHangNhap SET {', '.join(update_fields_sql_parts)} WHERE id = %s;"

    try:
        with conn.cursor() as cur:
            cur.execute(sql, tuple(params))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Trạng thái Đơn Hàng Nhập ID {id_don_hang_nhap} đã được cập nhật thành '{new_status}'.")
                return True
            else:
                # Kiểm tra xem đơn hàng có tồn tại không
                cur_check = conn.cursor()
                cur_check.execute("SELECT 1 FROM DonHangNhap WHERE id = %s", (id_don_hang_nhap,))
                if not cur_check.fetchone():
                    print(f"Không tìm thấy Đơn Hàng Nhập ID {id_don_hang_nhap} để cập nhật.")
                    # Không cần rollback vì chưa commit
                else:
                    print(
                        f"Không có thay đổi dữ liệu nào cho Đơn Hàng Nhập ID {id_don_hang_nhap} (có thể trạng thái mới giống trạng thái cũ).")
                cur_check.close()
                # Nếu không có dòng nào được cập nhật, có thể do ID không tồn tại hoặc dữ liệu không đổi
                # Không commit nếu không có dòng nào được update để tránh trigger ngay_cap_nhat_ban_ghi chạy không cần thiết nếu chỉ ID sai
                if updated_rows == 0 and not cur_check.fetchone():  # Thêm điều kiện kiểm tra lại
                    conn.rollback()
                else:  # Nếu ID tồn tại nhưng không có gì thay đổi, hoặc chỉ ngay_cap_nhat_ban_ghi thay đổi
                    conn.commit()  # Commit để trigger ngay_cap_nhat_ban_ghi (nếu có) chạy
                return False  # Trả về False nếu không có dòng nào thực sự được thay đổi (ngoài ngay_cap_nhat_ban_ghi)
    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật trạng thái Đơn Hàng Nhập ID {id_don_hang_nhap}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)