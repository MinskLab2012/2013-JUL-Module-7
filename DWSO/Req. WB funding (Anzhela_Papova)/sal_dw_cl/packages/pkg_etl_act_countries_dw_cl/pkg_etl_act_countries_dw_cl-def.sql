/* Formatted on 10.08.2013 14:16:12 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_act_countries_dw_cl
-- Package load Actual Data about  countries from DW Layer
--
AS
   PROCEDURE load_act_countries;
END  pkg_etl_act_countries_dw_cl;
/