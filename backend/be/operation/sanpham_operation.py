import psycopg2
import psycopg2.extras
from be.db_connection import get_db_connection, close_db_connection

def get_all_sanpham_with_danhmuc():
    conn = get_db_connection()
    if not conn:
        return None
    sanpham = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = """
                SELECT sp.*, dm.ten_danh_muc 
                FROM SanPham sp
                JOIN DanhMuc dm ON sp.id_danh_muc = dm.id
                ORDER BY sp.ma_san_pham;
            """
            cur.execute(sql)
            sanpham = [dict(row) for row in cur.fetchall()]
            print(f"Đã truy vấn được {len(sanpham)} sản phẩm (kèm tên danh mục).")
    except psycopg2.Error as e:
        print(f"Lỗi khi truy vấn sản phẩm: {e}")
        return None
    finally:
        close_db_connection(conn)
    return sanpham

def search_sanpham_by_name(search_term):
    conn = get_db_connection()
    if not conn:
        return None
    sanpham = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = """
                SELECT sp.*, dm.ten_danh_muc 
                FROM SanPham sp
                JOIN DanhMuc dm ON sp.id_danh_muc = dm.id
                WHERE sp.ten_san_pham ILIKE %s
                ORDER BY sp.ma_san_pham;
            """
            cur.execute(sql, (f"%{search_term}%",))
            sanpham = [dict(row) for row in cur.fetchall()]
            print(f"Tìm thấy {len(sanpham)} sản phẩm với từ khóa '{search_term}'.")
    except psycopg2.Error as e:
        print(f"Lỗi khi tìm kiếm sản phẩm: {e}")
        return None
    finally:
        close_db_connection(conn)
    return sanpham

def filter_sanpham_by_danhmuc(danh_muc_id):
    conn = get_db_connection()
    if not conn:
        return None
    sanpham = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = """
                SELECT sp.*, dm.ten_danh_muc 
                FROM SanPham sp
                JOIN DanhMuc dm ON sp.id_danh_muc = dm.id
                WHERE sp.id_danh_muc = %s
                ORDER BY sp.ma_san_pham;
            """
            cur.execute(sql, (danh_muc_id,))
            sanpham = [dict(row) for row in cur.fetchall()]
            print(f"Tìm thấy {len(sanpham)} sản phẩm thuộc danh mục ID: {danh_muc_id}.")
    except psycopg2.Error as e:
        print(f"Lỗi khi lọc sản phẩm theo danh mục: {e}")
        return None
    finally:
        close_db_connection(conn)
    return sanpham

def get_low_stock_sanpham(threshold):
    conn = get_db_connection()
    if not conn:
        return None
    sanpham = []
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql = """
                SELECT sp.*, dm.ten_danh_muc 
                FROM SanPham sp
                JOIN DanhMuc dm ON sp.id_danh_muc = dm.id
                WHERE sp.so_luong_ton_kho <= %s
                ORDER BY sp.so_luong_ton_kho ASC, sp.ma_san_pham;
            """
            cur.execute(sql, (threshold,))
            sanpham = [dict(row) for row in cur.fetchall()]
            print(f"Tìm thấy {len(sanpham)} sản phẩm có số lượng tồn kho <= {threshold}.")
    except psycopg2.Error as e:
        print(f"Lỗi khi lấy sản phẩm sắp hết hàng: {e}")
        return None
    finally:
        close_db_connection(conn)
    return sanpham

def add_sanpham(ma_san_pham, ten_san_pham, id_danh_muc, so_luong_ton_kho, don_vi_tinh, mo_ta_chi_tiet=None, duong_dan_hinh_anh_chinh=None, trang_thai='Đang kinh doanh - Còn hàng'):
    conn = get_db_connection()
    if not conn:
        return None
    new_sanpham_id = None
    sql = """
        INSERT INTO SanPham 
            (ma_san_pham, ten_san_pham, id_danh_muc, so_luong_ton_kho, don_vi_tinh, 
             mo_ta_chi_tiet, duong_dan_hinh_anh_chinh, trang_thai)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        RETURNING id;
    """
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (ma_san_pham, ten_san_pham, id_danh_muc, so_luong_ton_kho, don_vi_tinh, mo_ta_chi_tiet, duong_dan_hinh_anh_chinh, trang_thai))
            fetch_result = cur.fetchone()
            if fetch_result:
                new_sanpham_id = fetch_result[0]
            conn.commit()
            print(f"Sản phẩm '{ten_san_pham}' đã được thêm thành công với ID: {new_sanpham_id}.")
    except psycopg2.Error as e:
        print(f"Lỗi khi thêm sản phẩm '{ten_san_pham}': {e}")
        if conn:
            conn.rollback()
        return None
    finally:
        close_db_connection(conn)
    return new_sanpham_id


def update_sanpham_info(sanpham_id, **kwargs):
    conn = get_db_connection()
    if not conn:
        return False

    allowed_fields = ['ma_san_pham', 'ten_san_pham', 'id_danh_muc',
                      'so_luong_ton_kho', 'don_vi_tinh', 'mo_ta_chi_tiet',
                      'duong_dan_hinh_anh_chinh']

    update_fields = []
    params = []

    for key, value in kwargs.items():
        if key in allowed_fields:
            update_fields.append(f"{key} = %s")
            params.append(value)

    if not update_fields:
        print("Không có thông tin hợp lệ nào được cung cấp để cập nhật sản phẩm.")
        return False

    params.append(sanpham_id)

    try:
        with conn.cursor() as cur:
            sql = f"""
                UPDATE SanPham
                SET {', '.join(update_fields)} 
                WHERE id = %s;
            """
            cur.execute(sql, tuple(params))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Sản phẩm với ID {sanpham_id} đã được cập nhật thông tin.")
                return True
            else:
                print(f"Không tìm thấy sản phẩm với ID {sanpham_id} hoặc không có dữ liệu nào thay đổi.")
                return False
    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật thông tin sản phẩm ID {sanpham_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)

def update_sanpham_status(sanpham_id, new_status):
    conn = get_db_connection()
    if not conn:
        return False

    allowed_statuses = ['Đang kinh doanh - Còn hàng', 'Đang kinh doanh - Hết hàng', 'Ngừng kinh doanh']
    if new_status not in allowed_statuses:
        print(f"Trạng thái '{new_status}' không hợp lệ. Các trạng thái được phép: {', '.join(allowed_statuses)}")
        return False

    sql = "UPDATE SanPham SET trang_thai = %s WHERE id = %s;"
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (new_status, sanpham_id))
            updated_rows = cur.rowcount
            if updated_rows > 0:
                conn.commit()
                print(f"Trạng thái của sản phẩm ID {sanpham_id} đã được cập nhật thành '{new_status}'.")
                return True
            else:
                print(f"Không tìm thấy sản phẩm với ID {sanpham_id} để cập nhật trạng thái.")
                return False
    except psycopg2.Error as e:
        print(f"Lỗi khi cập nhật trạng thái sản phẩm ID {sanpham_id}: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        close_db_connection(conn)