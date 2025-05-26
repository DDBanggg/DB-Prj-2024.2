-- =================================================================
-- DU LIEU MAU - PHAN 7.5: DON HANG BAN & CHI TIET (LO 5/16, Don hang 21-25)
-- Tiep tuc tu DonHangBan ID 20 (Gia su ID DonHangBan se la 21 den 25)
-- =================================================================

-- Don Hang Ban 21
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'khoa.tran@email.com'), -- Khách hàng Trần Anh Khoa (ID=1)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'mai_nt_nv'), -- Nhân viên Nguyễn Thị Mai (ID=2)
  '2025-05-21 10:30:00+07',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'khoa.tran@email.com')),
  12000000, 10800000, 'Tiền mặt', 'Đã xác nhận', 'Chưa thanh toán', 'Mua CPU');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 21)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 24, 1, 10800000, 12000000, 'Không giảm giá', 12000000, 'CPU Intel Core i9-14900K');

-- Don Hang Ban 22
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'quynhanh.le@email.com'), -- Khách hàng Lê Thị Quỳnh Anh (ID=2)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'hung_lv_nv'), -- Nhân viên Lê Văn Hùng (ID=3)
  '2025-05-22 09:00:00+07',
  '2025-05-24',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'quynhanh.le@email.com')),
  1900000, 1520000, 'COD', 'Đang giao hàng', 'Chưa thanh toán', 'Khách đặt thêm tay cầm');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 22)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 16, 2, 760000, 950000, 'Không giảm giá', 950000, 'Tay cầm chơi game Xbox Series Controller');

-- Don Hang Ban 23
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_thuc_te, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'tuan.pham.minh@email.com'), -- Khách hàng Phạm Minh Tuấn (ID=3)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'hoa_pt_nv'), -- Nhân viên Phạm Thị Hoa (ID=4)
  '2025-05-23 11:00:00+07',
  '2025-05-24',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'tuan.pham.minh@email.com')),
  2300000, 1800000, 'Chuyển khoản', 'Hoàn tất', 'Đã thanh toán', 'Mua nguồn máy tính');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 23)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 28, 1, 1800000, 2300000, 'Không giảm giá', 2300000, 'Nguồn máy tính Corsair RM850x 850W 80 Plus Gold');

-- Don Hang Ban 24
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'lan.vo.ngoc@email.com'), -- Khách hàng Võ Ngọc Lan (ID=4)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'nam_hv_nv'), -- Nhân viên Hoàng Văn Nam (ID=5)
  '2025-05-24 14:30:00+07',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'lan.vo.ngoc@email.com')),
  3100000, 2300000, 'Thẻ tín dụng', 'Đã xác nhận', 'Đã thanh toán', 'Mua RAM');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 24)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 26, 1, 2300000, 3100000, 'Không giảm giá', 3100000, 'RAM Corsair Vengeance LPX 32GB (2x16GB) DDR5 5600MHz');

-- Don Hang Ban 25
INSERT INTO DonHangBan (id_khach_hang, id_nhan_vien, ngay_dat_hang, ngay_giao_hang_du_kien, dia_chi_giao_hang, tong_doanh_thu, tong_gia_von, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, ghi_chu_don_hang) VALUES
( (SELECT id FROM KhachHang WHERE email = 'bao.dang.quoc@email.com'), -- Khách hàng Đặng Quốc Bảo (ID=5)
  (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'mai_nt_nv'), -- Nhân viên Nguyễn Thị Mai (ID=2)
  '2025-05-25 16:00:00+07',
  '2025-05-28',
  (SELECT dia_chi FROM KhachHang WHERE id = (SELECT id FROM KhachHang WHERE email = 'bao.dang.quoc@email.com')),
  2000000, 1500000, 'COD', 'Đang giao hàng', 'Chưa thanh toán', 'Mua vỏ case NZXT, có giảm giá');
-- ChiTietDonHangBan cho DonHangBan (gia su ID DonHangBan moi tao la 25)
INSERT INTO ChiTietDonHangBan (id_don_hang_ban, id_san_pham, so_luong, gia_von_don_vi, gia_ban_niem_yet_don_vi, loai_giam_gia, gia_ban_cuoi_cung_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangBan), 30, 1, 1500000, 2500000, 'Giảm 500k theo chương trình', 2000000, 'Vỏ case NZXT H5 Flow Mid-Tower');