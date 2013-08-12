--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.w_cust_status
AS
   SELECT    STATUS_ID ,
  STATUS_CODE  ,
  INSERT_DT    ,
  UPDATE_DT   
  FROM t_cust_status;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.w_cust_status to u_dw_ext_references;