/* Formatted on 30.07.2013 17:19:08 (QP5 v5.139.911.3011) */
SELECT restaurant_name
     , restaurant_address
     , dish_type_name
     , TO_CHAR ( amount
               , '9,999,999' )
          AS amount
     , TO_CHAR ( total_price
               , '$999,999,999.00' )
          AS total_price
  FROM (  SELECT DECODE ( GROUPING ( rest.restaurant_name ), 1, 'All Restaurants', rest.restaurant_name )
                    AS restaurant_name
               , DECODE ( GROUPING ( rest.restaurant_address ), 1, 'All Restaurants', rest.restaurant_address )
                    AS restaurant_address
               , DECODE ( GROUPING ( dish.dish_type_name ), 1, 'All Types', dish.dish_type_name ) AS dish_type_name
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
                       , 'DD' ) = TO_DATE ( '06-JAN-2012'
                                          , 'DD-MON-YYYY' )
             AND rest.restaurant_country_name = 'Germany'
             AND rest.restaurant_city = 'Chemnitz'
        GROUP BY CUBE ( ( rest.restaurant_name, rest.restaurant_address ), dish.dish_type_name )
        ORDER BY rest.restaurant_name
               , rest.restaurant_address
               , dish.dish_type_name);