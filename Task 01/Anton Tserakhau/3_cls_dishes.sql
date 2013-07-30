/* Formatted on 30.07.2013 16:06:20 (QP5 v5.139.911.3011) */
DROP TABLE cls_dishes;

CREATE TABLE cls_dishes
(
   dish_code      VARCHAR2 ( 20 )
 , dish_name      VARCHAR2 ( 400 )
 , dish_desc      VARCHAR2 ( 2000 )
 , dish_weight    NUMBER ( 10, 5 )
 , dish_type_name VARCHAR2 ( 50 )
 , dish_cuisine_name VARCHAR2 ( 50 )
 , dish_start_price_dol NUMBER ( 20, 5 )
);

INSERT INTO cls_dishes
   ( SELECT dish_code
          , dish_name
          , dish_desc
          , ROUND ( dbms_random.VALUE ( 50
                                      , 550 )
                  , -1 )
               dish_weight
          , dish_type
          , dish_region AS dish_cuisine
          , ROUND ( dbms_random.VALUE ( 2
                                      , 70 )
                  , 2 )
       FROM temp_dishes
      WHERE dish_code IS NOT NULL );

COMMIT;

DROP TABLE u_dw_ext_references.temp_dishes PURGE;