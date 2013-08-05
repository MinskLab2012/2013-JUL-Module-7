CREATE OR REPLACE PACKAGE pkg_etl_operations_dw_stage
-- Package Reload Data From Source Tables (cls_*) to DataBase - Operations
--
AS  

  
   -- Load All Operations 
   PROCEDURE load_t_operations;
   
END pkg_etl_operations_dw_stage;
/