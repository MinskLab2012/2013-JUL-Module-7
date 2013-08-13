/* Formatted on 13.08.2013 16:45:43 (QP5 v5.139.911.3011) */
BEGIN
   pkg_star_load.cls_dim_times_load_first;
   pkg_star_load.dim_times_load;
   pkg_star_load.cls_dim_customers_load;
   pkg_star_load.dim_customers_load;
   pkg_star_load.cls_dim_products_load;
   pkg_star_load.dim_products_load;
   pkg_star_load.cls_dim_geo_load;
   pkg_star_load.dim_geo_load;
   --pkg_star_load.cls_fct_daily_load_first; -- needed only for archive load into fct
   pkg_star_load.cls_fct_daily_load;
   --pkg_star_load.cls_fct_monthly_load_first; -- needed only for archive load into fct
   pkg_star_load.cls_fct_monthly_load;
END;