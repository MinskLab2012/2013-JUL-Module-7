
( ( SELECT transaction_id
         , event_dt
         , restaurant_id
         , dish_id
         , unit_price_dol
         , unit_amount
         , total_price_dol
      FROM t_operations )
 MINUS
 ( SELECT transaction_code
        , event_dt
        , t_restaurants.restaurant_id
        , t_dishes.dish_id
        , unit_price_dol
        , unit_amount
        , total_price_dol
     FROM u_dw_ext_references.cls_operations t
          LEFT JOIN t_restaurants
             ON t_restaurants.restaurant_code = t.restaurant_code
          LEFT JOIN t_dishes
             ON t_dishes.dish_code = t.dish_code ) )
UNION ALL
( ( SELECT transaction_code
         , event_dt
         , t_restaurants.restaurant_id
         , t_dishes.dish_id
         , unit_price_dol
         , unit_amount
         , total_price_dol
      FROM u_dw_ext_references.cls_operations t
           LEFT JOIN t_restaurants
              ON t_restaurants.restaurant_code = t.restaurant_code
           LEFT JOIN t_dishes
              ON t_dishes.dish_code = t.dish_code )
 MINUS
 ( SELECT transaction_id
        , event_dt
        , restaurant_id
        , dish_id
        , unit_price_dol
        , unit_amount
        , total_price_dol
     FROM t_operations ) );