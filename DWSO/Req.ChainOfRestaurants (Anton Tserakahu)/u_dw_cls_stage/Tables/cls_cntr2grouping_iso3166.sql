
DROP TABLE u_dw_cls_stage.cls_cntr2grouping_iso3166 CASCADE CONSTRAINTS;

--==============================================================
-- Table: cls_cntr2grouping_iso3166
--==============================================================

CREATE TABLE u_dw_cls_stage.cls_cntr2grouping_iso3166
(
   country_id     NUMBER ( 10, 0 )
 , county_desc    VARCHAR2 ( 200 CHAR )
 , group_code     NUMBER ( 10, 0 )
 , group_desc     VARCHAR2 ( 200 CHAR )
);

COMMENT ON TABLE u_dw_cls_stage.cls_cntr2grouping_iso3166 IS
'Cleansing table for loading - Links Countries to GeoLocation Sructure world Dividing  (USA standart)';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr2grouping_iso3166.country_id IS
'ISO - Country ID';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr2grouping_iso3166.county_desc IS
'ISO - Country Desc';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr2grouping_iso3166.group_code IS
'Code of Group Element';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr2grouping_iso3166.group_desc IS
'Description of Group Element';