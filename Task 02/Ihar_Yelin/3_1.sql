/* Formatted on 7/30/2013 8:31:30 PM (QP5 v5.139.911.3011) */
  SELECT DECODE ( GROUPING_ID ( client_country
                              , prod_category )
                , 0, NVL ( client_country, 'Others' )
                , 1, NVL ( client_country, 'Others' )
                , 2, 'All Countries'
                , 3, 'Total' )
            country
       , DECODE ( GROUPING ( prod_category ), 1, 'All Categories', prod_category ) prod_category
       , SUM ( sold ) sold
    FROM (  SELECT TRUNC ( TO_DATE ( event_date )
                         , 'DAY' )
                      da
                 , client_country
                 , prod_category
                 , SUM ( amount_sold ) sold
              FROM operations
             WHERE TRUNC ( TO_DATE ( event_date )
                         , 'DAY' ) = '01/04/2007'
          GROUP BY client_country
                 , prod_category
                 , TRUNC ( TO_DATE ( event_date )
                         , 'DAY' ))
GROUP BY CUBE ( client_country, prod_category )
ORDER BY 1;