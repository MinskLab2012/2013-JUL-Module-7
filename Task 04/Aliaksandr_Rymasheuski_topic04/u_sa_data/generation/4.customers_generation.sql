--DROP TABLE tmp_customers;
CREATE TABLE tmp_customers
AS
SELECT DISTINCT ROWNUM cust_id
                ,cust.passport_number
              , cust.first_name
              , cust.last_name
              , cc.country
              , cc.capital AS city
              ,    SUBSTR ( cc.country
                          , 1
                          , 3 )
                || SUBSTR ( cc.capital
                          , 3 )
                || ' Str. '
                || ROUND ( dbms_random.VALUE ( 1
                                             , 192 ) )
                   AS adress
              , DECODE ( cust.gender,  1, 'F',  2, 'M' ) AS gender
  FROM (SELECT --+NO_MERGE ORDERED
              dbms_random.string ( 'U'
                                 , 2 )
               || ROUND ( dbms_random.VALUE ( 100000
                                            , 999999 ) )
                  passport_number
             , hr1.first_name
             , hr2.last_name
             , ROUND ( dbms_random.VALUE ( 1
                                         , 192 ) )
                  AS cntr_city_num
             , ROUND ( dbms_random.VALUE ( 1
                                         , 2 ) )
                  gender
          FROM hr.employees hr1
             , hr.employees hr2
             , (    SELECT ROWNUM
                      FROM DUAL
                CONNECT BY ROWNUM <= 13)) cust
     , tmp_countries_city cc
 WHERE cc.cc_id = cust.cntr_city_num;
 commit;
 