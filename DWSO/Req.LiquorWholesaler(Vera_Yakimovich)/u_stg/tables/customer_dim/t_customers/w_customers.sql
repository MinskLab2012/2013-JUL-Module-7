--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.w_customers
AS
   SELECT   
  CUSTOMER_ID   ,
  CUST_CODE    ,
  GEO_ID          ,
  CUST_STATUS_ID ,
  INSERT_DT ,
  UPDATE_DT   
  FROM t_customers;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.w_customers to u_dw_ext_references;