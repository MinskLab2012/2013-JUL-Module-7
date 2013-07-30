/* Formatted on 30.07.2013 17:46:32 (QP5 v5.139.911.3011) */
  SELECT year_numb
       , quarter_numb
       , month_mm
       , month_month
       , week
       , day_dd
       , day_day
       , SUM ( unit_amount ) AS amount
       , SUM ( total_price_dol ) AS total_price
    FROM (SELECT oper.event_dt
               , TO_CHAR ( TRUNC ( oper.event_dt
                                 , 'DD' )
                         , 'DD' )
                    AS day_dd
               , TO_CHAR ( TRUNC ( oper.event_dt
                                 , 'DD' )
                         , 'Day' )
                    AS day_day
               , TO_CHAR ( TRUNC ( oper.event_dt
                                 , 'W' )
                         , 'W' )
                    AS week
               , TO_CHAR ( TRUNC ( oper.event_dt
                                 , 'MM' )
                         , 'MM' )
                    AS month_mm
               , TO_CHAR ( TRUNC ( oper.event_dt
                                 , 'MM' )
                         , 'Month' )
                    AS month_month
               , TO_CHAR ( TRUNC ( oper.event_dt
                                 , 'Q' )
                         , 'Q' )
                    AS quarter_numb
               , TO_CHAR ( TRUNC ( oper.event_dt
                                 , 'YYYY' )
                         , 'YYYY' )
                    AS year_numb
               , oper.unit_amount
               , oper.total_price_dol
            FROM cls_operations oper)
GROUP BY ROLLUP ( year_numb, quarter_numb, ( month_mm, month_month ), week, ( day_dd, day_day ) )
ORDER BY year_numb
       , quarter_numb
       , month_mm
       , week
       , day_dd;