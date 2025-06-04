import psycopg2
import psycopg2.extras
from be.db_connection import get_db_connection, close_db_connection
from datetime import date


def get_all_khachhang():
    conn = get_db_connection()
    if not conn:
        return None
    khachhang = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = "SELECT * FROM KhachHang ORDER BY ten_khach_hang;"  # [cite: 26]
            cur.execute(sql)
            khachhang = [dict(row) for row in cur.fetchall()]
            print(f"Đã truy vấn được {len(khachhang)} khách hàng.")
    except psycopg2.Error as e:
        print(f"Lỗi khi truy vấn khách hàng: {e}")
        return None
    finally:
        close_db_connection(conn)
    return khachhang


def add_khachhang(ten_khach_hang, so_dien_thoai, email, dia_chi=None, ngay_sinh=None, gioi_tinh=None):
    conn = get_db_connection()
    if not conn:
        return None

    new_khachhang_id = None

    # Validate gioi_tinh
    allowed_gender = ['Nam', 'Nữ', 'Khác', None]  # [cite: 27]
    if gioi_tinh not in allowed_gender:
        print(f"Lỗi: Giới tính '{gioi_tinh}' không hợp lệ. Chỉ chấp nhận 'Nam', 'Nữ', 'Khác' hoặc để trống.")
        return None

    # Chuyển đổi ngay_sinh sang đối tượng date nếu nó là string
    if isinstance(ngay_sinh, str):
        try:
            ngay_sinh = date.fromisoformat(ngay_sinh)
        except ValueError:
            print(f"Lỗi: Định dạng ngày sinh '{ngay_sinh}' không hợp lệ. Vui lòng sử dụng 'YYYY-MM-DD'.")
            return None

    sql = """
        INSERT INTO KhachHang 
            (ten_khach_hang, so_dien_thoai, email, dia_chi, ngay_sinh, gioi_tinh)
        VALUES (%s, %s, %s, %s, %s, %s)
        RETURNING id;
    """
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (ten_khach_hang, so_dien_thoai, email,
                              dia_chi, ngay_sinh, gioi_tinh))
            fetch_result = cur.fetchone()
            if fetch_result:
                new_khachhang_id = fetch_result[0]
            conn.commit()
            print(f"Khách hàng '{ten_khach_hang}' đã được thêm thành công với ID: {new_khachhang_id}.")
    except psycopg2.Error as e:
        if e.pgcode == '23505':
            print(f"Lỗi khi thêm khách hàng '{ten_khach_hang}': Email hoặc Số điện thoại đã tồn tại. {e}")
        else:
            print(f"Lỗi khi thêm khách hàng '{ten_khach_hang}': {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return new_khachhang_id


def update_khachhang_info(customer_id, **kwargs):  # [cite: 26]
    conn = get_db_connection()
    if not conn:
        return False

    allowed_fields = ['ten_khach_hang', 'so_dien_thoai', 'email',
                      'dia_chi', 'ngay_sinh', 'gioi_tinh']  # [cite: 28, 29, 30, 31, 32, 33]

    update_fields_clauses = []
    params = []

    for key, value in kwargs.items():
        if key in allowed_fields:
            if key == 'gioi_tinh':
                allowed_gender = ['Nam', 'Nữ', 'Khác', None]  # [cite: 27]
                if value not in allowed_gender:
                    print(
                        f"Lỗi: Giới tính '{value}' không hợp lệ cho cập nhật. Chỉ chấp nhận 'Nam', 'Nữ', 'Khác' hoặc để trống.")
                    return False

            if key == 'ngay_sinh' and isinstance(value, str):  # [cite: 32]
                try:
                    value = date.fromisoformat(value)
                except ValueError:
                    print(
                        f"Lỗi: Định dạng ngày sinh '{value}' không hợp lệ cho cập nhật. Vui lòng sử dụng 'YYYY-MM-DD'.")
                    return False

            update_fields_clauses.append(f"{key} = %s")
            params.append(value)

    if not update_fields_clauses:
        print("Không có thông tin hợp lệ nào được cung cấp để cập nhật khách hàng.")
        return False

    params.append(customer_id)

    try:
        with conn.cursor() as cur:
            sql = f"""
                UPDATE KhachHang
                SET {', '.join(update_fields_clauses)} 
                WHERE id = %s;
            """
            cur.execute(sql, tuple(params))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Khách hàng với ID {customer_id} đã được cập nhật thông tin.")
                return True
            else:
                print(f"Không tìm thấy khách hàng với ID {customer_id} hoặc không có dữ liệu nào thay đổi.")
                return False
    except psycopg2.Error as e:
        if e.pgcode == '23505':
            print(
                f"Lỗi khi cập nhật khách hàng ID {customer_id}: Email hoặc Số điện thoại cập nhật đã tồn tại ở khách hàng khác. {e}")
        else:
            print(f"Lỗi khi cập nhật thông tin khách hàng ID {customer_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)