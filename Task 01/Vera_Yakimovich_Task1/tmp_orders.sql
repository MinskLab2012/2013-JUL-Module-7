--countries

( SELECT ROWNUM AS country_id
       , country_desc
    FROM u_dw_references.lc_countries );
	
DROP TABLE tmp_orders PURGE;

CREATE TABLE tmp_orders
(
   order_id       NUMBER ( 30 )
 , event_dt       DATE
 , company_code   NUMBER ( 30 )
 , country_id     NUMBER ( 20 )
)
TABLESPACE ts_references_ext_data_01;

INSERT INTO tmp_orders
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

SELECT *
  FROM tmp_orders;
	