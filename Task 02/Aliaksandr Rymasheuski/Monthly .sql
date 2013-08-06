  SELECT DECODE ( GROUPING_ID ( brand
                              , customer_country )
                , 1, ''
                , 3, 'Grant total'
                , customer_country )
            AS customer_country
       , DECODE ( GROUPING_ID ( brand
                              , customer_country )
                , 1, 'Total for ' || brand
                , brand )
            AS brand
       , to_char(SUM ( price - cost ), '$999,999,999,999') AS profit
       , COUNT ( * ) AS quantity
    FROM contracts
   WHERE TRUNC ( event_dt
               , 'Month' ) = TO_DATE ( '7/1/2013'
                                     , 'MM/DD/YYYY' )
     AND cost < price
GROUP BY ROLLUP ( brand, customer_country )
  ;