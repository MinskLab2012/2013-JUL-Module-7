--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.VL_PRODUCTS
AS
   SELECT   
  PRODUCT_ID        ,
  PRODUCT_NAME         ,
  PRODUCT_CODE        ,
  T_L_LOCALIZATION_ID  ,
  INSERT_DT         ,
  UPDATE_DT        
  FROM LC_PRODUCTS;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.VL_PRODUCTS to u_dw_ext_references;