
DROP  MATERIALIZED VIEW mv_sales_rest_dish_type_daily;

 CREATE MATERIALIZED VIEW mv_sales_rest_dish_type_daily
 BUILD IMMEDIATE
 REFRESH FAST ON COMMIT
 ENABLE QUERY REWRITE
 AS
  SELECT  rest.restaurant_name
                    AS restaurant_name
               ,  rest.restaurant_address
                    AS restaurant_address
               , SUM ( oper.unit_amount ) AS amount
               ,COUNT ( oper.unit_amount ) AS count_amount
               , SUM ( oper.total_price_dol ) AS total_price
               , COUNT ( oper.total_price_dol ) AS count_total_price
            FROM u_dw_ext_references.cls_operations oper
                 LEFT JOIN u_dw_ext_references.cls_restaurants rest
                    ON oper.restaurant_code = rest.restaurant_code
           WHERE TRUNC ( oper.event_dt
                       , 'DD' ) = TO_DATE ( '06-JAN-2012'
                                          , 'DD-MON-YYYY' )
             AND rest.restaurant_country_name = 'Germany'
             AND rest.restaurant_city = 'Chemnitz'
        GROUP BY  rest.restaurant_name, rest.restaurant_address;