/* Formatted on 7/30/2013 4:43:14 PM (QP5 v5.139.911.3011) */
  SELECT EXTRACT ( YEAR FROM TRUNC ( event_dt
                                   , 'Year' ) )
            AS year
       , CEIL ( TO_CHAR ( TRUNC ( event_dt
                                , 'Q' )
                        , 'mm' )
               / 3 )
            AS quarter
       , TRUNC ( event_dt
               , 'Month' )
            AS month
       , TRUNC ( event_dt
               , 'DDD' )
            AS day
       , SUM ( fct_quantity ) AS quantity
       , SUM ( fct_amount ) AS amount
    FROM tmp_transactions
GROUP BY ROLLUP ( TRUNC ( event_dt
                        , 'Year' ), TRUNC ( event_dt
                                          , 'Q' ), TRUNC ( event_dt
                                                         , 'Month' ), TRUNC ( event_dt
                                                                            , 'DDD' ) );