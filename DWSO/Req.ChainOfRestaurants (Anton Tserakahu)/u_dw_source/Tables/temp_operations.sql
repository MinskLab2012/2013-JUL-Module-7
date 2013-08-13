
DROP TABLE temp_operations;

CREATE TABLE temp_operations
(
   event_dt       DATE
 , transaction_code NUMBER ( 10 )
 , restaurant_code NUMBER ( 10 )
 , dish_code      VARCHAR2 ( 15 )
 , unit_amount    NUMBER ( 20, 5 )
);

BEGIN
   FOR c IN 1 .. 500 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO temp_operations
         ( SELECT t.event_dt
                , t.transaction_code
                , rest.restaurant_code
                , dishes.dish_code
                , t.unit_amount
             FROM (    SELECT ( TRUNC ( TO_TIMESTAMP ( '31.12.2012 23:59:59'
                                                     , 'DD.MM.YYYY HH24:MI:SS' ) )
                               - dbms_random.VALUE ( 1
                                                   , 365 ) )
                                 AS event_dt
                            , ( ( ( c - 1 ) * 500 ) + ROWNUM ) AS transaction_code
                            , ROUND ( dbms_random.VALUE ( 1
                                                        , ( SELECT COUNT ( * )
                                                              FROM temp_restaurants ) ) )
                                 AS restaurant_id
                            , ROUND ( dbms_random.VALUE ( 1
                                                        , ( SELECT COUNT ( * )
                                                              FROM t_ext_dishes ) ) )
                                 AS dish_id
                            , ROUND ( dbms_random.VALUE ( 1
                                                        , 5 ) )
                                 AS unit_amount
                         FROM DUAL
                   CONNECT BY ROWNUM <= 30000) t
                  LEFT JOIN (SELECT ROWNUM AS numb
                                  , temp_restaurants.*
                               FROM temp_restaurants) rest
                     ON rest.numb = restaurant_id
                  LEFT JOIN (SELECT ROWNUM AS numb
                                  , t_ext_dishes.*
                               FROM t_ext_dishes) dishes
                     ON dishes.numb = dish_id );

      COMMIT;
   END LOOP;
END;