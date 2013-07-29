--TRUNCATE TABLE tmp_opers;

BEGIN
   FOR c IN 1 .. 100 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO tmp_opers
         SELECT 
               TRUNC ( SYSTIMESTAMP )
                - dbms_random.VALUE ( 1
                                    , 5000 )
                   AS event_dt
              , tr.rn AS transaction_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * ) FROM tmp_stores ) ) )
                   AS cntr_str
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * ) FROM tmp_products ) ) )
                   AS cntr_prd
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * ) FROM tmp_emp ) ) )
                   AS emp_num
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * ) FROM tmp_cust ) ) )
                   AS cust_num
              , ROUND ( dbms_random.VALUE ( 1
                                          , 4 ) )
                   AS pay_metod
              , ROUND ( dbms_random.VALUE ( 1
                                          , 10 ) )
                   AS quantity
              , ROUND ( dbms_random.VALUE ( 1
                                          , 50000000 ) )
                   AS check_num
              , ROUND ( dbms_random.VALUE ( 1
                                          , 5000 )
                      , 2 )
                   AS price
              , TRUNC ( dbms_random.VALUE ( 1
                                          , 20 ) )
                / 100
                   AS disc
           FROM (    SELECT ROWNUM AS rn
                       FROM DUAL
                 CONNECT BY ROWNUM <= 10000) tr;

      COMMIT;
   END LOOP;
END;

BEGIN
   dbms_stats.gather_table_stats ( USER
                                 , 'tmp_opers'
                                 , NULL
                                 , 10 );
END;

