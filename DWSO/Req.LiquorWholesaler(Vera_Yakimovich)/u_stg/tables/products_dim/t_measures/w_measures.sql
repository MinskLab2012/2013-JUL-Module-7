--drop view u_stg.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace FORCE view u_stg.W_MEASURES
AS
   SELECT   
   MEASURE_ID    ,
  MEASURE_CODE  ,
  MEASURE_DESC  ,
  QUANTITY    ,
  INSERT_DT    ,
  UPDATE_DT   
 
  FROM T_MEASURES;

grant DELETE,INSERT,UPDATE,SELECT on u_stg.W_MEASURES to u_dw_ext_references;