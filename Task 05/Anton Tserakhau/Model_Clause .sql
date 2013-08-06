
SELECT NVL ( country, 'Total' ) AS country
     , NVL ( city, '-' ) AS city
     , NVL ( TO_CHAR ( month_numb ), '-' ) AS number_of_month
     , NVL ( month_name, '-' ) AS month_name
     , TO_CHAR ( amount
               , '9,999,999' )
          AS amount
     , NVL ( TO_CHAR ( delta_amount
                     , '9,999,999' )
           , '-' )
          AS delta_amount
     , TO_CHAR ( total_sales
               , '$999,999,999,999' )
          AS total_sales
     , NVL ( TO_CHAR ( delta_sales
                     , '$999,999,999,999' )
           , '-' )
          AS delta_sales
  FROM (  SELECT country_name AS country
               , city_name AS city
               , month_numb
               , month_name
               , SUM ( amount ) AS amount
               , delta_amount
               , SUM ( total_price ) AS total_sales
               , delta_sales
            FROM (SELECT *
                    FROM (  SELECT TO_NUMBER ( TO_CHAR ( TRUNC ( oper.event_dt
                                                               , 'MONTH' )
                                                       , 'mm' ) )
                                      AS month_numb
                                 , TO_CHAR ( TRUNC ( oper.event_dt
                                                   , 'MONTH' )
                                           , 'Month' )
                                      AS month_name
                                 , countries.region_desc AS country_name
                                 , cities.city_desc AS city_name
                                 , SUM ( oper.unit_amount ) AS amount
                                 , SUM ( oper.total_price_dol ) AS total_price
                              FROM t_operations oper
                                   LEFT JOIN t_restaurants rest
                                      ON oper.restaurant_id = rest.restaurant_id
                                   LEFT JOIN t_restaurant_types
                                      ON rest.restaurant_type_id = t_restaurant_types.restaurant_type_id
                                   LEFT JOIN t_dishes dishes
                                      ON dishes.dish_id = oper.dish_id
                                   LEFT JOIN t_dish_types
                                      ON dishes.dish_type_id = t_dish_types.dish_type_id
                                   LEFT JOIN t_dish_cuisines
                                      ON dishes.dish_cuisine_id = t_dish_cuisines.dish_cuisine_id
                                   LEFT JOIN u_dw_references.lc_cities cities
                                      ON rest.restaurant_geo_id = cities.geo_id
                                   LEFT JOIN u_dw_references.t_geo_object_links links
                                      ON links.child_geo_id = cities.geo_id
                                   LEFT JOIN u_dw_references.cu_countries countries
                                      ON links.parent_geo_id = countries.geo_id
                             WHERE countries.region_desc IN ('United States of America')
                               AND cities.city_desc IN ('Hardy', 'Woodstock')
                          GROUP BY TO_NUMBER ( TO_CHAR ( TRUNC ( oper.event_dt
                                                               , 'MONTH' )
                                                       , 'mm' ) )
                                 , TO_CHAR ( TRUNC ( oper.event_dt
                                                   , 'MONTH' )
                                           , 'Month' )
                                 , countries.region_desc
                                 , cities.city_desc
                          ORDER BY TO_NUMBER ( TO_CHAR ( TRUNC ( oper.event_dt
                                                               , 'MONTH' )
                                                       , 'mm' ) )
                                 , city_name)
                  MODEL RETURN UPDATED ROWS
                     PARTITION BY ( country_name, city_name )
                     DIMENSION BY ( month_numb )
                     MEASURES ( month_name, amount, 0 delta_amount, total_price, 0 delta_sales )
                     RULES AUTOMATIC ORDER
                        ( delta_amount [month_numb] =
                              amount[CV ( month_numb )]
                              - NVL ( amount[CV ( month_numb ) - 1], amount[CV ( month_numb )] ),
                        delta_sales [month_numb] =
                              total_price[CV ( month_numb )]
                              - NVL ( total_price[CV ( month_numb ) - 1], total_price[CV ( month_numb )] ) ))
        GROUP BY 
                ROLLUP (country_name, city_name, ( month_numb, month_name, delta_amount, delta_sales ) )
        ORDER BY country_name
               , city_name
               , month_numb)