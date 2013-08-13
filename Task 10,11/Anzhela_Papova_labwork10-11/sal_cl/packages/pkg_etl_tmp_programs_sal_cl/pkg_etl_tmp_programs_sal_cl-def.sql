/* Formatted on 10.08.2013 14:16:12 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_tmp_programs_sal_cl
-- Package load difference between actual data in the table t_act_programs and data on SAL Layer from dim_programs_scd 
--
AS
   PROCEDURE load_tmp_programs;
END pkg_etl_tmp_programs_sal_cl;
/