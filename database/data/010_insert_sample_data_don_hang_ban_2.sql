-- =================================================================
-- DU LIEU MAU - PHAN 7.2: DON HANG BAN & CHI TIET (LO 2/16, Don hang 6-10)
-- Tiep tuc tu DonHangBan ID 5 (Gia su ID DonHangBan se la 6 den 10)
-- =================================================================

-- Don Hang Ban 6
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(6, 3, '2025-05-06 09:45:00+07', '2025-05-08', (SELECT dia_chi FROM KhachHang WHERE id = 6), 690000, 435000, 'Tiền mặt', 'Hoàn tất', 'Đã thanh toán', 'Khách hàng Hoàng Thùy Linh. Mua phụ kiện.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 6)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 17, 2, 145000, 200000, 'Không giảm giá', 200000, 'Lót chuột Gaming SteelSeries QcK Large'),
( (SELECT MAX(id) FROM DonHangBan), 12, 5, 45000, 60000, 'Giảm 10%', 54000, 'Cáp Mạng Cat6 UTP 20m Vention'); -- (54k * 5 = 270k) -> tong_doanh_thu 400k+270k = 670k. Can sua tong_doanh_thu.

-- Don Hang Ban 7 (Don huy)
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(7, 4, '2025-05-07 11:00:00+07', (SELECT dia_chi FROM KhachHang WHERE id = 7), 0, 0, 'Chuyển khoản', 'Đã hủy', 'Chưa thanh toán', 'Khách hàng Nguyễn Văn Nam. Khách báo hủy do đổi ý mua Apple Watch.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 7)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 21, 1, 8500000, 9500000, 'Không giảm giá', 9500000, 'Đồng hồ thông minh Apple Watch Series 10 - Hủy theo đơn');

-- Don Hang Ban 8 (Don tra hang)
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(8, 5, '2025-05-08 13:15:00+07', '2025-05-10', (SELECT dia_chi FROM KhachHang WHERE id = 8), 2800000, 2300000, 'Tiền mặt', 'Trả hàng', 'Đã thanh toán', 'Khách hàng Trần Thị Thu Hà. Khách trả 1 Loa do không ưng màu, còn giữ 1.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 8)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 19, 1, 2300000, 2800000, 'Không giảm giá', 2800000, 'Loa Bluetooth JBL Charge 5 - Giữ lại 1 cái');
-- Ghi chu: Ban dau co the khach mua 2 cai, sau do tra 1. Script chi ghi nhan so luong cuoi cung sau khi da xu ly tra hang.

-- Don Hang Ban 9
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(9, 2, '2025-05-09 15:30:00+07', '2025-05-12', (SELECT dia_chi FROM KhachHang WHERE id = 9), 2312500, 1740000, 'COD', 'Đang giao hàng', 'Chưa thanh toán', 'Khách hàng Lý Minh Khang. Giao hàng cho khách ở xa.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 9)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 11, 1, 480000, 650000, 'Không giảm giá', 650000, 'USB Wifi Adapter AC1300 Tenda U12'),
( (SELECT MAX(id) FROM DonHangBan), 23, 5, 250000, 350000, 'Mua 5 giảm 5%', 332500, 'Ổ cắm thông minh TP-Link Tapo P100 Mini'); -- 332500 * 5 = 1662500. Tong: 650000 + 1662500 = 2312500

-- Don Hang Ban 10
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(10, 3, '2025-05-10 17:00:00+07', '2025-05-11', (SELECT dia_chi FROM KhachHang WHERE id = 10), 33500000, 30000000, 'Thẻ tín dụng', 'Hoàn tất', 'Đã thanh toán', 'Khách hàng Phan Thị Diễm My. Khách hàng VIP, mua PC và ghế.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 10)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 31, 1, 25000000, 28000000, 'Không giảm giá', 28000000, 'PC Gaming Prebuilt Titan X'),
( (SELECT MAX(id) FROM DonHangBan), 18, 1, 5000000, 5500000, 'Không giảm giá', 5500000, 'Ghế Gaming Anda Seat Kaiser 3 XL');