--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.W_PROD_CATEGORY
AS
   SELECT   
PROD_CATEGORY_ID  ,
  CATEGORY_CODE   ,
  INSERT_DT      ,
  UPDATE_DT         
  FROM T_PROD_CATEGORY;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.W_PROD_CATEGORY to u_dw_ext_references;