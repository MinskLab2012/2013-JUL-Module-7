/* Formatted on 10.08.2013 17:49:16 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_dim_time_mm_sal
-- Package load Month sequence in Dimension entity SCD type 1
AS
   PROCEDURE load_dim_time_mm;
END pkg_etl_dim_time_mm_sal;
/