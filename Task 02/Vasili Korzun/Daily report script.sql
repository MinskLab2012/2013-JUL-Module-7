/* Formatted on 7/30/2013 12:42:45 PM (QP5 v5.139.911.3011) */
  SELECT DECODE ( gid, 7, 'Total: ', day_id ) AS event_date
       , DECODE ( gid, 3, 'Total for ' || prod_name, prod_name ) AS product
       , DECODE ( gid, 1, 'Total for ' || delivery_system_code, delivery_system_code ) AS delivery_system
       , payment_system_desc AS payment_system
       , amount_sold
       , cnt
    FROM (  SELECT GROUPING_ID ( prod_name
                               , delivery_system_code
                               , payment_system_desc )
                      AS gid
                 , TRUNC ( transaction_dt
                         , 'dd' )
                      AS day_id
                 , prod_name
                 , delivery_system_code
                 , payment_system_desc
                 , SUM ( cost ) AS amount_sold
                 , COUNT ( transaction_id ) AS cnt
              FROM tmp_orders
             WHERE EXTRACT ( YEAR FROM transaction_dt ) = :p_year
               AND EXTRACT ( MONTH FROM transaction_dt ) = :p_month
               AND country = :p_country
          GROUP BY ROLLUP ( ( TRUNC ( transaction_dt
                                    , 'dd' ), prod_name ), delivery_system_code, payment_system_desc ))
ORDER BY day_id
       , prod_name
       , gid;