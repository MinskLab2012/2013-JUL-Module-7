CREATE OR REPLACE PACKAGE pkg_load_source_periods
-- Package Reload Data From External Sources to DataBase - Periods
--
AS  
   -- Extract Data from temp source 
   -- Load All Periods from temp table
   PROCEDURE load_cls_periods;
   
   
END pkg_load_source_periods;
/