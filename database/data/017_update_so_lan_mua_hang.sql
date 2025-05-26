-- Bước 1: Tạo bảng tạm tính tổng số đơn hàng bán thành công cho mỗi khách hàng (nếu chưa có trong session)
CREATE TEMP TABLE Temp_TongDonHangThanhCong AS
SELECT
    dhb.id_khach_hang,
    COUNT(dhb.id) AS tong_don_thanh_cong
FROM
    DonHangBan dhb
WHERE
    dhb.trang_thai_don_hang NOT IN ('Đã hủy', 'Trả hàng')
GROUP BY
    dhb.id_khach_hang;

-- Bước 2: Cập nhật so_lan_mua_hang trong bảng KhachHang
UPDATE KhachHang
SET so_lan_mua_hang = COALESCE(tdh.tong_don_thanh_cong, 0)
FROM
    KhachHang kh_alias
LEFT JOIN
    Temp_TongDonHangThanhCong tdh ON kh_alias.id = tdh.id_khach_hang
WHERE
    KhachHang.id = kh_alias.id;

-- Dọn dẹp bảng tạm (tùy chọn)
-- DROP TABLE IF EXISTS Temp_TongDonHangThanhCong;