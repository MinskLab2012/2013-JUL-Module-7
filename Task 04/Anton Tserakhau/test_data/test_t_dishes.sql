
( ( SELECT dish_code
         , dish_name
         , dish_desc
         , dish_weight
         , start_unit_price_dol
      FROM t_dishes )
 MINUS
 ( SELECT dish_code
        , dish_name
        , dish_desc
        , dish_weight
        , dish_start_price_dol
     FROM u_dw_ext_references.cls_dishes ) )
UNION ALL
( ( SELECT dish_code
         , dish_name
         , dish_desc
         , dish_weight
         , dish_start_price_dol
      FROM u_dw_ext_references.cls_dishes )
 MINUS
 ( SELECT dish_code
        , dish_name
        , dish_desc
        , dish_weight
        , start_unit_price_dol
     FROM t_dishes ) );