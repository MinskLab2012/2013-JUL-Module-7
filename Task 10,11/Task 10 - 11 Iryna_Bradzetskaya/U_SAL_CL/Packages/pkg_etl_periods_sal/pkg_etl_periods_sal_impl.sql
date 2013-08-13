CREATE OR REPLACE PACKAGE BODY pkg_etl_periods_sal
AS
   -- Reload Data From Stage table to Star
   PROCEDURE load_dim_periods
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_sal.dim_gen_periods sal_t
           USING (SELECT DISTINCT PERIOD_ID
                                , PERIOD_DESC
                                , PERIOD_VAL
                                , PERIOD_START_NUM
                                , PERIOD_END_NUM
                                , PERIOD_START_DATE
                                , PERIOD_END_DATE
                    FROM u_dw.dw_gen_periods) dw_t
              ON ( sal_t.PERIOD_ID = dw_t.PERIOD_ID)
      WHEN NOT MATCHED THEN
         INSERT            ( sal_t.PERIOD_ID
                                , sal_t.PERIOD_DESC
                                , sal_t.PERIOD_VAL
                                , sal_t.PERIOD_START_NUM
                                , sal_t.PERIOD_END_NUM
                                , sal_t.PERIOD_START_DATE
                                , sal_t.PERIOD_END_DATE
                           , sal_t.insert_dt )
             VALUES ( dw_t.PERIOD_ID
                                , dw_t.PERIOD_DESC
                                , dw_t.PERIOD_VAL
                                , dw_t.PERIOD_START_NUM
                                , dw_t.PERIOD_END_NUM
                                , dw_t.PERIOD_START_DATE
                                , dw_t.PERIOD_END_DATE
                    , SYSDATE)
      WHEN MATCHED THEN
         UPDATE SET  sal_t.PERIOD_START_NUM = dw_t.PERIOD_START_NUM
                   ,sal_t.PERIOD_END_NUM = dw_t.PERIOD_END_NUM
                  , sal_t.PERIOD_START_DATE = dw_t.PERIOD_START_DATE
                  , sal_t.PERIOD_END_DATE = dw_t.PERIOD_END_DATE
                  , sal_t.update_dt = SYSDATE
                  WHERE sal_t.PERIOD_START_NUM != dw_t.PERIOD_START_NUM or
                  sal_t.PERIOD_END_NUM != dw_t.PERIOD_END_NUM or
                  sal_t.PERIOD_START_DATE != dw_t.PERIOD_START_DATE or
                  sal_t.PERIOD_END_DATE != dw_t.PERIOD_END_DATE
                  ;
     COMMIT;
   END load_dim_periods;
END pkg_etl_periods_sal;