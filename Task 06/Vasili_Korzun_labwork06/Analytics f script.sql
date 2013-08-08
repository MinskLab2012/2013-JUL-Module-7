/* Formatted on 8/5/2013 7:57:48 PM (QP5 v5.139.911.3011) */
-- first / last

  SELECT TO_CHAR ( TRUNC ( transaction_dt
                         , 'yyyy' )
                 , 'yyyy' )
            AS calendar_year
       , country
       , MIN ( cost ) KEEP (DENSE_RANK FIRST ORDER BY country) min_sale
       , MAX ( cost ) KEEP (DENSE_RANK LAST ORDER BY country) max_sale
    FROM tmp_orders
GROUP BY TRUNC ( transaction_dt
               , 'yyyy' )
       , country
  HAVING country IN ('Belarus', 'Germany');

-- rank, dense rank and row number
  SELECT calendar_year
       , delivery_system_code
       , RANK ( ) OVER (ORDER BY calendar_year) AS RANK
       , DENSE_RANK ( ) OVER (ORDER BY calendar_year) AS drank
       , ROW_NUMBER ( ) OVER (PARTITION BY calendar_year ORDER BY delivery_system_code) AS rnumber
    FROM (  SELECT TO_CHAR ( TRUNC ( transaction_dt
                                   , 'yyyy' )
                           , 'yyyy' )
                      AS calendar_year
                 , delivery_system_code
              FROM tmp_orders
          GROUP BY TRUNC ( transaction_dt
                         , 'yyyy' )
                 , delivery_system_code)
ORDER BY calendar_year;

-- min, max, sum analytical functions
  SELECT calendar_year
       , delivery_system_code
       , amount_sold
       , MIN ( amount_sold ) OVER (PARTITION BY delivery_system_code) AS min_by_ds
       , MAX ( amount_sold ) OVER (PARTITION BY delivery_system_code) AS max_by_ds
       , SUM ( amount_sold ) OVER (PARTITION BY calendar_year) AS sum_in_year
    FROM (  SELECT TO_CHAR ( TRUNC ( transaction_dt
                                   , 'yyyy' )
                           , 'yyyy' )
                      AS calendar_year
                 , delivery_system_code
                 , SUM ( cost ) AS amount_sold
              FROM tmp_orders
          GROUP BY TRUNC ( transaction_dt
                         , 'yyyy' )
                 , delivery_system_code)
ORDER BY calendar_year;