
SELECT country_name AS country
     , city_name AS city
     , TO_CHAR ( amount
               , '9,999,999' )
          AS amount
     , CASE
          WHEN total_price = max_val THEN 'City with max value'
          WHEN total_price = min_val THEN 'City with min value'
       END
          city_category
     , TO_CHAR ( total_price
               , '$999,999,999,999' )
          AS total_price
  FROM (SELECT t.*
             , FIRST_VALUE ( total_price ) OVER (PARTITION BY country_name) AS max_val
             , LAST_VALUE ( total_price ) OVER (PARTITION BY country_name) AS min_val
          FROM (  SELECT countries.region_desc AS country_name
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
                   WHERE TRUNC ( oper.event_dt
                               , 'MONTH' ) = TO_DATE ( '01-JAN-2012'
                                                     , 'DD-MON-YYYY' )
                GROUP BY countries.region_desc
                       , cities.city_desc
                ORDER BY countries.region_desc
                       , total_price DESC) t)
 WHERE total_price = max_val
    OR  total_price = min_val;