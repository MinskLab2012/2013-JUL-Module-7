/* Formatted on 7/29/2013 7:42:00 PM (QP5 v5.139.911.3011) */
--TRUNCATE TABLE tmp_transactions;

CREATE TABLE tmp_transactions
(
   event_dt       DATE
 , transaction_id NUMBER ( 22 )
 , dealer_id      NUMBER ( 22 )
 , vehicle_id     NUMBER ( 22 )
 , fct_quantity   NUMBER ( 10 )
 , fct_amount     NUMBER ( 9, 2 )
);

BEGIN
   FOR c IN 1 .. 100 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO tmp_transactions
         SELECT tr2.event_dt
              , LPAD ( ROUND (  tr2.dealer_id
                              * tr2.vehicle_id
                              * tr2.fct_quantity
                              * dbms_random.VALUE ( 1
                                                  , 100 ) )
                     , 10
                     , '0' )
                   transaction_id
              , tr2.dealer_id
              , tr2.vehicle_id
              , tr2.fct_quantity
              , ( SELECT vehicle_price * tr2.fct_quantity
                    FROM tmp_vehicles
                   WHERE vehicle_id = tr2.vehicle_id )
                   AS fct_amount
           FROM (SELECT TRUNC ( SYSTIMESTAMP )
                        - dbms_random.VALUE ( 1
                                            , 5000 )
                           AS event_dt
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM tmp_dealers ) ) )
                           AS dealer_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM tmp_vehicles ) ) )
                           AS vehicle_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , 5 ) )
                           AS fct_quantity
                   FROM (    SELECT ROWNUM AS rn
                               FROM DUAL
                         CONNECT BY ROWNUM <= 10000) tr) tr2;

      COMMIT;
   END LOOP;
END;

BEGIN
   dbms_stats.gather_table_stats ( USER
                                 , 'tmp_transactions'
                                 , NULL
                                 , 10 );
END;

