/* Formatted on 09.08.2013 20:47:38 (QP5 v5.139.911.3011) */
BEGIN
   pkg_load_ext_ref_cars.load_brands;
   pkg_load_ext_ref_cars.load_models;
   pkg_load_ext_ref_cars.load_cars;
   pkg_load_ext_ref_cust_emp.load_cities;
   pkg_load_ext_ref_cust_emp.load_customers;
   pkg_load_ext_ref_cust_emp.load_offices;
   pkg_load_ext_ref_cust_emp.load_employees;
   pkg_load_ext_ref_contr.load_contracts;
   pkg_load_geo_links_actions.load_geo_links_actions;
END;
/