--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.vl_customers
AS
   SELECT   
     CUSTOMER_ID  ,
  CUST_CODE       ,
  CUST_DESC    ,
  LOCALIZATION_ID ,
  INSERT_DT   ,
  UPDATE_DT   
  FROM lc_customers;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.vl_customers to u_dw_ext_references;