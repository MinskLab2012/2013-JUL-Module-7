
( ( SELECT restaurant_code
         , restaurant_name
         , restaurant_desc
         , restaurant_email
         , restaurant_phone_number
         , restaurant_address
         , restaurant_numb_of_seats
         , restaurant_numb_of_dining_room
      FROM t_restaurants )
 MINUS
 ( SELECT restaurant_code
        , restaurant_name
        , restaurant_desc
        , restaurant_email
        , restaurant_phone_number
        , restaurant_address
        , restaurant_numb_of_seats
        , restaurant_numb_of_dining_ro
     FROM u_dw_ext_references.cls_restaurants  ) )
UNION ALL
( ( SELECT restaurant_code
         , restaurant_name
         , restaurant_desc
         , restaurant_email
         , restaurant_phone_number
         , restaurant_address
         , restaurant_numb_of_seats
         , restaurant_numb_of_dining_ro
      FROM u_dw_ext_references.cls_restaurants  )
 MINUS
 ( SELECT restaurant_code
        , restaurant_name
        , restaurant_desc
        , restaurant_email
        , restaurant_phone_number
        , restaurant_address
        , restaurant_numb_of_seats
        , restaurant_numb_of_dining_room
     FROM t_restaurants ) );