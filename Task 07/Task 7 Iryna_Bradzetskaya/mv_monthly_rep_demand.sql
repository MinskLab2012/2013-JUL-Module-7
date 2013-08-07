CREATE MATERIALIZED VIEW mv_monthly_rep_demand

BUILD IMMEDIATE
AS

SELECT tariff_type
     , tariff_name
     , tariff_code
     , operation_method_type
     , am_sum
     , count_tr
     ,  ROUND ( 100 * am_sum / ( SUM ( am_sum ) OVER (PARTITION BY tariff_type) )
                       , 3 )   prg
     , profit
          FROM (  SELECT tariff_type
                       , tariff_name
                       , tariff_code
                       , operation_method_type
                       , ROUND ( SUM ( payment_sum / currency_to_dollar )
                               , 2 )
                            am_sum
                       , COUNT ( payment_sum / currency_to_dollar ) count_tr
                       , ROUND ( SUM ( ( payment_sum / currency_to_dollar ) * tariff_payment_sum / 100 )
                               , 2 )
                            profit
                    FROM u_sa_data.tmp_transactions_info
                   WHERE tariff_type IN ('Local Transfer', 'International Transfer')
                     AND event_dt >= TRUNC ( TO_DATE ( '01-APR-2007'
                                                     , 'dd-mon-yyyy' )
                                           , 'month' )
                     AND event_dt <= (TRUNC ( TO_DATE ( ADD_MONTHS ( TO_DATE ( '01-APR-2007'
                                                                             , 'dd-mon-yyyy' )
                                                                   , 1 ) )
                                            , 'month' )
                                      - 1)
                GROUP BY tariff_type,  tariff_name, tariff_code, operation_method_type );
