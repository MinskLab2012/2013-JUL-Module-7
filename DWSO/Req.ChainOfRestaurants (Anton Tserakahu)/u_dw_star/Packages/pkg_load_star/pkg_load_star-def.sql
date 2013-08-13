CREATE OR REPLACE PACKAGE pkg_load_star
AS

   PROCEDURE load_dim_dishes;

   PROCEDURE load_dim_geo;

   PROCEDURE load_dim_periods;

   PROCEDURE load_dim_restaurants;

   PROCEDURE load_dim_times;

   PROCEDURE load_fct_operations_dd;
   
END pkg_load_star;
/