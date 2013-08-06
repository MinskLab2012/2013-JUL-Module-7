CREATE OR REPLACE PACKAGE pkg_etl_periods_dw_stage 
-- Package Reload Data From Source Tables (cls_*) to DataBase - Periods
--
AS  

   -- Load All Period Types
   PROCEDURE load_t_period_types;
    

   -- Load All Periods
   PROCEDURE load_t_periods;
   
END pkg_etl_periods_dw_stage;
/