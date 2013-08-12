--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.vl_cust_status
AS
   SELECT   STATUS_ID       ,
  STATUS_CODE   ,
  STATUS_DESC  ,
  LOCALIZATION_ID 
  FROM lc_cust_status;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.vl_cust_status to u_dw_ext_references;