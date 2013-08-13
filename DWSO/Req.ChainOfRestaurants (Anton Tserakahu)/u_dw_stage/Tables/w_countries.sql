drop view u_dw_stage.w_countries;

--==============================================================
-- View: w_countries
--==============================================================
CREATE OR REPLACE VIEW u_dw_stage.w_countries
AS
   SELECT geo_id
        , country_id
     FROM t_countries;

COMMENT ON TABLE u_dw_stage.w_countries IS
'Work View: T_COUNTRIES';

COMMENT ON COLUMN u_dw_stage.w_countries.geo_id IS
'Unique ID for All Geography objects';

COMMENT ON COLUMN u_dw_stage.w_countries.country_id IS
'ID Code of Country';