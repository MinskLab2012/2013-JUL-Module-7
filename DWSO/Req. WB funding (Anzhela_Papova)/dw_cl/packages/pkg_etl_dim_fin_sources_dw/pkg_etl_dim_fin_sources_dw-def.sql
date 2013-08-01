CREATE OR REPLACE PACKAGE pkg_etl_dim_fin_sources_dw
-- Package Reload Data From Sources table to DataBase - Finance Sources
--
AS  
   PROCEDURE load_finance_sources;    
END pkg_etl_dim_fin_sources_dw;
/