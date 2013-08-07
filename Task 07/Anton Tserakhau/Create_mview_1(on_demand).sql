DROP MATERIALIZED VIEW mv_sales_city_country_month;

 CREATE MATERIALIZED VIEW mv_sales_city_country_month
 BUILD DEFERRED
 REFRESH COMPLETE ON DEMAND
 AS SELECT restaurant_country_name AS country
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
            FROM u_dw_ext_references.cls_operations oper
                 LEFT JOIN  u_dw_ext_references.cls_restaurants  rest
                    ON oper.restaurant_code = rest.restaurant_code
                 LEFT JOIN  u_dw_ext_references.cls_dishes  dish
                    ON dish.dish_code = oper.dish_code
           WHERE TRUNC ( oper.event_dt
                       , 'MONTH' ) = TO_DATE ( '01-JAN-2012'
                                             , 'DD-MON-YYYY' )
        GROUP BY ROLLUP ( rest.restaurant_country_name, rest.restaurant_city )
        ORDER BY rest.restaurant_country_name
               , rest.restaurant_city);


EXECUTE DBMS_MVIEW.REFRESH('mv_sales_city_country_month');