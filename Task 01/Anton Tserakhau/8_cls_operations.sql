
DROP TABLE cls_operations;

CREATE TABLE cls_operations
(
   event_dt       DATE
 , transaction_id NUMBER ( 10 )
 , restaurant_id  NUMBER ( 10 )
 , dish_id        NUMBER ( 15 )
 , unit_price_dol NUMBER ( 20, 5 )
 , unit_amount    NUMBER ( 20, 5 )
 , total_price_dol NUMBER ( 20, 5 )
)
tablespace ts_references_ext_data_02;


BEGIN
   FOR c IN 1 .. 500 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO cls_operations
         ( SELECT t.*
                , ROUND ( unit_price_dol * unit_amount
                        , 2 )
                     AS total_price_dol
             FROM (    SELECT ( TRUNC ( TO_TIMESTAMP ( '31.12.2012 23:59:59'
                                                     , 'DD.MM.YYYY HH24:MI:SS' ) )
                               - dbms_random.VALUE ( 1
                                                   , 365 ) )
                                 AS event_dt
                            , ROWNUM AS transaction_id
                            , ROUND ( dbms_random.VALUE ( 1
                                                        , ( SELECT COUNT ( * )
                                                              FROM cls_restaurants ) ) )
                                 AS restaurant_id
                            , ROUND ( dbms_random.VALUE ( 1
                                                        , ( SELECT COUNT ( * )
                                                              FROM cls_dishes ) ) )
                                 AS dish_id
                            , ROUND ( dbms_random.VALUE ( 1
                                                        , 50 )
                                    , 2 )
                                 AS unit_price_dol
                            , ROUND ( dbms_random.VALUE ( 1
                                                        , 5 ) )
                                 AS unit_amount
                         FROM DUAL
                   CONNECT BY ROWNUM <= 30000) t );

      COMMIT;
   END LOOP;
END;