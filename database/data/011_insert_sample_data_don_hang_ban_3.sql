-- =================================================================
-- DU LIEU MAU - PHAN 7.3: DON HANG BAN & CHI TIET (LO 3/16, Don hang 11-15)
-- Tiep tuc tu DonHangBan ID 10 (Gia su ID DonHangBan se la 11 den 15)
-- =================================================================

-- Don Hang Ban 11
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(11, 4, '2025-05-11 08:45:00+07', '2025-05-13', (SELECT dia_chi FROM KhachHang WHERE id = 11), 150000, 135000, 'Tiền mặt', 'Đã xác nhận', 'Chưa thanh toán', 'Khách hàng Bùi Thế Vinh. Mua 3 Cáp Mạng.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 11)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 12, 3, 45000, 50000, 'Không giảm giá', 50000, 'Cáp Mạng Cat6 UTP 20m Vention');

-- Don Hang Ban 12
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(12, 5, '2025-05-12 10:55:00+07', '2025-05-14', (SELECT dia_chi FROM KhachHang WHERE id = 12), 5450000, 4900000, 'Chuyển khoản', 'Hoàn tất', 'Đã thanh toán', 'Khách hàng Đỗ Mỹ Linh.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 12)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 5, 1, 4100000, 4800000, 'Khách hàng thân thiết', 4500000, 'Điện thoại tầm trung Beta M5G'),
( (SELECT MAX(id) FROM DonHangBan), 9, 1, 800000, 950000, 'Không giảm giá', 950000, 'Bộ Phát Wifi Mesh Deco M5 (3-pack)');

-- Don Hang Ban 13
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(13, 2, '2025-05-13 11:05:00+07', '2025-05-15', (SELECT dia_chi FROM KhachHang WHERE id = 13), 1200000, 1000000, 'COD', 'Đang giao hàng', 'Chưa thanh toán', 'Khách hàng Vương Quốc Anh. Gọi trước khi giao.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 13)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 22, 1, 1000000, 1500000, 'Giảm 20%', 1200000, 'Bóng đèn thông minh Philips Hue White and Color Ambiance');

-- Don Hang Ban 14
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(14, 3, '2025-05-14 14:30:00+07', '2025-05-15', (SELECT dia_chi FROM KhachHang WHERE id = 14), 30000000, 27500000, 'Thẻ tín dụng', 'Đã giao', 'Đã thanh toán', 'Khách hàng Hà Thị Kiều Trang.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 14)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 27, 1, 27500000, 30000000, 'Không giảm giá', 30000000, 'Card màn hình NVIDIA GeForce RTX 4080 Super 16GB');

-- Don Hang Ban 15
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(15, 4, '2025-05-15 16:15:00+07', '2025-05-18', (SELECT dia_chi FROM KhachHang WHERE id = 15), 2300000, 1800000, 'Tiền mặt', 'Đã xác nhận', 'Chưa thanh toán', 'Khách hàng Tạ Minh Đức. Khách đặt cọc trước.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 15)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 28, 1, 1800000, 2300000, 'Không giảm giá', 2300000, 'Nguồn máy tính Corsair RM850x 850W 80 Plus Gold');