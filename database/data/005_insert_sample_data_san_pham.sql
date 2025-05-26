-- =================================================================
-- DU LIEU MAU - PHAN 3: SAN PHAM
-- =================================================================

-- 5. SanPham
INSERT INTO SanPham (ma_san_pham, ten_san_pham, id_danh_muc, so_luong_ton_kho, don_vi_tinh, mo_ta_chi_tiet, duong_dan_hinh_anh_chinh, trang_thai, ngay_tao_ban_ghi) VALUES
-- Danh muc 1: Điện thoại & Laptop
('DTL001', 'Laptop UltraBook X1 Gen 3', 1, 25, 'Cái', 'Laptop mỏng nhẹ, hiệu năng cao, màn hình 14 inch QHD, Intel Core i7 Gen 13, RAM 16GB, SSD 512GB', '/images/products/laptop_ultrabook_x1.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-15 10:00:00+07'),
('DTL002', 'Smartphone Alpha Pro Max 2025', 1, 50, 'Cái', 'Điện thoại cao cấp, camera 200MP, màn hình Super AMOLED 120Hz, chip A18 Bionic, bộ nhớ 256GB', '/images/products/phone_alpha_pro.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-15 10:05:00+07'),
('DTL003', 'Máy tính bảng Tab S10 Plus', 1, 30, 'Cái', 'Máy tính bảng 11 inch, hỗ trợ bút cảm ứng, Snapdragon 8 Gen 2, RAM 8GB, ROM 128GB', '/images/products/tablet_s10_plus.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-16 11:00:00+07'),
('DTL004', 'Laptop WorkStation WZ-5000', 1, 15, 'Cái', 'Máy trạm di động cho đồ họa và kỹ thuật, Nvidia Quadro A4000, Intel Xeon W-1350, RAM 32GB ECC', '/images/products/laptop_workstation_wz5000.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-17 14:00:00+07'),
('DTL005', 'Điện thoại tầm trung Beta M5G', 1, 70, 'Cái', 'Điện thoại 5G giá tốt, pin 5000mAh, camera 64MP, chip Dimensity 1200', '/images/products/phone_beta_m5g.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-18 09:30:00+07'),
('DTL006', 'MacBook Air M3 13-inch (2025)', 1, 20, 'Cái', 'MacBook Air mới nhất với chip M3, thiết kế siêu mỏng, thời lượng pin vượt trội, SSD 256GB', '/images/products/macbook_air_m3.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-01 10:00:00+07'),
('DTL007', 'Samsung Galaxy S25 Ultra', 1, 35, 'Cái', 'Flagship Samsung 2025, camera cải tiến, S-Pen tích hợp, chip Exynos mới nhất', '/images/products/galaxy_s25_ultra.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-05 11:00:00+07'),

-- Danh muc 2: Thiết bị Mạng & Internet
('TBMT001', 'Router Wifi 6 AX3000 TP-Link Archer AX55', 2, 60, 'Cái', 'Router Wifi 6 tốc độ cao, băng tần kép, công nghệ OFDMA và MU-MIMO', '/images/products/router_ax55.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-20 10:00:00+07'),
('TBMT002', 'Bộ Phát Wifi Mesh Deco M5 (3-pack)', 2, 40, 'Bộ', 'Hệ thống Wifi Mesh phủ sóng toàn bộ ngôi nhà, loại bỏ điểm chết wifi', '/images/products/mesh_deco_m5.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-20 10:05:00+07'),
('TBMT003', 'Switch Gigabit 8 Cổng D-Link DGS-1008A', 2, 80, 'Cái', 'Switch mạng không quản lý, 8 cổng Gigabit Ethernet, tiết kiệm năng lượng', '/images/products/switch_dgs1008a.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-21 11:15:00+07'),
('TBMT004', 'USB Wifi Adapter AC1300 Tenda U12', 2, 100, 'Cái', 'USB thu sóng Wifi băng tần kép, tốc độ AC1300, có ăng-ten ngoài', '/images/products/usb_wifi_u12.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-22 14:30:00+07'),
('TBMT005', 'Cáp Mạng Cat6 UTP 20m Vention', 2, 150, 'Sợi', 'Cáp mạng Cat6 chất lượng cao, chống nhiễu, đầu đúc sẵn, dài 20 mét', '/images/products/cable_cat6_20m.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-23 09:00:00+07'),

-- Danh muc 3: Phụ kiện & Thiết bị Chơi Game
('PKCS001', 'Bàn phím cơ Logitech G Pro X TKL', 3, 45, 'Cái', 'Bàn phím cơ gaming không phím số, switch GX Blue có thể thay nóng', '/images/products/keyboard_gprox.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-25 10:00:00+07'),
('PKCS002', 'Chuột Gaming Razer DeathAdder V3 Pro', 3, 55, 'Cái', 'Chuột gaming không dây siêu nhẹ, cảm biến Focus Pro 30K DPI', '/images/products/mouse_deathadder_v3.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-25 10:10:00+07'),
('PKCS003', 'Tai nghe Gaming HyperX Cloud III Wireless', 3, 35, 'Cái', 'Tai nghe không dây cho game thủ, âm thanh vòm 7.1, pin lên đến 120 giờ', '/images/products/headset_cloud3_wireless.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-26 11:30:00+07'),
('PKCS004', 'Tay cầm chơi game Xbox Series Controller', 3, 60, 'Cái', 'Tay cầm Xbox chính hãng, tương thích PC và Console, màu Carbon Black', '/images/products/controller_xbox_series.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-27 15:00:00+07'),
('PKCS005', 'Lót chuột Gaming SteelSeries QcK Large', 3, 90, 'Tấm', 'Lót chuột kích thước lớn, bề mặt vải mịn tối ưu cho cả control và speed', '/images/products/mousepad_qck_large.jpg', 'Đang kinh doanh - Còn hàng', '2025-02-28 09:45:00+07'),
('PKCS006', 'Ghế Gaming Anda Seat Kaiser 3 XL', 3, 10, 'Cái', 'Ghế gaming cao cấp, kích thước lớn, da PVC, ngả lưng 160 độ', '/images/products/chair_kaiser3.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-02 16:00:00+07'),

-- Danh muc 4: Âm thanh & Thiết bị Thông minh
('AMTT001', 'Loa Bluetooth JBL Charge 5', 4, 70, 'Cái', 'Loa di động chống nước IP67, âm thanh JBL Original Pro Sound, pin 20 giờ', '/images/products/speaker_jbl_charge5.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-01 10:30:00+07'),
('AMTT002', 'Tai nghe True Wireless Sony WF-1000XM5', 4, 65, 'Bộ', 'Tai nghe chống ồn chủ động hàng đầu, chất âm Hi-Res Audio Wireless', '/images/products/earbuds_wf1000xm5.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-01 10:35:00+07'),
('AMTT003', 'Đồng hồ thông minh Apple Watch Series 10', 4, 40, 'Cái', 'Apple Watch mới nhất, nhiều tính năng sức khỏe, màn hình lớn hơn', '/images/products/apple_watch_s10.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-02 11:00:00+07'),
('AMTT004', 'Bóng đèn thông minh Philips Hue White and Color Ambiance', 4, 80, 'Bóng', 'Bóng đèn LED đổi màu thông minh, điều khiển qua app, tương thích trợ lý ảo', '/images/products/philips_hue_bulb.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-03 14:00:00+07'),
('AMTT005', 'Ổ cắm thông minh TP-Link Tapo P100 Mini', 4, 120, 'Cái', 'Ổ cắm wifi điều khiển từ xa qua điện thoại, hẹn giờ bật tắt thiết bị', '/images/products/tapo_p100.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-04 09:15:00+07'),

-- Danh muc 5: Linh kiện & Desktop PC
('LKDTPC001', 'CPU Intel Core i9-14900K', 5, 20, 'Cái', 'Vi xử lý Intel thế hệ 14, 24 nhân 32 luồng, xung nhịp tối đa 6.0 GHz', '/images/products/cpu_i9_14900k.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-05 10:00:00+07'),
('LKDTPC002', 'Mainboard ASUS ROG STRIX Z790-E GAMING WIFI II', 5, 25, 'Cái', 'Bo mạch chủ cao cấp cho CPU Intel Gen 12/13/14, Wifi 7, DDR5', '/images/products/main_z790e.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-05 10:05:00+07'),
('LKDTPC003', 'RAM Corsair Vengeance LPX 32GB (2x16GB) DDR5 5600MHz', 5, 50, 'Bộ', 'Bộ nhớ RAM DDR5 hiệu năng cao, tản nhiệt nhôm, bus 5600MHz', '/images/products/ram_corsair_32gb.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-06 11:20:00+07'),
('LKDTPC004', 'Card màn hình NVIDIA GeForce RTX 4080 Super 16GB', 5, 15, 'Cái', 'Card đồ họa cao cấp, kiến trúc Ada Lovelace, 16GB GDDR6X', '/images/products/vga_rtx4080s.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-07 14:45:00+07'),
('LKDTPC005', 'Nguồn máy tính Corsair RM850x 850W 80 Plus Gold', 5, 40, 'Cái', 'Nguồn công suất thực 850W, chuẩn 80 Plus Gold, Full Modular', '/images/products/psu_rm850x.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-08 09:00:00+07'),
('LKDTPC006', 'Ổ cứng SSD Samsung 990 PRO 2TB NVMe PCIe 4.0', 5, 30, 'Cái', 'Ổ cứng SSD NVMe tốc độ cao, dung lượng 2TB, đọc/ghi tuần tự lên đến 7450/6900 MB/s', '/images/products/ssd_990pro_2tb.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-09 10:15:00+07'),
('LKDTPC007', 'Vỏ case NZXT H5 Flow Mid-Tower', 5, 25, 'Cái', 'Vỏ case máy tính mặt lưới thoáng khí, kính cường lực, hỗ trợ tản nhiệt tốt', '/images/products/case_h5_flow.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-10 13:30:00+07'),
('LKDTPC008', 'PC Gaming Prebuilt Titan X', 5, 5, 'Bộ', 'Máy tính chơi game lắp sẵn cấu hình cao, i7-14700K, RTX 4070 Ti, RAM 32GB, SSD 1TB', '/images/products/pc_titan_x.jpg', 'Đang kinh doanh - Còn hàng', '2025-03-11 15:00:00+07');