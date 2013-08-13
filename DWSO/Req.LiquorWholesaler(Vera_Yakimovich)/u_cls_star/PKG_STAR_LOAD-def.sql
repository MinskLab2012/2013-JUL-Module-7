/* Formatted on 13.08.2013 16:32:42 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_star_load
AS
   PROCEDURE cls_dim_times_load_first;

   PROCEDURE dim_times_load;

   PROCEDURE cls_dim_customers_load;

   PROCEDURE dim_customers_load;

   PROCEDURE cls_dim_products_load;

   PROCEDURE dim_products_load;

   PROCEDURE cls_dim_geo_load;

   PROCEDURE dim_geo_load;

   PROCEDURE cls_fct_daily_load_first;

   PROCEDURE cls_fct_daily_load;

   PROCEDURE cls_fct_monthly_load_first;

   PROCEDURE cls_fct_monthly_load;
END pkg_star_load;