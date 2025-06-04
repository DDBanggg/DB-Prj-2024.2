import psycopg2
import psycopg2.extras
from be .db_connection import get_db_connection, close_db_connection

def get_all_danhmuc():
    conn = get_db_connection() # kết nối tới db
    if not conn:
        return None

    result = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = """
                SELECT id, ma_danh_muc, ten_danh_muc, mo_ta, ngay_tao
                FROM DanhMuc
                ORDER BY id;
            """
            # Thực thi câu lệnh sql
            cur.execute(sql)
            result = [dict(row) for row in cur.fetchall()]
    except psycopg2.Error as e:
        print(f"ERROR")
        return None
    finally:
        close_db_connection(conn)
    return result

def add_danhmuc(ma_danh_muc, ten_danh_muc, mo_ta=None):
    conn = get_db_connection()
    if not conn:
        return None

    new_danhmuc_id = None
    try:
        with conn.cursor() as cur:
            sql = """
                INSERT INTO DanhMuc (ma_danh_muc, ten_danh_muc, mo_ta)
                VALUES (%s, %s, %s)
                RETURNING id; 
            """
            cur.execute(sql, (ma_danh_muc, ten_danh_muc, mo_ta))
            fetch_result = cur.fetchone()
            if fetch_result:
                new_danhmuc_id = fetch_result[0]

            conn.commit()
    except psycopg2.Error as e:
        print(f"Lỗi khi thêm danh mục {ten_danh_muc} : {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)

    return new_danhmuc_id

def update_danhmuc(danh_muc_id, ten_danh_muc = None, mo_ta = None, ma_danh_muc = None):
    conn = get_db_connection()
    if not conn:
        return False
    update_fields = []
    params = []

    if ten_danh_muc is not None:
        update_fields.append("ten_danh_muc = %s")
        params.append(ten_danh_muc)
    if mo_ta is not None:
        update_fields.append("mo_ta = %s")
        params.append(mo_ta)
    if ma_danh_muc is not None:
        update_fields.append("ma_danh_muc = %s")
        params.append(ma_danh_muc)
    if not update_fields:
        print("Không có thông tin nào được cung cấp để cập nhật danh mục.")
        return False

    params.append(danh_muc_id)

    try:
        with conn.cursor() as cur:
            sql = f"""
            UPDATE DanhMuc
            SET {', '.join(update_fields)}
            WHERE id = %s;
        """
        cur.execute(sql, tuple(params))

        update_rows = cur.rowcount

        if update_rows > 0:
            conn.commit()
            print(f"Danh mục với ID {danh_muc_id} đã được cập nhật thành công.")
            return True
        else:
            print(f"Không tìm thấy danh mục với ID {danh_muc_id}, hoặc không có dữ liệu nào được thay đổi")
            return False

    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật danh mục với ID {danh_muc_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)