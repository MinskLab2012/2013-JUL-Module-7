
SELECT *
  FROM (SELECT country_name AS country
             , city_name AS city
             , DENSE_RANK ( ) OVER (PARTITION BY country_name ORDER BY total_price DESC) AS rating_sales_in_country
             , RANK ( ) OVER (ORDER BY total_price DESC) AS rating_sales_in_world
             , TO_CHAR ( amount
                       , '9,999,999' )
                  AS amount
             , TO_CHAR ( total_price
                       , '$999,999,999,999' )
                  AS total_price
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
                       , cities.city_desc))
 WHERE rating_sales_in_country <= 3;