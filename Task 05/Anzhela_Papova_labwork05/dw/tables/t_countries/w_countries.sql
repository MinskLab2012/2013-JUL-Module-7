--drop view dw.w_countries;

--==============================================================
-- View: w_countries
--==============================================================
CREATE OR REPLACE VIEW dw.w_countries
AS
   SELECT geo_id
        , country_id
     FROM t_countries;

COMMENT ON TABLE dw.w_countries IS
'Work View: T_COUNTRIES';

COMMENT ON COLUMN dw.w_countries.geo_id IS
'Unique ID for All Geography objects';

COMMENT ON COLUMN dw.w_countries.country_id IS
'ID Code of Country';

GRANT DELETE,INSERT,UPDATE,SELECT ON dw.w_countries TO dw_cl;