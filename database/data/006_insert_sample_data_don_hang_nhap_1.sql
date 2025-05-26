-- =================================================================
-- DU LIEU MAU - PHAN 4: DON HANG NHAP & CHI TIET (LO 1/3) - REVISED
-- ID SanPham dua tren danh sach da chinh sua (1 den 31)
-- SU DUNG ID CU THE CHO id_don_hang_nhap TRONG ChiTietDonHangNhap KHI CHAY THU CONG
-- =================================================================

-- Don Hang Nhap 1
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 2, '2025-03-15', '2025-03-22', 270000000, 'Đã đặt hàng', 'Nhập lô Laptop UltraBook X1 và Smartphone Alpha Pro');
-- Sau khi chạy lệnh trên, giả sử ID đơn hàng nhập được tạo là 1
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 1, 5, 28000000, NULL), -- Laptop UltraBook X1 Gen 3 (ID SP=1)
( (SELECT MAX(id) FROM DonHangNhap), 2, 10, 13000000, NULL); -- Smartphone Alpha Pro Max 2025 (ID SP=2)

-- Don Hang Nhap 2 (Sửa NCC và sản phẩm)
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 3, '2025-03-16', '2025-03-25', 148500000, 'Đã đặt hàng', 'Nhập máy tính bảng và điện thoại tầm trung');
-- Giả sử ID đơn hàng nhập được tạo là 2
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 3, 15, 5800000, 'Lô mới'), -- Máy tính bảng Tab S10 Plus (ID SP=3)
( (SELECT MAX(id) FROM DonHangNhap), 5, 15, 4100000, NULL); -- Điện thoại tầm trung Beta M5G (ID SP=5)

-- Don Hang Nhap 3
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 4, '2025-03-18', '2025-03-26', '2025-03-27', 61500000, 'Hoàn tất', 'Nhập phụ kiện gaming');
-- Giả sử ID đơn hàng nhập được tạo là 3
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 13, 20, 1200000, NULL), -- Bàn phím cơ Logitech G Pro X TKL (ID SP=13)
( (SELECT MAX(id) FROM DonHangNhap), 14, 25, 1000000, NULL), -- Chuột Gaming Razer DeathAdder V3 Pro (ID SP=14)
( (SELECT MAX(id) FROM DonHangNhap), 15, 15, 1500000, NULL); -- Tai nghe Gaming HyperX Cloud III Wireless (ID SP=15)

-- Don Hang Nhap 4
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 5, '2025-03-20', '2025-03-28', 610000000, 'Đang giao hàng', 'Nhập lô MacBook và Samsung S25');
-- Giả sử ID đơn hàng nhập được tạo là 4
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 6, 10, 28000000, NULL), -- MacBook Air M3 (ID SP=6)
( (SELECT MAX(id) FROM DonHangNhap), 7, 15, 22000000, NULL); -- Samsung Galaxy S25 Ultra (ID SP=7)

-- Don Hang Nhap 5
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 2, '2025-04-01', '2025-04-08', 360000000, 'Đã đặt hàng', 'Nhập thêm Workstation và điện thoại Beta');
-- Giả sử ID đơn hàng nhập được tạo là 5
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 4, 5, 45000000, NULL), -- Laptop WorkStation WZ-5000 (ID SP=4)
( (SELECT MAX(id) FROM DonHangNhap), 5, 30, 4500000, NULL); -- Điện thoại tầm trung Beta M5G (ID SP=5)

-- Don Hang Nhap 6 (Sửa NCC và sản phẩm)
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 3, '2025-04-05', '2025-04-12', '2025-04-13', 19200000, 'Hoàn tất', 'Nhập thêm Router Wifi 6');
-- Giả sử ID đơn hàng nhập được tạo là 6
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 8, 80, 240000, NULL); -- Router Wifi 6 AX3000 (ID SP=8)

-- Don Hang Nhap 7
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 4, '2025-04-10', '2025-04-18', 37500000, 'Đã đặt hàng', 'Nhập tay cầm chơi game và lót chuột');
-- Giả sử ID đơn hàng nhập được tạo là 7
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 16, 40, 750000, NULL), -- Tay cầm chơi game Xbox (ID SP=16)
( (SELECT MAX(id) FROM DonHangNhap), 17, 50, 150000, NULL); -- Lót chuột SteelSeries (ID SP=17)

-- Don Hang Nhap 8
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 5, '2025-04-15', '2025-04-22', 74000000, 'Chờ xác nhận', 'Nhập thiết bị mạng và âm thanh');
-- Giả sử ID đơn hàng nhập được tạo là 8
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 9, 30, 800000, NULL),  -- Bộ Phát Wifi Mesh Deco M5 (ID SP=9)
( (SELECT MAX(id) FROM DonHangNhap), 19, 20, 2500000, NULL); -- Loa Bluetooth JBL Charge 5 (ID SP=19)

-- Don Hang Nhap 9
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, ngay_nhan_hang_thuc_te, tong_gia_tri, trang_thai, ghi_chu) VALUES
(3, 2, '2025-04-20', '2025-04-27', '2025-04-28', 70000000, 'Hoàn tất', 'Nhập thêm ghế gaming và tai nghe Sony');
-- Giả sử ID đơn hàng nhập được tạo là 9
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 18, 5, 5000000, NULL),  -- Ghế Gaming Anda Seat (ID SP=18)
( (SELECT MAX(id) FROM DonHangNhap), 20, 10, 4500000, NULL); -- Tai nghe Sony WF-1000XM5 (ID SP=20)

-- Don Hang Nhap 10
INSERT INTO DonHangNhap (id_nha_cung_cap, id_nhan_vien, ngay_dat_hang, ngay_du_kien_nhan_hang, tong_gia_tri, trang_thai, ghi_chu) VALUES
(1, 3, '2025-04-25', '2025-05-02', 280000000, 'Đã đặt hàng', 'Nhập linh kiện PC số lượng lớn'); -- Sửa lại tổng giá trị
-- Giả sử ID đơn hàng nhập được tạo là 10
INSERT INTO ChiTietDonHangNhap (id_don_hang_nhap, id_san_pham, so_luong, gia_nhap_don_vi, ghi_chu) VALUES
( (SELECT MAX(id) FROM DonHangNhap), 24, 10, 11000000, NULL), -- CPU Intel Core i9 (ID SP=24)
( (SELECT MAX(id) FROM DonHangNhap), 25, 10, 9000000, NULL), -- Mainboard ASUS Z790-E (ID SP=25)
( (SELECT MAX(id) FROM DonHangNhap), 27, 5, 20000000, NULL); -- VGA RTX 4080 Super (ID SP=27)