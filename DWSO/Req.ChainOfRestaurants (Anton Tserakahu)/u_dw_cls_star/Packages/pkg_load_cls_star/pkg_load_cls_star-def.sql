CREATE OR REPLACE PACKAGE pkg_load_cls_star
AS

   PROCEDURE load_cls_dim_dishes;

   PROCEDURE load_cls_dim_geo;

   PROCEDURE load_cls_dim_periods;

   PROCEDURE load_cls_dim_restaurants;

   PROCEDURE load_cls_dim_times;

   PROCEDURE load_cls_fct_operations_dd;
   
END pkg_load_cls_star;
/