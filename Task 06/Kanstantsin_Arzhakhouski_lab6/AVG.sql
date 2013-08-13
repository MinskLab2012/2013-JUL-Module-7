/* Formatted on 8/13/2013 3:28:03 PM (QP5 v5.139.911.3011) */
  SELECT dealer_name
       , ROUND ( AVG ( fct_amount ) )
    FROM delivery
   WHERE EXTRACT ( YEAR FROM event_dt ) = 2012
GROUP BY dealer_name
ORDER BY 2 DESC;