/* Formatted on 8/13/2013 3:40:23 PM (QP5 v5.139.911.3011) */
  SELECT EXTRACT ( YEAR FROM event_dt ) AS month
       , vehicle_type_desc
       , SUM ( fct_amount ) AS sales
       , FIRST_VALUE ( SUM ( fct_amount ) )
            OVER (PARTITION BY EXTRACT ( YEAR FROM event_dt ) ORDER BY SUM ( fct_amount ) DESC)
            AS max_sales
       , LAST_VALUE (
                      SUM ( fct_amount )
         )
         OVER ( PARTITION BY EXTRACT ( YEAR FROM event_dt )
                ORDER BY SUM ( fct_amount ) DESC
                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
            AS min_sales
    FROM delivery
   WHERE dealer_country = 'Spain'
GROUP BY EXTRACT ( YEAR FROM event_dt )
       , vehicle_type_desc;