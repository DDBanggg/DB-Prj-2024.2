-- =================================================================
-- DU LIEU MAU - PHAN 7.4: DON HANG BAN & CHI TIET (LO 4/16, Don hang 16-20)
-- Tiep tuc tu DonHangBan ID 15 (Gia su ID DonHangBan se la 16 den 20)
-- =================================================================

-- Don Hang Ban 16
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(16, 5, '2025-05-16 09:00:00+07', '2025-05-17', (SELECT dia_chi FROM KhachHang WHERE id = 16), 4500000, 4300000, 'Chuyển khoản', 'Hoàn tất', 'Đã thanh toán', 'Khách hàng Mai Lan Phương. Giao buổi sáng.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 16)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 20, 1, 4300000, 4500000, 'Không giảm giá', 4500000, 'Tai nghe True Wireless Sony WF-1000XM5');

-- Don Hang Ban 17
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(17, 2, '2025-05-17 11:20:00+07', (SELECT dia_chi FROM KhachHang WHERE id = 17), 1000000, 530000, 'COD', 'Chờ xác nhận', 'Chưa thanh toán', 'Khách hàng Lưu Quang Vinh. Khách hỏi nhiều về sản phẩm.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 17)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 10, 1, 280000, 350000, 'Không giảm giá', 350000, 'Switch Gigabit 8 Cổng D-Link DGS-1008A'),
( (SELECT MAX(id) FROM DonHangBan), 23, 2, 250000, 325000, 'Không giảm giá', 325000, 'Ổ cắm thông minh TP-Link Tapo P100 Mini'); -- 325k * 2 = 650k. Tổng: 350k + 650k = 1000k

-- Don Hang Ban 18
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(18, 3, '2025-05-18 13:40:00+07', '2025-05-20', (SELECT dia_chi FROM KhachHang WHERE id = 18), 3000000, 2430000, 'Thẻ tín dụng', 'Đã giao', 'Đã thanh toán', 'Khách hàng Châu Tú Na. Gói quà cẩn thận.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 18)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 15, 1, 1450000, 1800000, 'Không giảm giá', 1800000, 'Tai nghe Gaming HyperX Cloud III Wireless'),
( (SELECT MAX(id) FROM DonHangBan), 14, 1, 980000, 1200000, 'Không giảm giá', 1200000, 'Chuột Gaming Razer DeathAdder V3 Pro');

-- Don Hang Ban 19
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(19, 4, '2025-05-19 15:50:00+07', '2025-05-22', (SELECT dia_chi FROM KhachHang WHERE id = 19), 28000000, 25000000, 'COD', 'Đang giao hàng', 'Chưa thanh toán', 'Khách hàng Đinh Công Thành.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 19)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 31, 1, 25000000, 28000000, 'Không giảm giá', 28000000, 'PC Gaming Prebuilt Titan X');

-- Don Hang Ban 20
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(20, 5, '2025-05-20 17:00:00+07', '2025-05-21', (SELECT dia_chi FROM KhachHang WHERE id = 20), 46800000, 42000000, 'Chuyển khoản', 'Hoàn tất', 'Đã thanh toán', 'Khách hàng Âu Dương Phấn. Xuất hóa đơn VAT.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 20)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 4, 1, 40000000, 45000000, 'Giảm 5tr theo chương trình', 40000000, 'Laptop WorkStation WZ-5000'), -- Sửa lại giá vốn cho phù hợp hơn
( (SELECT MAX(id) FROM DonHangBan), 30, 1, 1500000, 1800000, 'Không giảm giá', 1800000, 'Vỏ case NZXT H5 Flow Mid-Tower');