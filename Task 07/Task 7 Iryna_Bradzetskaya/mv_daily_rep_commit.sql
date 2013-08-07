CREATE MATERIALIZED VIEW LOG ON u_sa_data.tmp_transactions_info
   WITH PRIMARY KEY
   INCLUDING NEW VALUES;
 
   CREATE MATERIALIZED VIEW mv_daily_rep_commit
   BUILD IMMEDIATE
   REFRESH  ON COMMIT
   AS  SELECT
                         tariff_type
                       , tariff_name
                       , tariff_code
                       , operation_method_type
                       ,  SUM ( payment_sum / currency_to_dollar )
                                                           am_sum
                       , COUNT ( payment_sum / currency_to_dollar ) count_tr
                       , SUM ( ( payment_sum / currency_to_dollar ) * tariff_payment_sum / 100 )
                                               profit
                                                           , COUNT ( ( payment_sum / currency_to_dollar ) * tariff_payment_sum / 100 ) cnt1
                    FROM u_sa_data.tmp_transactions_info
                   WHERE tariff_type IN ('Local Transfer', 'International Transfer')
                     AND TRUNC ( event_dt
                               , 'DAY' ) = TO_DATE ( '15-APR-07' )
                GROUP BY tariff_type,tariff_code, tariff_name, operation_method_type;

