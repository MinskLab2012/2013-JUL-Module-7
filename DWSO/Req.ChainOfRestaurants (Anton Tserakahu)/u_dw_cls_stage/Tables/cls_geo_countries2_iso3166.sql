
DROP TABLE u_dw_cls_stage.cls_geo_countries2_iso3166 CASCADE CONSTRAINTS;

--==============================================================
-- Table: cls_geo_countries2_iso3166
--==============================================================

CREATE TABLE u_dw_cls_stage.cls_geo_countries2_iso3166
(
   country_desc   VARCHAR2 ( 200 CHAR )
 , country_code   VARCHAR2 ( 30 CHAR )
);

COMMENT ON TABLE u_dw_cls_stage.cls_geo_countries2_iso3166 IS
'Cleansing table for loading - Countries';

COMMENT ON COLUMN u_dw_cls_stage.cls_geo_countries2_iso3166.country_desc IS
'ISO - Country Name';

COMMENT ON COLUMN u_dw_cls_stage.cls_geo_countries2_iso3166.country_code IS
'ISO - Alpha Name 3';

ALTER TABLE u_dw_cls_stage.cls_geo_countries2_iso3166
   ADD CONSTRAINT chk_cls_geo_country2_code CHECK (country_code IS NULL OR (country_code = UPPER(country_code)));