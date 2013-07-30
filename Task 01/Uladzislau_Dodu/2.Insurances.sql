/* Formatted on 7/29/2013 12:59:55 PM (QP5 v5.139.911.3011) */
create table ext_insurances as
SELECT ROWNUM * 1000 AS unique_identifier
     , CASE risk_type
          WHEN 1 THEN 'All'
          WHEN 2 THEN 'Ship Only'
          WHEN 3 THEN 'Product Only'
       END
          AS risk_type
     , ins_cost
     , CASE comp_name
          WHEN 1 THEN 'Bros Ins'
          WHEN 2 THEN 'Global Ins'
          WHEN 3 THEN 'Pirate Ins'
          WHEN 4 THEN 'GMT Ins'
          WHEN 5 THEN 'PQA Ins'
          ELSE 'N/A'
       END
          AS company_name
  FROM (    SELECT ROUND ( dbms_random.VALUE ( 1
                                             , 3 ) )
                      risk_type
                 , ROUND ( dbms_random.VALUE ( 1000
                                             , 20000 )
                         , 2 )
                      ins_cost
                 , ROUND ( dbms_random.VALUE ( 1
                                             , 5 ) )
                      comp_name
              FROM DUAL
        CONNECT BY ROWNUM <= 10000)
        
        
    