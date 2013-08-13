CREATE OR REPLACE PACKAGE pkg_load_ext_ref_cars
-- Package Reload Data From External Sources to DataBase
AS
   PROCEDURE load_brands;
  PROCEDURE load_models;
  PROCEDURE load_cars;
END;
/