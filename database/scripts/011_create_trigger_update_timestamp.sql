-- Script to create function and triggers for auto-updating 'ngay_cap_nhat_ban_ghi'

-- 1. Create or Replace the function
CREATE OR REPLACE FUNCTION fn_cap_nhat_ngay_gio_sua()
RETURNS TRIGGER AS $$
BEGIN
   NEW.ngay_cap_nhat_ban_ghi = NOW();
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Create trigger for DonHangNhap table
CREATE TRIGGER trg_donhangnhap_cap_nhat_ngay_gio_sua
BEFORE UPDATE ON DonHangNhap
FOR EACH ROW
EXECUTE FUNCTION fn_cap_nhat_ngay_gio_sua();

-- 3. Create trigger for DonHangBan table
CREATE TRIGGER trg_donhangban_cap_nhat_ngay_gio_sua
BEFORE UPDATE ON DonHangBan
FOR EACH ROW
EXECUTE FUNCTION fn_cap_nhat_ngay_gio_sua();