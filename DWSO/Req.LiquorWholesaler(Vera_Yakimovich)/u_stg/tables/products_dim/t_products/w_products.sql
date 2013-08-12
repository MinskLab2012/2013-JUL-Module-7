--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.W_PRODUCTS
AS
   SELECT   
  PRODUCT_ID        ,
  PRODUCT_CODE        ,
  PROD_CATEGORY_ID,
  MEASURE_ID    ,
  QUANTITY    ,
  COST   ,
  INSERT_DT         ,
  UPDATE_DT        
  FROM T_PRODUCTS;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.W_PRODUCTS to u_dw_ext_references;