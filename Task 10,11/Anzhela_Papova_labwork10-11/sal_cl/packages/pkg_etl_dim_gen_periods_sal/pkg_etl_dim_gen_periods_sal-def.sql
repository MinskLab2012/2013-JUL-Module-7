/* Formatted on 10.08.2013 14:16:12 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_dim_gen_periods_sal
-- Package load Data about Budget deficit levels in Dimension entity SCD type 1
--
AS
   PROCEDURE load_dim_gen_periods;
END pkg_etl_dim_gen_periods_sal;
/