-- Bước 1: Tạo bảng tạm tính tổng giá trị thực tế cho mỗi đơn hàng nhập từ chi tiết (nếu chưa có trong session)
CREATE TEMP TABLE Temp_TongGiaTriDonNhapThucTe AS
SELECT
    ctdn.id_don_hang_nhap,
    SUM(ctdn.so_luong * ctdn.gia_nhap_don_vi) AS tong_gia_tri_tinh_toan_tu_chi_tiet
FROM
    ChiTietDonHangNhap ctdn
GROUP BY
    ctdn.id_don_hang_nhap;

-- Bước 2: Cập nhật tong_gia_tri trong bảng DonHangNhap
UPDATE DonHangNhap
SET tong_gia_tri = COALESCE(ttdntt.tong_gia_tri_tinh_toan_tu_chi_tiet, 0)
FROM
    DonHangNhap dhn_alias
LEFT JOIN
    Temp_TongGiaTriDonNhapThucTe ttdntt ON dhn_alias.id = ttdntt.id_don_hang_nhap
WHERE
    DonHangNhap.id = dhn_alias.id
    AND DonHangNhap.tong_gia_tri <> COALESCE(ttdntt.tong_gia_tri_tinh_toan_tu_chi_tiet, 0); -- Chỉ cập nhật những dòng bị lệch

-- Dọn dẹp bảng tạm (tùy chọn)
-- DROP TABLE IF EXISTS Temp_TongGiaTriDonNhapThucTe;