
--FIRST_VALUE, LAST_VALUE
--shows the most and the least profitable brands of cars in Belarus

  SELECT month
       , brand
       , TO_CHAR ( profit
                 , '$99,999,999,999' )
            AS profit
    FROM (  SELECT EXTRACT ( MONTH FROM event_dt ) AS month
                 , brand
                 , SUM ( price - cost ) AS profit
                 , FIRST_VALUE ( SUM ( price - cost ) )
                      OVER (PARTITION BY EXTRACT ( MONTH FROM event_dt ) ORDER BY SUM ( price - cost ) DESC)
                      AS max_profit_in_month
                 , LAST_VALUE (
                                SUM ( price - cost )
                   )
                   OVER ( PARTITION BY EXTRACT ( MONTH FROM event_dt )
                          ORDER BY SUM ( price - cost ) DESC
                          ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
                      AS min_profit_in_month
              FROM contracts
             WHERE cost < price
               AND customer_country LIKE 'Belarus'
               AND EXTRACT ( YEAR FROM event_dt ) = :year
          GROUP BY EXTRACT ( MONTH FROM event_dt )
                 , brand)
   WHERE profit = max_profit_in_month
      OR  profit = min_profit_in_month
ORDER BY month
       , profit DESC;


    --ROW_NUMBER
    --Shows 5 the best-selling brands of cars in Minsk by years

SELECT DECODE ( rn, 1, "Year", '' ) AS "Year"
     , rn AS "N/N"
     , brand
     , quantity_sold
  FROM (  SELECT EXTRACT ( YEAR FROM event_dt ) AS "Year"
               , brand
               , COUNT ( brand ) AS quantity_sold
               , ROW_NUMBER ( ) OVER (PARTITION BY EXTRACT ( YEAR FROM event_dt ) ORDER BY COUNT ( brand ) DESC) AS rn
            FROM contracts
           WHERE customer_city LIKE 'Minsk'
        GROUP BY EXTRACT ( YEAR FROM event_dt )
               , brand)
 WHERE rn < 6;



 -- DENSE_RANK
 --Shows 3 the most profitable brands in Minsk

SELECT DECODE ( "Rank", 1, "Year", '' ) AS "Year"
     , brand
     , TO_CHAR ( profit
               , '$99,999,999,999' )
          AS profit
  FROM (  SELECT EXTRACT ( YEAR FROM event_dt ) AS "Year"
               , brand
               , SUM ( price - cost ) AS profit
               , DENSE_RANK ( ) OVER (PARTITION BY EXTRACT ( YEAR FROM event_dt ) ORDER BY SUM ( price - cost ) DESC)
                    AS "Rank"
            FROM contracts
           WHERE customer_city LIKE 'Minsk'
        GROUP BY EXTRACT ( YEAR FROM event_dt )
               , brand)
 WHERE "Rank" < 4;


-- MAX, MIN, AVG, RANK
--Shows brands of cars, different between profit of the current brand and max and min profits in the current month,
-- wich have profit more than average profit in current month
  SELECT DECODE ( r, 1, month, '' ) AS "Month"
       , brand
       , TO_CHAR ( profit
                 , '$99,999,999,999' )
            AS profit
       , TO_CHAR ( ( profit - max_profit_in_month )
                 , '$99,999,999,999' )
            AS "Profit-MAX profit"
       , TO_CHAR ( ( profit - min_profit_in_month )
                 , '$99,999,999,999' )
            AS "Profit-MIN profit"
       , TO_CHAR ( ROUND ( profit - avg_profit_in_month )
                 , '$99,999,999,999' )
            AS "Profit-AVG profit"
    FROM (  SELECT EXTRACT ( MONTH FROM event_dt ) AS month
                 , brand
                 , SUM ( price - cost ) AS profit
                 , MAX ( SUM ( price - cost ) ) OVER (PARTITION BY EXTRACT ( MONTH FROM event_dt )) AS max_profit_in_month
                 , MIN ( SUM ( price - cost ) ) OVER (PARTITION BY EXTRACT ( MONTH FROM event_dt )) AS min_profit_in_month
                 , AVG ( SUM ( price - cost ) ) OVER (PARTITION BY EXTRACT ( MONTH FROM event_dt )) AS avg_profit_in_month
                 , RANK ( ) OVER (PARTITION BY EXTRACT ( MONTH FROM event_dt ) ORDER BY SUM ( price - cost ) DESC) AS r
              FROM contracts
             WHERE cost < price
               AND customer_country LIKE 'Belarus'
               AND EXTRACT ( YEAR FROM event_dt ) = :year
          GROUP BY EXTRACT ( MONTH FROM event_dt )
                 , brand)
   WHERE profit - avg_profit_in_month > 0
ORDER BY month
       , profit DESC;