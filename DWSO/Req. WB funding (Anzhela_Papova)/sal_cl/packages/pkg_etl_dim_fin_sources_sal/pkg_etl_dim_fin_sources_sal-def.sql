/* Formatted on 10.08.2013 17:19:34 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_dim_fin_sources_sal
-- Package load Data about finance sources in Dimension entity SCD type 1
--
AS
   PROCEDURE load_dim_fin_sources;
END pkg_etl_dim_fin_sources_sal;
/