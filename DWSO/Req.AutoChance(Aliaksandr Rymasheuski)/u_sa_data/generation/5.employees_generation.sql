--drop table tmp_employees;
CREATE TABLE tmp_employees
AS
SELECT DISTINCT rownum emp_id
                ,emp.first_name
              , emp.last_name
              , jb.job_title AS position
              , emp.cntr_city_num as office_id
              , cc.country office_country
              , cc.capital AS office_city
              ,    SUBSTR ( cc.country
                          , 1
                          , 3 )
                || SUBSTR ( cc.capital
                          , 3 )
                || ' Str. '
                || LENGTH ( cc.country )
                   AS adress
              , DECODE ( emp.gender,  1, 'F',  2, 'M' ) AS gender
              , emp.salary
  FROM (SELECT --+NO_MERGE ORDERED
              hr1.first_name
             , hr2.last_name
             , ROUND ( dbms_random.VALUE ( 1
                                         , 192 ) )
                  AS cntr_city_num
             , ROUND ( dbms_random.VALUE ( 1
                                         , 2 ) )
                  AS gender
             , ROUND ( dbms_random.VALUE ( 1
                                         , 19 ) )
                  AS position
             , ROUND ( dbms_random.VALUE ( 500
                                         , 5000 )
                     , -1 )
                  AS salary
          FROM hr.employees hr1
             , hr.employees hr2
             , (    SELECT ROWNUM
                      FROM DUAL
                CONNECT BY ROWNUM <= 2)) emp
     , tmp_countries_city cc
     , (SELECT ROWNUM jb_id
             , job_title
          FROM hr.jobs) jb
 WHERE cc.cc_id = emp.cntr_city_num
   AND jb.jb_id = emp.position;
   commit;
 