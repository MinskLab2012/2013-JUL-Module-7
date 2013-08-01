/* Formatted on 01.08.2013 14:38:34 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_fin_groups_dw
-- Package Load Data From Source table to DataBase
--
AS
   PROCEDURE load_finance_groups;
END pkg_etl_fin_groups_dw;
/