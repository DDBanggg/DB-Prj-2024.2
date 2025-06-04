import psycopg2
import psycopg2.extras
from datetime import date  # Vẫn có thể cần cho các trường date khác nếu có
from be.db_connection import get_db_connection, close_db_connection

def get_all_nhanvien():
    conn = get_db_connection()
    if not conn:
        return None
    nhanvien = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = "SELECT * FROM NhanVien ORDER BY ten_nhan_vien;"
            cur.execute(sql)
            nhanvien = [dict(row) for row in cur.fetchall()]
            print(f"Đã truy vấn được {len(nhanvien)} nhân viên.")
    except psycopg2.Error as e:
        print(f"Lỗi khi truy vấn nhân viên: {e}")
        return None
    finally:
        close_db_connection(conn)
    return nhanvien


def add_nhanvien(ten_nhan_vien, ten_dang_nhap, mat_khau, email, so_dien_thoai, vai_tro='Nhân viên', trang_thai='Đang làm việc'):
    conn = get_db_connection()
    if not conn:
        return None

    allowed_roles = ['Nhân viên', 'Quản lý']
    if vai_tro not in allowed_roles:
        print(f"Lỗi: Vai trò '{vai_tro}' không hợp lệ. Chỉ chấp nhận: {', '.join(allowed_roles)}")
        return None

    allowed_statuses = ['Đang làm việc', 'Đã nghỉ việc']
    if trang_thai not in allowed_statuses:
        print(f"Lỗi: Trạng thái '{trang_thai}' không hợp lệ. Chỉ chấp nhận: {', '.join(allowed_statuses)}")
        return None

    new_nhanvien_id = None
    sql = """
        INSERT INTO NhanVien 
            (ten_nhan_vien, ten_dang_nhap, mat_khau, email, so_dien_thoai, vai_tro, trang_thai)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        RETURNING id;
    """
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (ten_nhan_vien, ten_dang_nhap, mat_khau, email, so_dien_thoai, vai_tro, trang_thai))
            fetch_result = cur.fetchone()
            if fetch_result:
                new_nhanvien_id = fetch_result[0]
            conn.commit()
            print(
                f"Nhân viên '{ten_nhan_vien}' (Tên đăng nhập: {ten_dang_nhap}) đã được thêm với ID: {new_nhanvien_id}.")
    except psycopg2.Error as e:
        if e.pgcode == '23505':  # Unique violation
            print(f"Lỗi khi thêm nhân viên '{ten_nhan_vien}': Tên đăng nhập, Email hoặc Số điện thoại đã tồn tại. {e}")
        else:
            print(f"Lỗi khi thêm nhân viên '{ten_nhan_vien}': {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return new_nhanvien_id


def update_nhanvien_info(employee_id, **kwargs):
    conn = get_db_connection()
    if not conn:
        return False

    allowed_fields = ['ten_nhan_vien', 'email', 'so_dien_thoai']

    update_clauses = []
    params = []

    for key, value in kwargs.items():
        if key in allowed_fields:
            update_clauses.append(f"{key} = %s")
            params.append(value)

    if not update_clauses:
        print("Không có thông tin hợp lệ nào được cung cấp để cập nhật.")
        return False

    params.append(employee_id)

    try:
        with conn.cursor() as cur:
            sql = f"UPDATE NhanVien SET {', '.join(update_clauses)} WHERE id = %s;"
            cur.execute(sql, tuple(params))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Thông tin nhân viên ID {employee_id} đã được cập nhật.")
                return True
            else:
                print(f"Không tìm thấy nhân viên ID {employee_id} hoặc không có dữ liệu thay đổi.")
                return False
    except psycopg2.Error as e:
        if e.pgcode == '23505':  # Unique violation
            print(f"Lỗi khi cập nhật nhân viên ID {employee_id}: Email hoặc Số điện thoại cập nhật đã tồn tại. {e}")
        else:
            print(f"Lỗi khi cập nhật thông tin nhân viên ID {employee_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)


def update_nhanvien_status(employee_id, new_status):
    conn = get_db_connection()
    if not conn:
        return False

    allowed_statuses = ['Đang làm việc', 'Đã nghỉ việc']
    if new_status not in allowed_statuses:
        print(f"Trạng thái '{new_status}' không hợp lệ. Chỉ chấp nhận: {', '.join(allowed_statuses)}")
        return False

    sql = "UPDATE NhanVien SET trang_thai = %s WHERE id = %s;"
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (new_status, employee_id))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Trạng thái của nhân viên ID {employee_id} đã được cập nhật thành '{new_status}'.")
                return True
            else:
                print(f"Không tìm thấy nhân viên ID {employee_id} để cập nhật trạng thái.")
                return False
    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật trạng thái cho nhân viên ID {employee_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)


def update_nhanvien_role(employee_id, new_role):
    conn = get_db_connection()
    if not conn:
        return False

    allowed_roles = ['Nhân viên', 'Quản lý']
    if new_role not in allowed_roles:
        print(f"Lỗi: Vai trò '{new_role}' không hợp lệ. Chỉ chấp nhận: {', '.join(allowed_roles)}")
        return False

    sql = "UPDATE NhanVien SET vai_tro = %s WHERE id = %s;"
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (new_role, employee_id))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Vai trò của nhân viên ID {employee_id} đã được cập nhật thành '{new_role}'.")
                return True
            else:
                print(f"Không tìm thấy nhân viên ID {employee_id} để cập nhật vai trò.")
                return False
    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật vai trò cho nhân viên ID {employee_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)

