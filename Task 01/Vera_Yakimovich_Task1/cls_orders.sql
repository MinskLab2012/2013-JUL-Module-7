/* Formatted on 02.08.2013 21:10:50 (QP5 v5.139.911.3011) */
--countries

/*( SELECT ROWNUM AS country_id
       , country_desc
    FROM u_dw_references.lc_countries );*/

DROP TABLE cls_orders PURGE;

CREATE TABLE cls_orders
(
   order_code     NUMBER ( 10 )
 , event_dt       DATE
 , company_id     NUMBER ( 30 )
 , country_id     NUMBER ( 20 )
)
TABLESPACE ts_references_ext_data_01;

INSERT INTO cls_orders
   SELECT DISTINCT 10000 + ROWNUM AS order_id
                 , TRUNC ( SYSTIMESTAMP )
                   - dbms_random.VALUE ( 1
                                       , 5000 )
                      AS event_dt
                 , ROUND ( dbms_random.VALUE ( 1
                                             , ( SELECT COUNT ( * )
                                                   FROM temp_companies ) ) )
                      AS company_code
                 , ROUND ( dbms_random.VALUE ( 1
                                             , ( SELECT COUNT ( * )
                                                   FROM u_dw_references.lc_countries ) ) )
                      AS country_id
     FROM (    SELECT ROWNUM AS rn
                 FROM DUAL
           CONNECT BY ROWNUM <= 10000) tr;

COMMIT;


INSERT INTO cls_orders
   SELECT DISTINCT ROWNUM AS order_id
                 , TRUNC ( SYSTIMESTAMP )
                   - dbms_random.VALUE ( 1
                                       , 5000 )
                      AS event_dt
                 , ROUND ( dbms_random.VALUE ( 1
                                             , ( SELECT COUNT ( * )
                                                   FROM temp_companies ) ) )
                      AS company_code
                 , ROUND ( dbms_random.VALUE ( 1
                                             , ( SELECT COUNT ( * )
                                                   FROM u_dw_references.lc_countries ) ) )
                      AS country_id
     FROM (    SELECT ROWNUM AS rn
                 FROM DUAL
           CONNECT BY ROWNUM <= 10000) tr
           ;

COMMIT;

/*SELECT *
  FROM tmp_orders;*/

SELECT COUNT ( * )
  FROM cls_orders
UNION ALL
SELECT COUNT ( distinct order_code )
 FROM cls_orders;