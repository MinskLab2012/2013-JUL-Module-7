/* Formatted on 30.07.2013 21:19:09 (QP5 v5.139.911.3011) */
  SELECT TO_CHAR ( TRUNC ( event_dt
                         , 'YEAR' )
                 , 'YYYY' )
            AS cal_year
       , TO_CHAR ( TRUNC ( event_dt
                         , 'Q' )
                 , 'Q' )
            AS cal_quart
       , TO_CHAR ( TRUNC ( event_dt
                         , 'MONTH' )
                 , 'MM' )
            AS cal_month
       , TO_CHAR ( TRUNC ( event_dt
                         , 'w' )
                 , 'W' )
            AS week_num
       , TO_CHAR ( TRUNC ( event_dt
                         , 'DD' )
                 , 'DDD' )
            AS cal_day_in_year
       , CASE
            WHEN GROUPING_ID ( TRUNC ( event_dt
                                     , 'YEAR' )
                             , TRUNC ( event_dt
                                     , 'Q' )
                             , TRUNC ( event_dt
                                     , 'MONTH' )
                             , TRUNC ( event_dt
                                     , 'w' )
                             , TRUNC ( event_dt
                                     , 'DD' ) ) >= 1 THEN
               NULL
            WHEN TO_CHAR ( TRUNC ( event_dt
                                 , 'DD' )
                         , 'D' ) = 7
              OR  TO_CHAR ( TRUNC ( event_dt
                                  , 'DD' )
                          , 'D' ) = 1 THEN
               'day off'
            ELSE
               'workday'
         END
            AS workday_indic
       , SUM ( price ) AS income
       , SUM ( set_quantity ) AS rev
    FROM t_orders
GROUP BY ROLLUP ( TRUNC ( event_dt
                        , 'YEAR' ), TRUNC ( event_dt
                                          , 'Q' ), TRUNC ( event_dt
                                                         , 'MONTH' ), TRUNC ( event_dt
                                                                            , 'w' ), TRUNC ( event_dt
                                                                                           , 'DD' ) )
ORDER BY 1
       , 2
       , 3
       , 4
       , 5;