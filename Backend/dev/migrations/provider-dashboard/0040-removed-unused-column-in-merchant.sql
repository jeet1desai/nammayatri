ALTER TABLE atlas_bpp_dashboard.merchant DROP COLUMN email_encrypted
ALTER TABLE atlas_bpp_dashboard.merchant DROP COLUMN email_hash
ALTER TABLE atlas_bpp_dashboard.merchant DROP COLUMN password_hash
ALTER TABLE atlas_safety_dashboard.merchant DROP COLUMN company_name;
ALTER TABLE atlas_bpp_dashboard.merchant ADD COLUMN auth_token Text;
ALTER TABLE atlas_bpp_dashboard.person ADD COLUMN dashboard_access_type Text;
ALTER TABLE atlas_bpp_dashboard.merchant ADD COLUMN enabled Boolean;
