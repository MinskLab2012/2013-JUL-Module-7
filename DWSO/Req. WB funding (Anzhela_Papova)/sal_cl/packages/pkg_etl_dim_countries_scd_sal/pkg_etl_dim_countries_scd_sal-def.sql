/* Formatted on 10.08.2013 17:49:16 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_dim_countries_scd_sal
-- Package load countries in Dimension entity SCD type 2
AS
   PROCEDURE load_dim_countries_scd;
END pkg_etl_dim_countries_scd_sal;
/