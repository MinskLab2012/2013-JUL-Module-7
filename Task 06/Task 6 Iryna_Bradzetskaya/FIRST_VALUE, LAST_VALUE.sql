SELECT "YEAR" , "Quarter", tariff_type, tariff_name , tariff_code , count_tr , profit
    FROM (SELECT "YEAR"               , "Quarter"               , tariff_type               , tariff_name
               , tariff_code               , count_tr               , profit               , 
     LAST_VALUE (
                              profit
                 )
                 OVER ( PARTITION BY "YEAR", "Quarter"
                        ORDER BY profit
                        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
                    AS lv
               , FIRST_VALUE (
                               profit
                 )
                 OVER ( PARTITION BY "YEAR", "Quarter"
                        ORDER BY profit
                        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
                    AS fv
            FROM (  SELECT TO_CHAR ( TRUNC ( event_dt
                                           , 'YYYY' )
                                   , 'YYYY' )
                              "YEAR"
                         , TO_CHAR ( TRUNC ( event_dt
                                           , 'Q' )
                                   , 'Q' )
                              "Quarter"
                         , tariff_type
                         , tariff_name
                         , tariff_code
                         , COUNT ( payment_sum / currency_to_dollar ) count_tr
                         , ROUND ( SUM ( ( payment_sum / currency_to_dollar ) * tariff_payment_sum / 100 )
                                 , 2 )
                              profit
                      FROM u_dw_ext_references.tmp_transactions_info
                     WHERE tariff_type IN ('Local Transfer', 'International Transfer')
                       AND event_dt >= TRUNC ( TO_DATE ( '01-JAN-2004'
                                                       , 'dd-mon-yyyy' )
                                             , 'month' )
                       AND event_dt <= (TRUNC ( TO_DATE ( ADD_MONTHS ( TO_DATE ( '01-JAN-2008'
                                                                               , 'dd-mon-yyyy' )
                                                                     , 1 ) )
                                              , 'month' )
                                        - 1)
                  GROUP BY tariff_type
                         , (tariff_code, tariff_name)
                         , TRUNC ( event_dt
                                 , 'YYYY' )
                         , TRUNC ( event_dt
                                 , 'Q' )))
   WHERE profit = lv OR  profit = fv
ORDER BY 1      , 2      , 3      , 7;
