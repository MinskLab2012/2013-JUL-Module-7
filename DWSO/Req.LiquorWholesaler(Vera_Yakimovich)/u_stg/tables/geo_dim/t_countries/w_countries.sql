--drop view u_stg.w_countries;

--==============================================================
-- View: w_countries
--==============================================================
CREATE OR REPLACE VIEW u_stg.w_countries
AS
   SELECT geo_id
        , country_id
     FROM t_countries;

COMMENT ON TABLE u_stg.w_countries IS
'Work View: T_COUNTRIES';

COMMENT ON COLUMN u_stg.w_countries.geo_id IS
'Unique ID for All Geography objects';

COMMENT ON COLUMN u_stg.w_countries.country_id IS
'ID Code of Country';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_stg.w_countries TO u_dw_ext_references;