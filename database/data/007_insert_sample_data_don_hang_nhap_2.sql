-- =================================================================
-- DU LIEU MAU - PHAN 5: DON HANG NHAP & CHI TIET (LO 2/3) - REVISED
-- Tiep tuc tu DonHangNhap ID 10 (Gia su ID DonHangNhap se la 11 den 20)
-- ID SanPham dua tren danh sach da chinh sua (1 den 31)
-- SU DUNG ID CU THE CHO id_don_hang_nhap TRONG ChiTietDonHangNhap KHI CHAY THU CONG TUNG LENH
-- HOAC DAM BAO CHAY TRONG CUNG TRANSACTION KHI DUNG (SELECT MAX(id) FROM DonHangNhap)
-- =================================================================

-- Don Hang Nhap 11
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 4, '2025-05-01', '2025-05-08', '2025-05-09', 35250000, 'Hoàn tất', 'Nhập bổ sung Máy tính bảng và Điện thoại tầm trung'); -- NCC 1 cho đồ điện tử
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 11)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 3, 30, 5750000, NULL), -- Máy tính bảng Tab S10 Plus (ID SP=3)
( (SELECT MAX(id) FROM DonHangNhap), 5, 20, 4200000, NULL); -- Điện thoại tầm trung Beta M5G (ID SP=5)

-- Don Hang Nhap 12
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 5, '2025-05-02', '2025-05-09', 14900000, 'Đã đặt hàng', 'Nhập thêm lót chuột và tay cầm Xbox');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 12)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 17, 60, 145000, 'Lô mới'), -- Lót chuột SteelSeries (ID SP=17)
( (SELECT MAX(id) FROM DonHangNhap), 16, 10, 760000, NULL); -- Tay cầm Xbox (ID SP=16)

-- Don Hang Nhap 13
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 2, '2025-05-03', '2025-05-10', 78000000, 'Đang giao hàng', 'Nhập lô Router và Switch mạng');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 13)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 8, 40, 750000, NULL), -- Router Wifi 6 AX3000 (ID SP=8)
( (SELECT MAX(id) FROM DonHangNhap), 10, 30, 1600000, NULL); -- Switch Gigabit 8 Cổng D-Link (ID SP=10)

-- Don Hang Nhap 14
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 3, '2025-05-04', '2025-05-11', '2025-05-12', 21200000, 'Hoàn tất', 'Nhập USB Wifi và Cáp Mạng');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 14)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 11, 40, 480000, NULL), -- USB Wifi Adapter Tenda U12 (ID SP=11)
( (SELECT MAX(id) FROM DonHangNhap), 12, 20, 100000, NULL); -- Cáp Mạng Cat6 20m (ID SP=12)

-- Don Hang Nhap 15
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 4, '2025-05-05', '2025-05-13', 26000000, 'Đã đặt hàng', 'Nhập tai nghe và bàn phím gaming (lần 2)');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 15)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 15, 10, 1450000, 'Lô mới'), -- Tai nghe HyperX Cloud III (ID SP=15)
( (SELECT MAX(id) FROM DonHangNhap), 13, 10, 1150000, NULL); -- Bàn phím Logitech G Pro X (ID SP=13)

-- Don Hang Nhap 16
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 5, '2025-05-06', '2025-05-14', 80000000, 'Chờ xác nhận', 'Nhập Loa và Tai nghe không dây');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 16)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 19, 20, 2300000, NULL), -- Loa Bluetooth JBL Charge 5 (ID SP=19)
( (SELECT MAX(id) FROM DonHangNhap), 20, 10, 4300000, NULL); -- Tai nghe Sony WF-1000XM5 (ID SP=20)

-- Don Hang Nhap 17
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 2, '2025-05-07', '2025-05-15', '2025-05-16', 121000000, 'Hoàn tất', 'Nhập Apple Watch và thiết bị thông minh');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 17)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 21, 10, 8500000, NULL), -- Đồng hồ Apple Watch S10 (ID SP=21)
( (SELECT MAX(id) FROM DonHangNhap), 22, 30, 1200000, NULL); -- Bóng đèn Philips Hue (ID SP=22)

-- Don Hang Nhap 18
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 3, '2025-05-08', '2025-05-16', 127000000, 'Đã đặt hàng', 'Nhập CPU và Mainboard');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 18)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 24, 7, 10800000, 'Hàng hot'), -- CPU Intel Core i9-14900K (ID SP=24)
( (SELECT MAX(id) FROM DonHangNhap), 25, 7, 8800000, NULL); -- Mainboard ASUS Z790-E (ID SP=25)

-- Don Hang Nhap 19
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 4, '2025-05-09', '2025-05-17', 81000000, 'Đang giao hàng', 'Nhập RAM và VGA');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 19)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 26, 30, 2300000, NULL), -- RAM Corsair 32GB (ID SP=26)
( (SELECT MAX(id) FROM DonHangNhap), 27, 2, 27500000, NULL); -- VGA RTX 4080 Super (ID SP=27)

-- Don Hang Nhap 20
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 5, '2025-05-10', '2025-05-18', '2025-05-19', 57000000, 'Hoàn tất', 'Nhập Nguồn và SSD');
-- ChiTietDonHangNhap cho DonHangNhap (gia su ID la 20)
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 28, 15, 1800000, NULL), -- Nguồn Corsair RM850x (ID SP=28)
( (SELECT MAX(id) FROM DonHangNhap), 29, 10, 3000000, NULL); -- SSD Samsung 990 PRO 2TB (ID SP=29)