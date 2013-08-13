create or replace package pkg_load_sal_star
as
procedure load_dim_payment_systems;
procedure load_fct_sales_dd;
procedure load_dim_delivery_systems;
procedure load_dim_times;
procedure load_dim_products;
end pkg_load_sal_star;