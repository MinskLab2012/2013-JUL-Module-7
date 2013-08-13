SELECT CASE
          WHEN ( tariff_code = '-' )
           AND ( operation_method_type = '-' )
           AND ( tariff_type IS NOT NULL ) THEN
             'TOTAL BY ' || tariff_type
          WHEN tariff_type IS NULL THEN
             'TOTAL'
          ELSE
             tariff_type
       END
          tariff_type
     , tariff_name
     , tariff_code
     , operation_method_type
     , am_sum
     , count_tr
     , to_char(ROUND ( 100 * am_sum / ( SUM ( am_sum ) OVER (PARTITION BY tariff_type) )
             , 3 )) || '%' 
          prg
     , profit
  FROM (SELECT *
          FROM (  SELECT tariff_type
                       , DECODE(GROUPING(tariff_name), 1, '-', tariff_name) tariff_name
                       , DECODE(GROUPING(tariff_code), 1, '-', tariff_code) tariff_code
                       , DECODE(GROUPING(operation_method_type), 1, '-', operation_method_type) operation_method_type
                       , ROUND ( SUM ( payment_sum / currency_to_dollar )
                               , 2 )
                            am_sum
                       , COUNT ( payment_sum / currency_to_dollar ) count_tr
                       , ROUND ( SUM ( ( payment_sum / currency_to_dollar ) * tariff_payment_sum / 100 )
                               , 2 )
                            profit
                    FROM u_dw_ext_references.tmp_transactions_info
                   WHERE tariff_type IN ('Local Transfer', 'International Transfer')
                     AND TRUNC ( event_dt
                               , 'DAY' ) = TO_DATE ( '15-APR-07' )
                GROUP BY CUBE ( tariff_type, (tariff_code, tariff_name), operation_method_type )
                  HAVING GROUPING_ID ( tariff_type
                                     , tariff_code
                                     , tariff_name
                                     , operation_method_type ) IN (0, 3, 7))) t