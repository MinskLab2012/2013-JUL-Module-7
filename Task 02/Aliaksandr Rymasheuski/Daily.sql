  SELECT DECODE ( GROUPING_ID ( customer_country
                              , brand )
                , 2, ''
                , 3, 'Grant total'
                , customer_country )
            AS customer_country
       , DECODE ( GROUPING_ID ( customer_country
                              , brand )
                , 2, 'Total for ' || brand
                , 3, ''
                , brand )
            AS brand
       , to_char(SUM ( price - cost ), '$999,999,999,999') AS profit
       , count(*) quantity
    FROM contracts
   WHERE TRUNC ( event_dt
               , 'day' ) = TO_DATE ( '7/28/2013'
                                   , 'MM/DD/YYYY' )
     AND cost < price
GROUP BY CUBE ( customer_country, brand )
  HAVING SUM ( price - cost ) > 20000
     AND GROUPING_ID ( customer_country
                     , brand ) IN (0, 2, 3);