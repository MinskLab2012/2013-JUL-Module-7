  
SELECT restaurant_name
     , restaurant_address
     , dish_type_name
     , TO_CHAR ( amount
               , '9,999,999' )
          AS amount
     , TO_CHAR ( total_price
               , '$999,999,999.00' )
          AS total_price
  FROM (
  Select rest.restaurant_name 
                    AS restaurant_name
               , rest.restaurant_address 
                    AS restaurant_address
               ,  T_DISH_TYPES.dish_type_name  AS dish_type_name
               , SUM ( oper.UNIT_AMOUNT ) AS amount
               , SUM ( oper.TOTAL_PRICE_DOL ) AS total_price
            FROM t_operations oper
                 LEFT JOIN t_restaurants rest
                    ON oper.restaurant_id = rest.restaurant_id
                 LEFT JOIN t_dishes dish
                    ON dish.dish_id = oper.dish_id
                    left join T_DISH_TYPES on T_DISH_TYPES.DISH_TYPE_ID=DISH.DISH_TYPE_ID
                 LEFT JOIN T_CITIES city
                    ON CITY.GEO_ID=REST.RESTAURANT_GEO_ID
                    left join T_GEO_OBJECT_LINKS links
                    on LINKS.CHILD_GEO_ID=CITY.GEO_ID
                    left join LC_COUNTRIES cntr
                    on CNTR.GEO_ID=LINKS.PARENT_GEO_ID
           WHERE TRUNC(oper.event_dt, 'DD') = TO_DATE ( '06-JAN-2012'
                                         , 'DD-MON-YYYY' )
             AND cntr.country_desc = 'Germany'
        GROUP BY  CUBE ( rest.restaurant_name, rest.restaurant_address ), T_DISH_TYPES.dish_type_name 
        ORDER BY rest.restaurant_name
               , rest.restaurant_address
               , T_DISH_TYPES.dish_type_name);