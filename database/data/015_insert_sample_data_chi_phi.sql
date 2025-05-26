-- =================================================================
-- DU LIEU MAU - PHAN 8: CHI PHI (Thang 5/2025)
-- =================================================================

INSERT INTO ChiPhi (loai_chi_phi, so_tien, ngay_chi_phi, mo_ta, id_nhan_vien, ngay_tao_ban_ghi) VALUES
('Tiền thuê mặt bằng', 15000000, '2025-05-01', 'Tiền thuê mặt bằng cửa hàng tháng 5/2025', NULL, '2025-05-01 08:00:00+07'),
('Tiền điện', 2500000, '2025-05-05', 'Tiền điện hoạt động cửa hàng tháng 4 (thanh toán T5)', NULL, '2025-05-05 09:00:00+07'),
('Tiền nước', 500000, '2025-05-05', 'Tiền nước hoạt động cửa hàng tháng 4 (thanh toán T5)', NULL, '2025-05-05 09:05:00+07'),
('Internet & Điện thoại cố định', 800000, '2025-05-06', 'Cước Internet và điện thoại cửa hàng T5/2025', NULL, '2025-05-06 10:00:00+07'),
('Chi phí Marketing Online', 5000000, '2025-05-10', 'Chạy quảng cáo Facebook & Google Ads đợt 1 T5', NULL, '2025-05-10 11:00:00+07'),
('Văn phòng phẩm', 750000, '2025-05-12', 'Mua giấy A4, bút, mực in, sổ sách', (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'mai_nt_nv'), '2025-05-12 14:00:00+07'), -- Giả sử NV Mai mua
('Chi phí giao hàng (hỗ trợ shipper)', 1500000, '2025-05-15', 'Chi phí xăng xe, hỗ trợ cho shipper giao các đơn COD', NULL, '2025-05-15 16:00:00+07'),
('Sửa chữa nhỏ (bóng đèn hỏng)', 200000, '2025-05-18', 'Thay bóng đèn bị hỏng trong kho', NULL, '2025-05-18 09:30:00+07'),
('Chi phí Marketing Online', 4000000, '2025-05-20', 'Chạy quảng cáo Facebook & Google Ads đợt 2 T5', NULL, '2025-05-20 11:30:00+07'),
('Tiếp khách', 600000, '2025-05-22', 'Chi phí nước uống, cà phê tiếp đối tác', (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'quan_tv_qly'), '2025-05-22 15:00:00+07'), -- Giả sử Quản lý tiếp khách

-- Luong nhan vien (Giả sử lương cố định cho mục đích dữ liệu mẫu)
('Lương nhân viên tháng 5', 10000000, '2025-05-28', 'Lương tháng 5/2025 cho Trần Văn Quản (Quản lý)', (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'quan_tv_qly'), '2025-05-28 17:00:00+07'),
('Lương nhân viên tháng 5', 7000000, '2025-05-28', 'Lương tháng 5/2025 cho Nguyễn Thị Mai', (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'mai_nt_nv'), '2025-05-28 17:00:00+07'),
('Lương nhân viên tháng 5', 7000000, '2025-05-28', 'Lương tháng 5/2025 cho Lê Văn Hùng', (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'hung_lv_nv'), '2025-05-28 17:00:00+07'),
('Lương nhân viên tháng 5', 7000000, '2025-05-28', 'Lương tháng 5/2025 cho Phạm Thị Hoa', (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'hoa_pt_nv'), '2025-05-28 17:00:00+07'),
('Lương nhân viên tháng 5', 7000000, '2025-05-28', 'Lương tháng 5/2025 cho Hoàng Văn Nam', (SELECT id FROM NhanVien WHERE ten_dang_nhap = 'nam_hv_nv'), '2025-05-28 17:00:00+07');
-- Nhân viên Vũ Thị Lan Anh (ID=6) đã nghỉ việc nên không có lương tháng 5

INSERT INTO ChiPhi (loai_chi_phi, so_tien, ngay_chi_phi, mo_ta, id_nhan_vien, ngay_tao_ban_ghi) VALUES
('Chi phí đóng gói hàng hóa', 1200000, '2025-05-29', 'Mua thùng carton, băng keo, xốp chống sốc cho tháng 5', NULL, '2025-05-29 10:00:00+07'),
('Phí dịch vụ ngân hàng', 150000, '2025-05-30', 'Phí quản lý tài khoản, phí chuyển tiền T5', NULL, '2025-05-30 11:00:00+07'),
('Chi phí phát sinh khác', 300000, '2025-05-30', 'Mua một số vật tư nhỏ lẻ khác', NULL, '2025-05-30 15:00:00+07');