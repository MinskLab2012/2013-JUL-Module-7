/* Formatted on 10.08.2013 14:16:12 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_act_programs_dw_cl
-- Package load Actual Data about  programs and theirs managers from DW Layer
--
AS
   PROCEDURE load_act_programs;
END pkg_etl_act_programs_dw_cl;
/