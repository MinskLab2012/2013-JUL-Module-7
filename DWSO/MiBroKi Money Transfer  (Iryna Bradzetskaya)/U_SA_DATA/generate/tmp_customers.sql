/* Formatted on 7/29/2013 7:21:48 PM (QP5 v5.139.911.3011) */
CREATE TABLE tmp_customers
AS
   SELECT ROWNUM AS cust_id
        , custt.*
     FROM (SELECT DISTINCT usr.first_name cust_first_name
                         , usr.last_name cust_last_name
                         , CASE
                              WHEN ROUND ( dbms_random.VALUE ( 1
                                                             , 2 ) ) = 1 THEN
                                 'M'
                              ELSE
                                 'F'
                           END
                              cust_gender
                         , ROUND ( ( dbms_random.VALUE ( 1
                                                       , 5 ) ) )
                              AS cust_level_income
                         , usr.rand_date AS cust_birth_year
                         , cntr.cntr_desc AS cust_country_desc
                         , usr.last_name || usr.first_name || cntr.cntr_id || '@gmail.com' cust_email
                         , CASE
                              WHEN ROUND ( dbms_random.VALUE ( 1
                                                             , 3 ) ) = 1 THEN
                                 'AB'
                              WHEN ROUND ( dbms_random.VALUE ( 1
                                                             , 3 ) ) = 2 THEN
                                 'ML'
                              ELSE
                                 'SK'
                           END
                           || ROUND ( dbms_random.VALUE ( 1000000
                                                        , 9999999 ) )
                              cust_pass_number
                         , ROUND ( dbms_random.VALUE ( 10
                                                     , 50000000 )
                                 , 2 )
                              cust_balance
             FROM (SELECT --+NO_MERGE ORDERED
                         hr1.first_name
                        , hr2.last_name
                        , ROUND ( dbms_random.VALUE ( 1
                                                    , 241 ) )
                             AS cntr_num
                        , TO_DATE ( TRUNC ( dbms_random.VALUE ( 2440900
                                                              , 2448900 ) )
                                  , 'j' )
                             AS rand_date
                     FROM hr.employees hr1
                        , hr.employees hr2
                        , (    SELECT ROWNUM
                                 FROM DUAL
                           CONNECT BY ROWNUM <= 13)) usr
                , (SELECT ROWNUM AS rn
                        , i.cntr_id
                        , i.cntr_desc
                     FROM (  SELECT cntr.region_desc cntr_desc
                                  , cntr.country_id cntr_id
                               FROM u_dw_references.cu_countries cntr
                           ORDER BY country_id) i) cntr
            WHERE cntr.rn = usr.cntr_num) custt