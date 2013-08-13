CREATE OR REPLACE PACKAGE BODY pkg_etl_periods_dw
AS
   PROCEDURE load_periods
AS
BEGIN
DELETE FROM U_DW.DW_GEN_PERIODS;
INSERT INTO  U_DW.DW_GEN_PERIODS (period_id, period_desc, period_start_num, period_end_num ) VALUES (1, 'A', 0, 100);
INSERT INTO  U_DW.DW_GEN_PERIODS (period_id, period_desc, period_start_num, period_end_num ) VALUES (2, 'B', 101, 1000);
INSERT INTO  U_DW.DW_GEN_PERIODS (period_id, period_desc, period_start_num, period_end_num ) VALUES (3, 'C', 1001, 10000);
INSERT INTO  U_DW.DW_GEN_PERIODS (period_id, period_desc, period_start_num, period_end_num ) VALUES (4, 'D', 10001, 50000);
INSERT INTO  U_DW.DW_GEN_PERIODS (period_id, period_desc, period_start_num, period_end_num ) VALUES (5, 'E', 50001,100000 );
INSERT INTO  U_DW.DW_GEN_PERIODS (period_id, period_desc, period_start_num, period_end_num ) VALUES (6, 'F', 100001, 1000000);
      COMMIT;
   END load_periods;
END pkg_etl_periods_dw;