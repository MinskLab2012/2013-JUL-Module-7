/* Formatted on 12.08.2013 13:26:31 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_tmp_countries_sal_cl
-- Package load difference between actual data in the table t_act_countries and data on SAL Layer from dim_countries_scd
--
AS
   PROCEDURE load_tmp_countries;
END pkg_etl_tmp_countries_sal_cl;
/