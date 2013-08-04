
( ( SELECT dish_type_name
         , dish_type_desc
      FROM t_dish_types )
 MINUS
 ( SELECT dish_type_name
        , 'Type of dish - ' || dish_type_name
     FROM u_dw_ext_references.cls_dishes ) )
UNION ALL
( ( SELECT dish_type_name
         , 'Type of dish - ' || dish_type_name
      FROM u_dw_ext_references.cls_dishes )
 MINUS
 ( SELECT dish_type_name
        , dish_type_desc
     FROM t_dish_types ) );