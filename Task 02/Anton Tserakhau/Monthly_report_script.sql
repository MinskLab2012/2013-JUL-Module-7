/* Formatted on 30.07.2013 17:22:45 (QP5 v5.139.911.3011) */
SELECT restaurant_country_name AS country
     , restaurant_city AS city
     , TO_CHAR ( amount
               , '9,999,999' )
          AS amount
     , TO_CHAR ( total_price
               , '$999,999,999,999' )
          AS total_price
  FROM (  SELECT DECODE ( GROUPING ( rest.restaurant_country_name ), 1, 'All Countries', rest.restaurant_country_name )
                    AS restaurant_country_name
               , DECODE ( GROUPING ( rest.restaurant_city ), 1, 'All Cities', rest.restaurant_city ) AS restaurant_city
               , SUM ( oper.unit_amount ) AS amount
               , SUM ( oper.total_price_dol ) AS total_price
            FROM cls_operations oper
                 LEFT JOIN (SELECT ROWNUM restaurant_id
                                 , t.*
                              FROM cls_restaurants t) rest
                    ON oper.restaurant_id = rest.restaurant_id
                 LEFT JOIN (SELECT ROWNUM dish_id
                                 , d.*
                              FROM cls_dishes d) dish
                    ON dish.dish_id = oper.dish_id
           WHERE TRUNC ( oper.event_dt
                       , 'MONTH' ) = TO_DATE ( '01-JAN-2012'
                                             , 'DD-MON-YYYY' )
        GROUP BY ROLLUP ( rest.restaurant_country_name, rest.restaurant_city )
        ORDER BY rest.restaurant_country_name
               , rest.restaurant_city);