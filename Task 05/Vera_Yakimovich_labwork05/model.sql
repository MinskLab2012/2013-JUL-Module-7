/* Formatted on 04.08.2013 18:37:57 (QP5 v5.139.911.3011) */
DROP TABLE temp;

CREATE TABLE temp
AS
     SELECT TO_CHAR ( TRUNC ( event_dt
                            , 'year' ) , 'YYYY')
               AS ord_year
          , TO_CHAR ( TRUNC ( event_dt
                            , 'q' )
                    , 'Q' )
               AS ord_q
          , TO_CHAR ( TRUNC ( event_dt
                            , 'month' )
                    , 'MM' )
               AS ord_mon
          , tor.country_desc
          , SUM ( tor.total_price ) AS price
          , SUM ( price * set_quantity ) AS cost
       FROM t_orders tor
   GROUP BY TRUNC ( event_dt
                  , 'year' )
          , TRUNC ( event_dt
                  , 'q' )
          , TRUNC ( event_dt
                  , 'month' )
          , country_desc;

  SELECT ord_year
       , ord_q
       , ord_mon
       , country_desc
       , cost
       , price
       , income
       , profit
    FROM temp
   WHERE country_desc = 'Gabon'  and ord_year = 2000
MODEL RETURN UPDATED ROWS
   PARTITION BY ( ord_year, country_desc )
   DIMENSION BY ( ord_q, ord_mon )
   MEASURES ( 0 income, 1 profit, price, cost )
   RULES AUTOMATIC ORDER
      ( income [ord_q, ord_mon] =
            ROUND ( ( price[CV ( ord_q ), CV ( ord_mon )] - NVL ( cost[CV ( ord_q ), CV ( ord_mon )], 0 ) )
                  , 2 ),
      profit [ord_q, ord_mon] =
            ROUND ( income[CV ( ord_q ), CV ( ord_mon )] / cost[CV ( ord_q ), CV ( ord_mon )]
                  , 2 ) )
ORDER BY 1
       , 2
       , 3;