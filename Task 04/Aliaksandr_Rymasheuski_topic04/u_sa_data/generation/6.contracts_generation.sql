--DROP TABLE tmp_contracts;
CREATE TABLE tmp_contracts
(
   event_dt       DATE
 , contract_number varchar2 ( 50 )
 , car_id         NUMBER ( 20 )
 , cust_id        NUMBER ( 20 )
 , emp_id         NUMBER ( 20 )
 , price          NUMBER ( 20 )
);


TRUNCATE TABLE tmp_contracts;

BEGIN
   FOR c IN 1 .. 100 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO tmp_contracts
         SELECT TRUNC ( SYSTIMESTAMP )
                - dbms_random.VALUE ( 1
                                    , 5000 )
                   AS event_dt
              ,tr.rn
                   AS contract_number
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM tmp_cars ) ) )
                   AS car_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM tmp_customers ) ) )
                   AS cust_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM tmp_employees ) ) )
                   AS emp_id
              , ROUND ( dbms_random.VALUE ( 1000
                                          , 99999 )
                      , -2 )
                   AS price
           FROM (    SELECT ROWNUM AS rn
                       FROM DUAL
                 CONNECT BY ROWNUM <= 10000) tr;

      COMMIT;
   END LOOP;
END;
commit;

