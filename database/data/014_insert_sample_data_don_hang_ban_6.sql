-- =================================================================
-- DU LIEU MAU - PHAN 7.6: DON HANG BAN & CHI TIET (LO 6/16, Don hang 26-30)
-- Tiep tuc tu DonHangBan ID 25 (Gia su ID DonHangBan se la 26 den 30)
-- =================================================================

-- Don Hang Ban 26
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'khoa.tran@email.com'), -- Khách hàng Trần Anh Khoa (ID=1)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'mai_nt_nv'), -- Nhân viên Nguyễn Thị Mai (ID=2)
  '2025-05-26 09:15:00+07',
  '2025-05-28',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'khoa.tran@email.com')),
  4800000, 4600000, 'Chuyển khoản', 'Đã xác nhận', 'Đã thanh toán', 'Mua thêm RAM');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 26)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 26, 2, 2300000, 2400000, 'Không giảm giá', 2400000, 'RAM Corsair Vengeance LPX 32GB (Mua 2 thanh)');

-- Don Hang Ban 27
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'linh.hoang.thuy@email.com'), -- Khách hàng Hoàng Thùy Linh (ID=6)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'hung_lv_nv'), -- Nhân viên Lê Văn Hùng (ID=3)
  '2025-05-26 11:00:00+07',
  '2025-05-27',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'linh.hoang.thuy@email.com')),
  9500000, 8500000, 'Tiền mặt', 'Hoàn tất', 'Đã thanh toán', 'Mua Apple Watch mới');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 27)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 21, 1, 8500000, 9500000, 'Không giảm giá', 9500000, 'Đồng hồ thông minh Apple Watch Series 10');

-- Don Hang Ban 28
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'nam.nguyen.van@email.com'), -- Khách hàng Nguyễn Văn Nam (ID=7)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'hoa_pt_nv'), -- Nhân viên Phạm Thị Hoa (ID=4)
  '2025-05-26 14:20:00+07',
  '2025-05-29',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'nam.nguyen.van@email.com')),
  3500000, 3000000, 'COD', 'Đang giao hàng', 'Chưa thanh toán', 'Mua SSD');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 28)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 29, 1, 3000000, 3500000, 'Không giảm giá', 3500000, 'Ổ cứng SSD Samsung 990 PRO 2TB NVMe PCIe 4.0');

-- Don Hang Ban 29
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'ha.tran.thu@email.com'), -- Khách hàng Trần Thị Thu Hà (ID=8)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'nam_hv_nv'), -- Nhân viên Hoàng Văn Nam (ID=5)
  '2025-05-27 09:50:00+07',
  '2025-05-28',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'ha.tran.thu@email.com')),
  1800000, 1200000, 'Thẻ tín dụng', 'Hoàn tất', 'Đã thanh toán', 'Mua bàn phím G Pro X');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 29)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 13, 1, 1200000, 1800000, 'Không giảm giá', 1800000, 'Bàn phím cơ Logitech G Pro X TKL');

-- Don Hang Ban 30
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'khang.ly.minh@email.com'), -- Khách hàng Lý Minh Khang (ID=9)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'mai_nt_nv'), -- Nhân viên Nguyễn Thị Mai (ID=2)
  '2025-05-27 15:00:00+07',
  '2025-05-30',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'khang.ly.minh@email.com')),
  50000000, 45000000, 'Chuyển khoản', 'Đã xác nhận', 'Đã thanh toán', 'Khách đặt Laptop Workstation');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 30)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 4, 1, 45000000, 50000000, 'Không giảm giá', 50000000, 'Laptop WorkStation WZ-5000');