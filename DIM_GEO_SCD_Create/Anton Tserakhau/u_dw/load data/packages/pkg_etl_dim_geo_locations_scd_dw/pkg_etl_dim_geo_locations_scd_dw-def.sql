CREATE OR REPLACE PACKAGE pkg_etl_dim_geo_loc_scd_dw
-- Package Reload Data From Source Tables (cls_*) to DataBase - DIM GEO Locations
--
AS  

   -- Load dim_geo_locations_scd
   PROCEDURE load_dim_geo_locations_scd;


   
END pkg_etl_dim_geo_loc_scd_dw;
/