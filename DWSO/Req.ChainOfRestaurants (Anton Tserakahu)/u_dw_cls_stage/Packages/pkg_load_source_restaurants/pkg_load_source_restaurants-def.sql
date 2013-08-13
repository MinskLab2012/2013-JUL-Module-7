CREATE OR REPLACE PACKAGE pkg_load_source_restaurants
-- Package Reload Data From External Sources to DataBase - Restaurants
--
AS  
   -- Extract Data from temp source 
   -- Load All Restaurants from temp table
   PROCEDURE load_cls_restaurants;
   
   
END pkg_load_source_restaurants;
/