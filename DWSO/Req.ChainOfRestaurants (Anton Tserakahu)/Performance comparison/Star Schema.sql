
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
               , SUM ( oper.fct_unit_amount ) AS amount
               , SUM ( oper.fct_total_sales_dol ) AS total_price
            FROM fct_operations_dd oper
                 LEFT JOIN dim_restaurants rest
                    ON oper.restaurant_id = rest.restaurant_id
                 LEFT JOIN dim_dishes_scd dish
                    ON dish.dish_id = oper.dish_sur_id
                 LEFT JOIN dim_geo_locations loc
                    ON loc.country_geo_id = oper.geo_id
           WHERE oper.event_dt = TO_DATE ( '06-JAN-2012'
                                         , 'DD-MON-YYYY' )
             AND loc.country_desc = 'Germany'
        GROUP BY CUBE ( ( rest.restaurant_name, rest.restaurant_address ), dish.dish_type_name )
        ORDER BY rest.restaurant_name
               , rest.restaurant_address
               , dish.dish_type_name);