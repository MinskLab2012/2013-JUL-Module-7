CREATE OR REPLACE PACKAGE pkg_etl_gen_periods_dw
-- Package Reload Data From Source table to DataBase - Finance Items
--
AS  
   PROCEDURE load_gen_periods;    
END pkg_etl_gen_periods_dw;
/
