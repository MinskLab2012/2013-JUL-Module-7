CREATE OR REPLACE PACKAGE BODY pkg_load_fct_transactions_tmp
AS
   PROCEDURE load_fct_transactions_tmp ( tr_year IN NUMBER )
   AS
      sql_str        VARCHAR2 ( 3000 );
       sql_str1        VARCHAR2 ( 100 );
        sql_str2       VARCHAR2 ( 100 );
   BEGIN
      sql_str     :=
         ' INSERT /*+ append*/
         INTO u_sal_cl.TMP_TRANSACTIONS_DAILY
          SELECT event_dt
          ,CUST_SEND_ID
          , CUST_REC_ID
          , g_scd_send.geo_id AS CUST_SEND_GEO_ID
       , g_scd_rec.geo_id AS CUST_REC_GEO_ID
       , CURRENCY_SUR_ID
       , OPERATION_ID
       , TARIFF_ID
       , PERIOD_ID
       , P_SUM
       , C_TR
       , g_scd_send.GEO_COUNTRY_ID AS TA_COUNTRY_SEND_ID
       , g_scd_rec.GEO_COUNTRY_ID AS TA_COUNTRY_REC_ID
       , SYSDATE

  FROM 
(SELECT TRUNC ( event_dt
               , ''DD'' ) event_dt
       , TRANSACTION_ID
       , CURRENCY_ID
       , TARIFF_ID
       , OPERATION_ID
       , CUST_SEND_GEO_ID
       , CUST_REC_GEO_ID
       , CUST_SEND_ID
       , CUST_REC_ID
       , SUM ( payment_sum ) P_SUM
       , COUNT ( payment_sum ) C_TR
    FROM u_dw.DW_TRANSACTIONS
GROUP BY TRUNC ( event_dt
               , ''DD'' )
       , TRANSACTION_ID
       , CURRENCY_ID
       , TARIFF_ID
       , OPERATION_ID
       , CUST_SEND_GEO_ID
       , CUST_REC_GEO_ID
       , CUST_SEND_ID
       , CUST_REC_ID) t1
LEFT OUTER JOIN U_SAL.DIM_GEN_PERIODS t2 ON (P_SUM < PERIOD_END_NUM and P_SUM > PERIOD_START_NUM)
 LEFT JOIN u_sal.DIM_LOCATIONS_SCD g_scd_send
            ON ( t1.CUST_SEND_GEO_ID = g_scd_send.geo_id
            AND t1.event_dt <= g_scd_send.valid_to
            AND g_scd_send.level_code = ''Countries'' )
 LEFT JOIN u_sal.DIM_LOCATIONS_SCD g_scd_rec
            ON ( t1.CUST_REC_GEO_ID = g_scd_rec.geo_id
            AND t1.event_dt <= g_scd_rec.valid_to
            AND g_scd_rec.level_code = ''Countries'' )
LEFT JOIN u_sal.DIM_CURRENCY_SCD c_scd
            ON ( t1.CURRENCY_ID = c_scd.CURRENCY_SUR_ID
            AND t1.event_dt <= c_scd.valid_to )
WHERE EXTRACT ( YEAR FROM event_dt ) = :p';

      EXECUTE IMMEDIATE sql_str
      USING tr_year;
      COMMIT;
      
      sql_str1    := 'ALTER TABLE u_sal.FCT_TRANSACTIONS_DAILY EXCHANGE PARTITION part';
      sql_str2    := ' WITH TABLE u_sal_cl.TMP_TRANSACTIONS_DAILY INCLUDING INDEXES WITHOUT VALIDATION';
      sql_str     := sql_str1 || tr_year || sql_str2;
      
      EXECUTE IMMEDIATE sql_str;

   END load_fct_transactions_tmp;
END pkg_load_fct_transactions_tmp;