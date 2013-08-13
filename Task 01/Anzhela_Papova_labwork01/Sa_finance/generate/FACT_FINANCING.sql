/* Formatted on 10.08.2013 12:16:12 (QP5 v5.139.911.3011) */
--DROP TABLE fact_financing CASCADE CONSTRAINTS PURGE;

CREATE TABLE fact_financing
(
   date_dt        DATE
 , country        VARCHAR2 ( 100 BYTE )
 , program_code   VARCHAR2 ( 16 BYTE )
 , fin_source_id  NUMBER
 , amount         NUMBER
 , loan_charge    NUMBER
 , end_date       DATE
);

INSERT INTO fact_financing
   SELECT DISTINCT TO_DATE ( TRUNC ( dbms_random.VALUE ( 2451010
                                                       , 2456000 ) )
                           , 'j' )
                      AS date_dt
                 , cntr.country_name AS country
                 , SUBSTR ( dep.department_name
                          , 1
                          , 6 )
                      AS program_code
                 , ROUND ( dbms_random.VALUE ( 1
                                             , 4 ) )
                      AS fin_source_id
                 , ROUND ( dbms_random.VALUE ( 500000
                                             , 10000000 )
                         , -3 )
                      AS amount
                 , ROUND ( dbms_random.VALUE ( 0
                                             , 10 )
                         , 2 )
                      AS loan_charge
                 , TO_DATE ( TRUNC ( dbms_random.VALUE ( 2451050
                                                       , 2456000 )
                                    + 2000 )
                           , 'j' )
                      AS end_date
     FROM hr.departments dep
        , hr.countries cntr
        , (    SELECT ROWNUM
                 FROM DUAL
           CONNECT BY ROWNUM <= 3000);

COMMIT;