-- =================================================================
-- DU LIEU MAU - PHAN 7.1: DON HANG BAN & CHI TIET (LO 1/16, Don hang 1-5)
-- Chay sau khi da co du lieu cho DanhMuc, NhanVien, KhachHang, SanPham
-- Cac ENUM cho DonHangBan phai duoc tao truoc.
-- =================================================================

-- Don Hang Ban 1
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(1, 2, '2025-05-01 10:30:00+07', '2025-05-03', (SELECT dia_chi FROM KhachHang WHERE id = 1), 30000000, 28000000, 'COD', 'Đang giao hàng', 'Chưa thanh toán', 'Khách hàng Trần Anh Khoa. Giao nhanh.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 1)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 1, 1, 28000000, 30000000, 'Không giảm giá', 30000000, 'Laptop UltraBook X1 Gen 3');

-- Don Hang Ban 2
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(2, 3, '2025-05-02 14:00:00+07', '2025-05-04', (SELECT dia_chi FROM KhachHang WHERE id = 2), 14000000, 13000000, 'Chuyển khoản', 'Đã giao', 'Đã thanh toán', 'Khách hàng Lê Thị Quỳnh Anh. Đã xác nhận chuyển khoản.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 2)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 2, 1, 13000000, 15000000, 'Giảm 1 triệu', 14000000, 'Smartphone Alpha Pro Max 2025');

-- Don Hang Ban 3
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(3, 4, '2025-05-03 09:00:00+07', (SELECT dia_chi FROM KhachHang WHERE id = 3), 1800000, 1200000, 'Thẻ tín dụng', 'Đã xác nhận', 'Đã thanh toán', 'Khách hàng Phạm Minh Tuấn. Thanh toán online thành công.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 3)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 13, 1, 1200000, 1800000, 'Không giảm giá', 1800000, 'Bàn phím cơ Logitech G Pro X TKL');

-- Don Hang Ban 4
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(4, 5, '2025-05-04 11:30:00+07', '2025-05-06', (SELECT dia_chi FROM KhachHang WHERE id = 4), 4500000, 3800000, 'Tiền mặt', 'Hoàn tất', 'Đã thanh toán', 'Khách hàng Võ Ngọc Lan. Khách rất hài lòng.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 4)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 20, 1, 4300000, 4500000, 'Không giảm giá', 4500000, 'Tai nghe True Wireless Sony WF-1000XM5'); -- Sửa lại ID sản phẩm cho khớp tên

-- Don Hang Ban 5
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
(5, 2, '2025-05-05 16:00:00+07', (SELECT dia_chi FROM KhachHang WHERE id = 5), 28000000, 25000000, 'COD', 'Chờ xác nhận', 'Chưa thanh toán', 'Khách hàng Đặng Quốc Bảo. Đơn hàng PC, cần gọi xác nhận.');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 5)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 31, 1, 25000000, 28000000, 'Không giảm giá', 28000000, 'PC Gaming Prebuilt Titan X');