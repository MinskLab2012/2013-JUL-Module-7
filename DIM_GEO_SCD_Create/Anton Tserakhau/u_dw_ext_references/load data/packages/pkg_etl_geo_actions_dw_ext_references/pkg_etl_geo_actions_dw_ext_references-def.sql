CREATE OR REPLACE PACKAGE pkg_etl_geo_act_dw_ext_ref
-- Package Reload Data From Source Tables (cls_*) to DataBase - GEO Actions 
--
AS  

   -- Load All GEO Actions
   PROCEDURE load_geo_actions;


   
END pkg_etl_geo_act_dw_ext_ref;
/