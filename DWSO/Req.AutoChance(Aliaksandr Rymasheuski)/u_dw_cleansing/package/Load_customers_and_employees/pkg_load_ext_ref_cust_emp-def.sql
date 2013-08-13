CREATE OR REPLACE PACKAGE pkg_load_ext_ref_cust_emp
-- Package Reload Data From External Sources to DataBase
AS
   PROCEDURE load_cities;
   PROCEDURE load_customers;
   PROCEDURE load_offices;
 PROCEDURE load_employees;
END;
/