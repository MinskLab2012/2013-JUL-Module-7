/* Formatted on 7/30/2013 8:52:18 PM (QP5 v5.139.911.3011) */
  SELECT client_country
       , prod_category
       , sold
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
ORDER BY 1;