
DROP TABLE u_dw_cls_stage.cls_cntr_grouping_iso3166 CASCADE CONSTRAINTS;

--==============================================================
-- Table: cls_cntr_grouping_iso3166
--==============================================================

CREATE TABLE u_dw_cls_stage.cls_cntr_grouping_iso3166
(
   child_code     NUMBER ( 10, 0 )
 , parent_code    NUMBER ( 10, 0 )
 , group_desc     VARCHAR2 ( 200 CHAR )
 , group_level    VARCHAR2 ( 200 CHAR )
);

COMMENT ON TABLE u_dw_cls_stage.cls_cntr_grouping_iso3166 IS
'Cleansing table for loading - Structure of GeoLocation world Dividing (USA standart)';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr_grouping_iso3166.child_code IS
'Code of Group Element';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr_grouping_iso3166.parent_code IS
'Parent Code of Group Element';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr_grouping_iso3166.group_desc IS
'Description of GroupElement';

COMMENT ON COLUMN u_dw_cls_stage.cls_cntr_grouping_iso3166.group_level IS
'Level grouping Code of Group Element';