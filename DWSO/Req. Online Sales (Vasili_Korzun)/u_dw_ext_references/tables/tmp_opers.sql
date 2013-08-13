/* Formatted on 7/30/2013 9:47:05 AM (QP5 v5.139.911.3011) */
--TRUNCATE TABLE tmp_opers;

CREATE TABLE tmp_opers
AS
   -- INSERT INTO tmp_opers;

   SELECT TRUNC ( SYSTIMESTAMP )
          - dbms_random.VALUE ( 1
                              , 1000 )
             AS event_dt
        , tr.rn AS transaction_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , ( SELECT COUNT ( * )
                                          FROM cls_customers ) ) )
             AS user_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , ( SELECT COUNT ( * )
                                          FROM cls_geo_countries_iso3166 ) ) )
             AS country_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , ( SELECT COUNT ( * )
                                          FROM cls_products ) ) )
             AS product_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , ( SELECT COUNT ( * )
                                          FROM cls_payment_systems ) ) )
             AS payment_system_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , ( SELECT COUNT ( * )
                                          FROM cls_delivery_systems ) ) )
             AS delivery_system_id
        , ROUND ( dbms_random.VALUE ( 500
                                    , 2000 ) )
             AS cost
        , ROUND ( dbms_random.VALUE ( 1
                                    , 3 ) )
             AS status_code
     FROM (    SELECT ROWNUM AS rn
                 FROM DUAL
           CONNECT BY ROWNUM <= 10000) tr;

BEGIN
   FOR c IN 1 .. 100 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO tmp_opers
         SELECT TRUNC ( SYSTIMESTAMP )
                - dbms_random.VALUE ( 1
                                    , 1000 )
                   AS event_dt
              , tr.rn AS transaction_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM cls_customers ) ) )
                   AS user_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM cls_geo_countries_iso3166 ) ) )
                   AS country_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM cls_products ) ) )
                   AS product_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM cls_payment_systems ) ) )
                   AS payment_system_id
              , ROUND ( dbms_random.VALUE ( 1
                                          , ( SELECT COUNT ( * )
                                                FROM cls_delivery_systems ) ) )
                   AS delivery_system_id
              , ROUND ( dbms_random.VALUE ( 500
                                          , 2000 ) )
                   AS cost
              , ROUND ( dbms_random.VALUE ( 1
                                          , 3 ) )
                   AS status_code
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

alter table tmp_opers rename to t_ext_opers;


CREATE TABLE tmp_opers
AS
   SELECT event_dt
        , ROWNUM AS transaction_id
        , user_id
        , country_id
        , product_id
        , payment_system_id
        , delivery_system_id
        , cost
        , status_code
     FROM t_ext_opers;
     alter table tmrp_opers
     drop table t_ext_opers purge;