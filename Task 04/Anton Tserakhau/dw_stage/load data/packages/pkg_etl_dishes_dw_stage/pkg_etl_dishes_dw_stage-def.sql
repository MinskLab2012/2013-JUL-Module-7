CREATE OR REPLACE PACKAGE pkg_etl_dishes_dw_stage
-- Package Reload Data From Source Tables (cls_*) to DataBase - Dishes
--
AS  

   -- Load All Dish Types
   PROCEDURE load_t_dish_types;

   -- Load All Dish Cuisines
   PROCEDURE load_t_dish_cuisines;
    
   -- Load All Dishes 
   PROCEDURE load_t_dishes;
   
END pkg_etl_dishes_dw_stage;
/