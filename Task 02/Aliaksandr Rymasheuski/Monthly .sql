  SELECT DECODE ( GROUPING_ID ( cr.brand
                              , cust.country )
                , 1, ''
                , 3, 'Grant total'
                , cust.country )
            AS customer_country
       , DECODE ( GROUPING_ID ( cr.brand
                              , cust.country )
                , 1, 'Total for ' || cr.brand
                , cr.brand )
            AS brand
       , TO_CHAR ( SUM ( con.price - cr.cost )
                 , '$999,999,999,999' )
            AS profit
       , COUNT ( * ) AS quantity
    FROM u_sa_data.tmp_contracts con
         JOIN u_sa_data.tmp_customers cust
            ON ( con.cust_id = cust.cust_id )
         JOIN u_sa_data.tmp_cars cr
            ON ( con.car_id = cr.car_id )
   WHERE TRUNC ( con.event_dt
               , 'Month' ) = TO_DATE ( '7/1/2013'
                                     , 'MM/DD/YYYY' )
     AND cr.cost < con.price
GROUP BY ROLLUP ( cr.brand, cust.country );