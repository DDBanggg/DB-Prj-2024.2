-- =================================================================
-- DU LIEU MAU - PHAN 6: DON HANG NHAP & CHI TIET (LO 3/3) - REVISED
-- Tiep tuc tu DonHangNhap ID 20 (Gia su ID DonHangNhap se la 21 den 30)
-- ID SanPham dua tren danh sach da chinh sua (1 den 31)
-- SU DUNG ID CU THE CHO id_don_hang_nhap TRONG ChiTietDonHangNhap KHI CHAY THU CONG TUNG LENH
-- HOAC DAM BAO CHAY TRONG CUNG TRANSACTION KHI DUNG (SELECT MAX(id) FROM DonHangNhap)
-- =================================================================

-- Don Hang Nhap 21
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 2, '2025-05-11', '2025-05-19', '2025-05-20', 40000000, 'Hoàn tất', 'Nhập vỏ case NZXT và PC Gaming Titan X');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 21)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 30, 10, 1500000, NULL), -- Vỏ case NZXT H5 Flow (ID SP=30)
( (SELECT MAX(id) FROM DonHangNhap), 31, 1, 25000000, NULL); -- PC Gaming Prebuilt Titan X (ID SP=31)

-- Don Hang Nhap 22
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 3, '2025-05-12', '2025-05-20', 86000000, 'Đã đặt hàng', 'Nhập thêm ít điện thoại Smartphone Alpha'); -- Sửa lại NCC cho phù hợp
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 22)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 2, 70, 1230000, NULL); -- Smartphone Alpha Pro Max 2025 (ID SP=2)

-- Don Hang Nhap 23
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 4, '2025-05-13', '2025-05-21', 9800000, 'Đang giao hàng', 'Nhập thêm chuột gaming (lần 2)');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 23)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 14, 10, 980000, NULL); -- Chuột Gaming Razer DeathAdder V3 Pro (ID SP=14)

-- Don Hang Nhap 24
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 5, '2025-05-14', '2025-05-22', '2025-05-23', 17000000, 'Hoàn tất', 'Nhập cáp mạng và ổ cắm thông minh');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 24)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 12, 100, 45000, NULL), -- Cáp Mạng Cat6 UTP 20m Vention (ID SP=12)
( (SELECT MAX(id) FROM DonHangNhap), 23, 50, 250000, NULL); -- Ổ cắm thông minh TP-Link Tapo P100 Mini (ID SP=23)

-- Don Hang Nhap 25
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 2, '2025-05-15', '2025-05-23', 0, 'Đã hủy', 'Khách hàng hủy đơn nhập đặc biệt Laptop WorkStation (thay đổi kế hoạch)'); -- Tổng giá trị có thể là 0 nếu hủy trước khi có chi phí
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 25) - Du lieu van co the co du don hang da huy
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 4, 2, 46000000, 'Đã hủy theo đơn hàng'), -- Laptop WorkStation WZ-5000 (ID SP=4)
( (SELECT MAX(id) FROM DonHangNhap), 1, 1, 29000000, 'Đã hủy theo đơn hàng'); -- Laptop UltraBook X1 Gen 3 (ID SP=1)

-- Don Hang Nhap 26
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 3, '2025-05-16', '2025-05-24', 66000000, 'Chờ xác nhận', 'Đặt thử lô mới Samsung S25'); -- Sửa lại NCC và sản phẩm
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 26)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 7, 30, 2200000, 'Mẫu thử nghiệm'); -- Samsung Galaxy S25 Ultra (ID SP=7)

-- Don Hang Nhap 27
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 4, '2025-05-17', '2025-05-25', '2025-05-25', 10100000, 'Hoàn tất', 'Nhập thêm ít phụ kiện còn thiếu: tai nghe, lót chuột');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 27)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 15, 5, 1400000, NULL), -- Tai nghe Gaming HyperX Cloud III Wireless (ID SP=15)
( (SELECT MAX(id) FROM DonHangNhap), 17, 20, 155000, NULL); -- Lót chuột Gaming SteelSeries QcK Large (ID SP=17)

-- Don Hang Nhap 28
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 5, '2025-05-18', '2025-05-26', 139500000, 'Đã đặt hàng', 'Đơn hàng lớn nhập điện thoại và laptop cuối tháng');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 28)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 2, 10, 12500000, NULL), -- Smartphone Alpha Pro Max 2025 (ID SP=2)
( (SELECT MAX(id) FROM DonHangNhap), 6, 5, 27000000, NULL);  -- MacBook Air M3 13-inch (ID SP=6)
-- ( (SELECT MAX(id) FROM DonHangNhap), 7, 5, 21500000, NULL);  -- Samsung Galaxy S25 Ultra (ID SP=7) - Bỏ bớt để tổng tiền khớp hơn, hoặc điều chỉnh giá nhập

-- Don Hang Nhap 29
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 2, '2025-05-19', '2025-05-27', 63500000, 'Đang giao hàng', 'Nhập bổ sung linh kiện PC: RAM, SSD, Nguồn');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 29)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 26, 10, 2300000, NULL), -- RAM Corsair Vengeance LPX 32GB (ID SP=26)
( (SELECT MAX(id) FROM DonHangNhap), 29, 5, 3100000, NULL),  -- Ổ cứng SSD Samsung 990 PRO 2TB (ID SP=29)
( (SELECT MAX(id) FROM DonHangNhap), 28, 5, 1700000, NULL);  -- Nguồn máy tính Corsair RM850x (ID SP=28)

-- Don Hang Nhap 30
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 3, '2025-05-20', '2025-05-28', '2025-05-28', 23100000, 'Hoàn tất', 'Nhập nốt lô phụ kiện gaming cuối cùng của tháng');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 30)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 13, 5, 1180000, NULL), -- Bàn phím cơ Logitech G Pro X TKL (ID SP=13)
( (SELECT MAX(id) FROM DonHangNhap), 16, 10, 740000, NULL), -- Tay cầm chơi game Xbox Series Controller (ID SP=16)
( (SELECT MAX(id) FROM DonHangNhap), 18, 2, 4900000, NULL); -- Ghế Gaming Anda Seat Kaiser 3 XL (ID SP=18)