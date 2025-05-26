CREATE TABLE ChiTietDonHangBan (
    id SERIAL PRIMARY KEY,
    id_don_hang_ban INTEGER NOT NULL,
    id_san_pham INTEGER NOT NULL,
    so_luong INTEGER NOT NULL CHECK (so_luong > 0),
    gia_von_don_vi NUMERIC(12, 0) NOT NULL CHECK (gia_von_don_vi >= 0),
    gia_ban_niem_yet_don_vi NUMERIC(12, 0) NOT NULL CHECK (gia_ban_niem_yet_don_vi >= 0),
    loai_giam_gia VARCHAR(100) NULL, -- Mặc định là NULL
    gia_ban_cuoi_cung_don_vi NUMERIC(12, 0) NOT NULL CHECK (gia_ban_cuoi_cung_don_vi >= 0),
    ghi_chu TEXT NULL,
    CONSTRAINT fk_don_hang_ban_chitiet
        FOREIGN KEY(id_don_hang_ban)
        REFERENCES DonHangBan(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_san_pham_chitietban
        FOREIGN KEY(id_san_pham)
        REFERENCES SanPham(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT unique_sanpham_trong_don_ban UNIQUE (id_don_hang_ban, id_san_pham)
);