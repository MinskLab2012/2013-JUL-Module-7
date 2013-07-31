-DROP TABLE fact_financing CASCADE CONSTRAINTS PURGE;

CREATE TABLE fact_financing
(
   date_dt        DATE
 , country        VARCHAR2 ( 50 BYTE )
 , program_code   VARCHAR2 ( 16 BYTE )
 , fin_source_id  NUMBER
 , amount         NUMBER
 , loan_charge    NUMBER
 , end_date       DATE
);

INSERT INTO fact_financing
   SELECT DISTINCT TO_DATE ( TRUNC ( dbms_random.VALUE ( 2451010
                                                       , 2452000 ) )
                           , 'j' )
                      AS date_dt
                 , cntr.country_name AS country
                 , SUBSTR ( dep.department_name
                          , 1
                          , 4 )
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
                                                       , 2452000 )
                                    + 2000 )
                           , 'j' )
                      AS end_date
     FROM hr.departments dep
        , hr.countries cntr
        , (    SELECT ROWNUM
                 FROM DUAL
           CONNECT BY ROWNUM <= 2000);

COMMIT;