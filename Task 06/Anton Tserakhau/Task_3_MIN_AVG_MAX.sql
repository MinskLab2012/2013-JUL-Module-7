
SELECT country_name AS country
     , city_name AS city
     , TO_CHAR ( amount
               , '9,999,999' )
          AS amount
     , TO_CHAR ( min_sales
               , '$999,999,999,999' )
          AS min_sales
     , TO_CHAR ( avg_sales
               , '$999,999,999,999' )
          AS avg_sales
     , TO_CHAR ( max_sales
               , '$999,999,999,999' )
          AS max_sales
     , TO_CHAR ( total_price
               , '$999,999,999,999' )
          AS total_price
  FROM (  SELECT DECODE ( GROUPING ( countries.region_desc ), 1, 'All Countries', countries.region_desc ) AS country_name
               , DECODE ( GROUPING ( cities.city_desc ), 1, 'All Cities', cities.city_desc ) AS city_name
               , SUM ( oper.unit_amount ) AS amount
               , MIN ( SUM ( oper.total_price_dol ) ) OVER (PARTITION BY countries.region_desc) AS min_sales
               , AVG ( SUM ( oper.total_price_dol ) ) OVER (PARTITION BY countries.region_desc) AS avg_sales
               , MAX ( SUM ( oper.total_price_dol ) ) OVER (PARTITION BY countries.region_desc) AS max_sales
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
        GROUP BY ROLLUP ( countries.region_desc, cities.city_desc )
        ORDER BY countries.region_desc
               , cities.city_desc);