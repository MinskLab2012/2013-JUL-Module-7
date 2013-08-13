
DROP TABLE u_dw_cls_stage.cls_geo_structure_iso3166 CASCADE CONSTRAINTS;

--==============================================================
-- Table: cls_geo_structure_iso3166
--==============================================================

CREATE TABLE u_dw_cls_stage.cls_geo_structure_iso3166
(
   child_code     NUMBER ( 10, 0 )
 , parent_code    NUMBER ( 10, 0 )
 , structure_desc VARCHAR2 ( 200 CHAR )
 , structure_level VARCHAR2 ( 200 CHAR )
);

COMMENT ON TABLE u_dw_cls_stage.cls_geo_structure_iso3166 IS
'Cleansing table for loading - Structure of GeoLocation world Dividing (USA standart)';

COMMENT ON COLUMN u_dw_cls_stage.cls_geo_structure_iso3166.child_code IS
'Code of Structure Element';

COMMENT ON COLUMN u_dw_cls_stage.cls_geo_structure_iso3166.parent_code IS
'Parent Code of Structure Element';

COMMENT ON COLUMN u_dw_cls_stage.cls_geo_structure_iso3166.structure_desc IS
'Description of Structure Element';

COMMENT ON COLUMN u_dw_cls_stage.cls_geo_structure_iso3166.structure_level IS
'Level grouping Code of Structure Element';