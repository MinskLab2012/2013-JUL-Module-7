Create table tmp_opers as
SELECT --+materailized
      TRUNC ( SYSTIMESTAMP )
       - dbms_random.VALUE ( 1
                           , 5000 )
          AS event_dt
     , rn AS oper_num
     , TRUNC ( dbms_random.VALUE ( 1
                                 , 1000000 )
             , 2 )
          AS costs
     , ROUND ( dbms_random.VALUE ( 1
                                 , 241 ) )
       + 1
          AS cntr_num
     , ROUND ( dbms_random.VALUE ( 1
                                 , 148834 ) )
       + 10
          AS people_num
     , ROUND ( dbms_random.VALUE ( 1
                                 , 22 ) )
       + 10
          AS product_num
  FROM (    SELECT ROWNUM AS rn
              FROM DUAL
        CONNECT BY ROWNUM < 10000);
      
  
begin
  for c in 1..100 loop
  end loop;
end;  