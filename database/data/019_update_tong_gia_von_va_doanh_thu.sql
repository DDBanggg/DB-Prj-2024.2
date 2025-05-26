-- Bước 1: Tạo bảng tạm tính tổng doanh thu và tổng giá vốn thực tế cho mỗi đơn hàng bán từ chi tiết (nếu chưa có trong session)
CREATE TEMP TABLE Temp_TongDonHangBanThucTe AS
SELECT
    ctdb.id_don_hang_ban,
    SUM(ctdb.so_luong * ctdb.gia_ban_cuoi_cung_don_vi) AS dt_tinh_toan_tu_chi_tiet,
    SUM(ctdb.so_luong * ctdb.gia_von_don_vi) AS gv_tinh_toan_tu_chi_tiet
FROM
    ChiTietDonHangBan ctdb
GROUP BY
    ctdb.id_don_hang_ban;

-- Bước 2: Cập nhật tong_doanh_thu và tong_gia_von trong bảng DonHangBan
UPDATE DonHangBan
SET
    tong_doanh_thu = COALESCE(ttdhb.dt_tinh_toan_tu_chi_tiet, 0),
    tong_gia_von = COALESCE(ttdhb.gv_tinh_toan_tu_chi_tiet, 0)
FROM
    DonHangBan dhb_alias
LEFT JOIN
    Temp_TongDonHangBanThucTe ttdhb ON dhb_alias.id = ttdhb.id_don_hang_ban
WHERE
    DonHangBan.id = dhb_alias.id
    AND (DonHangBan.tong_doanh_thu <> COALESCE(ttdhb.dt_tinh_toan_tu_chi_tiet, 0)
         OR DonHangBan.tong_gia_von <> COALESCE(ttdhb.gv_tinh_toan_tu_chi_tiet, 0)); -- Chỉ cập nhật những dòng có ít nhất một giá trị bị lệch

-- Dọn dẹp bảng tạm (tùy chọn)
-- DROP TABLE IF EXISTS Temp_TongDonHangBanThucTe;