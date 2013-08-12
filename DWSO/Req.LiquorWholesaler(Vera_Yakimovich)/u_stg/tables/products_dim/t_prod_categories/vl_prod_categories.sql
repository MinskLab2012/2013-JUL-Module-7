--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.VL_PROD_CATEGORIES
AS
   SELECT   
PROD_CATEGORY_ID  ,
  CATEGORY_CODE   ,
  CATEGORY_DESC ,
  LOCALIZATION_ID   ,
  INSERT_DT      ,
  UPDATE_DT         
  FROM LC_PROD_CATEGORIES;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.VL_PROD_CATEGORIES to u_dw_ext_references;