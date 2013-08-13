CREATE OR REPLACE PACKAGE pkg_load_source_dishes
-- Package Reload Data From External Sources to DataBase - Dishes
--
AS  
   -- Extract Data from external source 
   -- Load All Dishes from external table
   PROCEDURE load_cls_dishes;
   
   
END pkg_load_source_dishes;
/