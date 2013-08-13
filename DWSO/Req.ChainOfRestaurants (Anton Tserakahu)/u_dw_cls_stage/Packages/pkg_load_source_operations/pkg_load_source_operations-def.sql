CREATE OR REPLACE PACKAGE pkg_load_source_operations
-- Package Reload Data From External Sources to DataBase - Operations
--
AS  
   -- Extract Data from temp source 
   -- Load All Operations from temp table
   PROCEDURE load_cls_operations;
   
   
END pkg_load_source_operations;
/