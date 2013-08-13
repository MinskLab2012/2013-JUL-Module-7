SELECT tariff_type
                       , DECODE ( GROUPING ( tariff_name ), 1, '-', tariff_name ) tariff_name
                       , DECODE ( GROUPING ( tariff_code ), 1, '-', tariff_code ) tariff_code
                       , ROUND ( SUM ( AMOUNT_PAYMENT / currency_to_dollar )
                               , 2 )
                            am_sum
                       , COUNT (AMOUNT_PAYMENT / currency_to_dollar ) count_tr
                       , ROUND ( SUM ( ( AMOUNT_PAYMENT / currency_to_dollar ) * tariff_payment_sum / 100 )
                               , 2 )
                            profit
                    FROM u_sal.FCT_TRANSACTIONS_DAILY FCT_T
                    left outer join u_sal.DIM_TARIFFS  USING(TARIFF_ID)
                    left outer join u_sal.DIM_CURRENCY_SCD CUR_T ON (FCT_T.CURRENCY_SUR_ID = CUR_T.CURRENCY_SUR_ID
                    AND FCT_T.event_dt <= CUR_T.valid_to)
                   WHERE tariff_type IN ('Local Transfer', 'International Transfer')
                     AND event_dt >= TRUNC ( TO_DATE ( '01-APR-2007'
                                                     , 'dd-mon-yyyy' )
                                           , 'month' )
                     AND event_dt <= (TRUNC ( TO_DATE ( ADD_MONTHS ( TO_DATE ( '01-APR-2007'
                                                                             , 'dd-mon-yyyy' )
                                                                   , 1 ) )
                                            , 'month' )
                                      - 1)
                GROUP BY ROLLUP ( tariff_type, ( tariff_name, tariff_code ) )