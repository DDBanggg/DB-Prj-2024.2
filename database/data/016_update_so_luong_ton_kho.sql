-- Bước 1: Tạo bảng tạm tính tổng số lượng nhập thực tế (nếu chưa có trong session)
CREATE TEMP TABLE Temp_TongNhapThucTe AS
SELECT
    ctdn.id_san_pham,
    SUM(ctdn.so_luong) AS tong_nhap
FROM
    ChiTietDonHangNhap ctdn
JOIN
    DonHangNhap dhn ON ctdn.id_don_hang_nhap = dhn.id
WHERE
    dhn.trang_thai <> 'Đã hủy'
GROUP BY
    ctdn.id_san_pham;

-- Bước 2: Tạo bảng tạm tính tổng số lượng bán thực tế (nếu chưa có trong session)
CREATE TEMP TABLE Temp_TongBanThucTe AS
SELECT
    ctdb.id_san_pham,
    SUM(ctdb.so_luong) AS tong_ban
FROM
    ChiTietDonHangBan ctdb
JOIN
    DonHangBan dhb ON ctdb.id_don_hang_ban = dhb.id
WHERE
    dhb.trang_thai_don_hang NOT IN ('Đã hủy', 'Trả hàng')
GROUP BY
    ctdb.id_san_pham;

-- Bước 3: Cập nhật so_luong_ton_kho trong bảng SanPham
UPDATE SanPham
SET so_luong_ton_kho = GREATEST(0, 10 + (COALESCE(tnt.tong_nhap, 0) - COALESCE(tbt.tong_ban, 0)))
FROM
    SanPham sp_alias
LEFT JOIN
    Temp_TongNhapThucTe tnt ON sp_alias.id = tnt.id_san_pham
LEFT JOIN
    Temp_TongBanThucTe tbt ON sp_alias.id = tbt.id_san_pham
WHERE
    SanPham.id = sp_alias.id;

-- Dọn dẹp bảng tạm (tùy chọn, sẽ tự mất khi session kết thúc)
DROP TABLE IF EXISTS Temp_TongNhapThucTe;
DROP TABLE IF EXISTS Temp_TongBanThucTe;