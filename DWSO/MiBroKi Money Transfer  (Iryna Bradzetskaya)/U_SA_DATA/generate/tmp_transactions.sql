CREATE TABLE tmp_transactions
(
   event_dt       DATE
 , transaction_id NUMBER
 , cust_send_id   NUMBER
 , cust_rec_id    NUMBER
 , cntr_send_desc   VARCHAR2 ( 30 )
 , cntr_rec_desc    VARCHAR2 ( 30 )
 , currency_code  NUMBER
 , tariff_code    VARCHAR2 ( 5 )
 , operation_id   NUMBER
 , operation_method_id NUMBER
)



BEGIN
   FOR c IN 1 .. 100 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO tmp_transactions
SELECT event_dt
              , transaction_id
              , CASE WHEN tariff_code = 'DPS' THEN NULL ELSE cust_send_id END cust_send_id
              , CASE WHEN tariff_code = 'WDW' THEN NULL ELSE cust_rec_id END cust_rec_id
              , CASE WHEN tariff_code = 'DPS' THEN NULL ELSE cntr_send.cntr_id END cntr_send_id
              , 
              CASE WHEN tariff_code in ('LMT', 'LTT', 'LTS') THEN  cntr_send.cntr_id
              ELSE
              (CASE WHEN tariff_code = 'WDW' THEN NULL ELSE cntr_rec.cntr_id END)
              END cntr_rec_id
              , currency_code
              , tariff_code
              , CASE
                   WHEN tariff_code IN ('IMT', 'ITT', 'ITS', 'LMT', 'LTT', 'LTS') THEN 3
                   WHEN tariff_code IN ('WDW') THEN 2
                   WHEN tariff_code IN ('DPS') THEN 1
                END
                   operation_id
              , operation_method_id
              , CASE
                   WHEN tariff_code = 'IMT' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'IMT' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'IMT' ) ) )
                   WHEN tariff_code = 'ITT' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'ITT' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'ITT' ) ) )
                   WHEN tariff_code = 'ITS' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'ITS' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'ITS' ) ) )
                   WHEN tariff_code = 'LMT' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'LMT' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'LMT' ) ) )
                   WHEN tariff_code = 'LTT' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'LTT' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'LTT' ) ) )
                   WHEN tariff_code = 'LTS' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'LTS' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'LTS' ) ) )
                   WHEN tariff_code = 'WDW' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'WDW' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'WDW' ) ) )
                   WHEN tariff_code = 'DPS' THEN
                      ROUND ( dbms_random.VALUE ( ( SELECT tariff_min_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'DPS' )
                                                , ( SELECT tariff_max_payment
                                                      FROM u_dw_ext_references.tmp_tariffs
                                                     WHERE tariff_code = 'DPS' ) ) )
                   ELSE
                      0
                END
                   payment_sum
           FROM (SELECT TRUNC ( SYSTIMESTAMP )
                        - dbms_random.VALUE ( 1
                                            , 5000 )
                           AS event_dt
                      , tr.rn AS transaction_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM u_dw_ext_references.tmp_customers ) ) )
                           AS cust_send_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM u_dw_ext_references.tmp_customers ) ) )
                           AS cust_rec_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM u_dw_references.cu_countries ) ) )
                           AS cntr_send_rn
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM u_dw_references.cu_countries ) ) )
                           AS cntr_rec_rn
                      , CASE
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 1 THEN
                              840
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 2 THEN
                              978
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 3 THEN
                              392
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 4 THEN
                              826
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 5 THEN
                              756
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 6 THEN
                              124
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 7 THEN
                              36
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 8 THEN
                              554
                           ELSE
                              840
                        END
                           currency_code
                      , CASE
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 1 THEN
                              'IMT'
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 2 THEN
                              'ITT'
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 3 THEN
                              'ITS'
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 4 THEN
                              'LMT'
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 5 THEN
                              'LTT'
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 6 THEN
                              'LTS'
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 7 THEN
                              'DPS'
                           WHEN ROUND ( dbms_random.VALUE ( 1
                                                          , 8 ) ) = 8 THEN
                              'WDW'
                           ELSE
                              'DPS'
                        END
                           tariff_code
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , 7 ) )
                           operation_method_id
                   FROM (    SELECT ROWNUM AS rn
                               FROM DUAL
                         CONNECT BY ROWNUM <= 10000) tr) t1
                LEFT OUTER JOIN (SELECT ROWNUM rnn
                                      , cntr.country_id cntr_id
                                   FROM u_dw_references.cu_countries cntr) cntr_send
                   ON ( t1.cntr_send_rn = cntr_send.rnn )
                LEFT OUTER JOIN (SELECT ROWNUM rnn
                                      , cntr.country_id cntr_id
                                   FROM u_dw_references.cu_countries cntr) cntr_rec
                   ON ( t1.cntr_rec_rn = cntr_rec.rnn );

      COMMIT;
   END LOOP;
END;