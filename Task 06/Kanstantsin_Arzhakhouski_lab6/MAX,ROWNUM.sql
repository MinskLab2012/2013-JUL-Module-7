/* Formatted on 8/13/2013 3:10:21 PM (QP5 v5.139.911.3011) */
SELECT *
  FROM (  SELECT vehicle_type_desc
               , vehicle_desc
               , MAX ( fct_amount )
            FROM delivery
           WHERE EXTRACT ( YEAR FROM event_dt ) = 2013
        GROUP BY vehicle_type_desc
               , vehicle_desc
        ORDER BY MAX ( fct_amount ) DESC) delivery
 WHERE ROWNUM <= 5;