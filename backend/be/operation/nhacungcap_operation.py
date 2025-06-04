import psycopg2
import psycopg2.extras
from be.db_connection import get_db_connection, close_db_connection

def get_all_nhacungcap():
    conn = get_db_connection()
    if not conn:
        return None
    nhacungcap = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = "SELECT * FROM NhaCungCap ORDER BY ma_nha_cung_cap;"
            cur.execute(sql)
            suppliers = [dict(row) for row in cur.fetchall()]
            print(f"Đã truy vấn được {len(nhacungcap)} nhà cung cấp.")
    except psycopg2.Error as e:
        print(f"Lỗi khi truy vấn nhà cung cấp: {e}")
        return None
    finally:
        close_db_connection(conn)
    return nhacungcap

def add_nhacungcap(ma_nha_cung_cap, ten_nha_cung_cap, dia_chi=None,
                 so_dien_thoai=None, email=None, nguoi_lien_he=None, ghi_chu=None):
    conn = get_db_connection()
    if not conn:
        return None
    new_nhacungcap_id = None
    sql = """
        INSERT INTO NhaCungCap 
            (ma_nha_cung_cap, ten_nha_cung_cap, dia_chi, so_dien_thoai, 
             email, nguoi_lien_he, ghi_chu)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        RETURNING id;
    """
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (ma_nha_cung_cap, ten_nha_cung_cap, dia_chi, so_dien_thoai, email, nguoi_lien_he, ghi_chu))
            fetch_result = cur.fetchone()
            if fetch_result:
                new_nhacungcap_id = fetch_result[0]
            conn.commit()
            print(f"Nhà cung cấp '{ten_nha_cung_cap}' đã được thêm thành công với ID: {new_nhacungcap_id}.")
    except psycopg2.Error as e:
        print(f"Lỗi khi thêm nhà cung cấp '{ten_nha_cung_cap}': {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return new_nhacungcap_id

def search_nhacungcap_by_name(name_term):
    conn = get_db_connection()
    if not conn:
        return None
    nhacungcap = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = "SELECT * FROM NhaCungCap WHERE ten_nha_cung_cap ILIKE %s ORDER BY ma_nha_cung_cap;"
            cur.execute(sql, (f"%{name_term}%",))
            suppliers = [dict(row) for row in cur.fetchall()]
            print(f"Tìm thấy {len(nhacungcap)} nhà cung cấp với tên chứa '{name_term}'.")
    except psycopg2.Error as e:
        print(f"Lỗi khi tìm kiếm nhà cung cấp theo tên: {e}")
        return None
    finally:
        close_db_connection(conn)
    return nhacungcap

def search_nhacungcap_by_phone(phone_term):
    conn = get_db_connection()
    if not conn:
        return None
    nhacungcap = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = "SELECT * FROM NhaCungCap WHERE so_dien_thoai LIKE %s ORDER BY ma_nha_cung_cap;"
            cur.execute(sql, (f"%{phone_term}%",))
            nhacungcap = [dict(row) for row in cur.fetchall()]
            print(f"Tìm thấy {len(nhacungcap)} nhà cung cấp với SĐT chứa '{phone_term}'.")
    except psycopg2.Error as e:
        print(f"Lỗi khi tìm kiếm nhà cung cấp theo SĐT: {e}")
        return None
    finally:
        close_db_connection(conn)
    return nhacungcap

def search_nhacungcap_by_email(email_term):
    conn = get_db_connection()
    if not conn:
        return None
    nhacungcap = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = "SELECT * FROM NhaCungCap WHERE email ILIKE %s ORDER BY ma_nha_cung_cap;"
            cur.execute(sql, (f"%{email_term}%",))
            nhacungcap = [dict(row) for row in cur.fetchall()]
            print(f"Tìm thấy {len(nhacungcap)} nhà cung cấp với email chứa '{email_term}'.")
    except psycopg2.Error as e:
        print(f"Lỗi khi tìm kiếm nhà cung cấp theo email: {e}")
        return None
    finally:
        close_db_connection(conn)
    return nhacungcap


def update_nhacungcap_info(supplier_id, **kwargs):
    conn = get_db_connection()
    if not conn:
        return False

    allowed_fields = ['ma_nha_cung_cap', 'ten_nha_cung_cap', 'dia_chi',
                      'so_dien_thoai', 'email', 'nguoi_lien_he', 'ghi_chu']

    update_fields = []
    params = []

    for key, value in kwargs.items():
        if key in allowed_fields:
            update_fields.append(f"{key} = %s")
            params.append(value)

    if not update_fields:
        print("Không có thông tin hợp lệ nào được cung cấp để cập nhật nhà cung cấp.")
        return False

    params.append(supplier_id)

    try:
        with conn.cursor() as cur:
            sql = f"""
                UPDATE NhaCungCap
                SET {', '.join(update_fields)} 
                WHERE id = %s;
            """
            cur.execute(sql, tuple(params))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Nhà cung cấp với ID {supplier_id} đã được cập nhật thông tin.")
                return True
            else:
                print(f"Không tìm thấy nhà cung cấp với ID {supplier_id} hoặc không có dữ liệu nào thay đổi.")
                return False
    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật thông tin nhà cung cấp ID {supplier_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)