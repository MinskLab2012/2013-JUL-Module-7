CREATE OR REPLACE PACKAGE pkg_etl_restaurants_dw_stage
-- Package Reload Data From Source Tables (cls_*) to DataBase - Restaurants
--
AS  

   -- Load All Restaurant Types
   PROCEDURE load_t_restaurant_types;
    

   -- Load All Restaurants 
   PROCEDURE load_t_restaurants;
   
END pkg_etl_restaurants_dw_stage;
/