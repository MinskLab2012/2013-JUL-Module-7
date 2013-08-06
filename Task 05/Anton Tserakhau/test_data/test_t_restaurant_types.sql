
( ( SELECT restaurant_type_name
         , restaurant_type_desc
      FROM t_restaurant_types )
 MINUS
 ( SELECT restaurant_type_name
        , 'Restaurant type - ' || restaurant_type_name
     FROM u_dw_ext_references.cls_restaurants ) )
UNION ALL
( ( SELECT restaurant_type_name
         , 'Restaurant type - ' || restaurant_type_name
      FROM u_dw_ext_references.cls_restaurants )
 MINUS
 ( SELECT restaurant_type_name
        , restaurant_type_desc
     FROM t_restaurant_types ) );