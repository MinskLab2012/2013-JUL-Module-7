  SELECT tariff_type
       , tariff_name
       , event_dt
       , am_sum
       , par_sum
       , prg
    FROM (  SELECT event_dt
                 , tariff_type
                 , tariff_name
                 , ROUND ( SUM ( par_sum )
                         , 2 )
                      par_sum
                 , ROUND ( SUM ( am_sum )
                         , 2 )
                      am_sum
                 , ROUND ( SUM ( profit )
                         , 2 )
                      profit
                 , ROUND ( SUM ( count_tr )
                         , 2 )
                      count_tr
              FROM (  SELECT TRUNC ( TO_DATE ( event_dt
                                             , 'dd-mon-yyyy' )
                                   , 'month' )
                                event_dt
                           , tariff_type
                           , tariff_name
                           , SUM ( SUM ( payment_sum / currency_to_dollar ) ) OVER (PARTITION BY tariff_type) par_sum
                           , ROUND ( SUM ( payment_sum / currency_to_dollar )
                                   , 2 )
                                am_sum
                           , COUNT ( payment_sum / currency_to_dollar ) count_tr
                           , ROUND ( SUM ( ( payment_sum / currency_to_dollar ) * tariff_payment_sum / 100 )
                                   , 2 )
                                profit
                        FROM u_dw_ext_references.tmp_transactions_info
                       WHERE tariff_type IN ('Local Transfer', 'International Transfer')
                         AND tariff_name IN ('Small Transfer')
                         AND event_dt >= TRUNC ( TO_DATE ( '01-APR-2007'
                                                         , 'dd-mon-yyyy' )
                                               , 'month' )
                         AND event_dt <= (TRUNC ( TO_DATE ( ADD_MONTHS ( TO_DATE ( '01-APR-2008'
                                                                                 , 'dd-mon-yyyy' )
                                                                       , 1 ) )
                                                , 'month' )
                                          - 1)
                    GROUP BY (tariff_type, tariff_name, event_dt))
          GROUP BY (tariff_type, tariff_name, event_dt)) t
MODEL RETURN UPDATED ROWS
   PARTITION BY ( tariff_type, tariff_name )
   DIMENSION BY ( event_dt )
   MEASURES ( 0 prg, am_sum, par_sum )
   RULES AUTOMATIC ORDER
      ( prg [event_dt] = ROUND ( ( 100 * am_sum[CV ( event_dt )] / par_sum[CV ( event_dt )] )
                               , 5 ) )
ORDER BY 1
       , 2
       , 3;