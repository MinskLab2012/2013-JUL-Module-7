
( ( SELECT dish_cuisine_name
         , dish_cuisine_desc
      FROM t_dish_cuisines )
 MINUS
 ( SELECT dish_cuisine_name
        , 'Cuisine of dish - ' || dish_cuisine_name
     FROM u_dw_ext_references.cls_dishes ) )
UNION ALL
( ( SELECT dish_cuisine_name
         , 'Cuisine of dish - ' || dish_cuisine_name
      FROM u_dw_ext_references.cls_dishes )
 MINUS
 ( SELECT dish_cuisine_name
        , dish_cuisine_desc
     FROM t_dish_cuisines ) );