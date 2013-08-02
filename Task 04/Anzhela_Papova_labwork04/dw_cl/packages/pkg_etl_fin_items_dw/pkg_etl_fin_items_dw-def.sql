CREATE OR REPLACE PACKAGE pkg_etl_fin_items_dw
-- Package Reload Data From Source table to DataBase - Finance Items
--
AS  
   PROCEDURE load_finance_items;    
END pkg_etl_fin_items_dw;
/
