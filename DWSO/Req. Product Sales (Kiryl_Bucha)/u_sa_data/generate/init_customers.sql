Create table tmp_customers
as
SELECT distinct 
       usr.first_name
     , usr.last_name
     , usr.rand_date as birth_day
     , cntr.cntr_desc
  FROM (SELECT --+NO_MERGE ORDERED
               hr1.first_name
             , hr2.last_name
             , ROUND(dbms_random.VALUE ( 1
                                 , 241 ))
                  AS cntr_num
             ,  TO_DATE ( TRUNC ( dbms_random.VALUE ( 2452000
                                           , 2456293 ) )
               , 'j' ) AS rand_date 
          FROM hr.employees hr1
             , hr.employees hr2
             , (select rownum from dual connect by rownum <= 13)
             ) usr
     , (SELECT ROWNUM AS rn
             , i.cntr_desc
          FROM (  SELECT cntr.region_desc cntr_desc
                    FROM u_dw_references.cu_countries cntr
                ORDER BY region_desc) i) cntr                
 WHERE cntr.rn = usr.cntr_num