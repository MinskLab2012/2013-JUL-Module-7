--drop table tmp_opers
--select * from tmp_opers order by 1

Create table T_SA_TMP_DATA as
SELECT --+materailized
      rn AS ID,
      TRUNC ( SYSDATE )
       - dbms_random.VALUE (1,365 )  AS event_dt,
     
      TRUNC ( dbms_random.VALUE ( 1  , 241 ) ) AS Country_ID,
    
      ROUND ( dbms_random.VALUE ( 1 , 4960 ) )   AS User_ID, 
        
     ROUND ( dbms_random.VALUE ( 1 , 8 ) )   AS Currency_ID, 
           
     ROUND ( dbms_random.VALUE ( 10 , 2345 ) )   AS Amount, 
          
     ROUND ( dbms_random.VALUE ( 1 , 2 ) )   AS Operation_Type_ID, 
     
     ROUND ( dbms_random.VALUE ( 1 , 4 ) )   AS Operation_Type_Method_ID
     
  FROM (    SELECT ROWNUM AS rn
              FROM DUAL
        CONNECT BY ROWNUM < 1000000);

Create table T_SA_TRANSACTIONS as
SELECT --+materailized
      ID as TRANSACTION_ID,
      Event_DT,
      Country_ID,
      User_ID, 
      Currency_ID, 
      DECODE (Currency_ID, 1, 'EURO', 
                                        2, 'DOLLAR',
                                        3, 'POUND',
                                        4, 'KRONA',
                                        5, 'FRANC',
                                        6, 'YEN',
                                        7, 'KRONER',
                                        8, 'RUBL') as    Currency_Name,
      Amount, 
      Operation_Type_ID, 
      DECODE (Operation_Type_ID, 1, 'DEPOSIT', 
                                                  2, 'WITHDRAWAL') as    Operation_Type_Name,
      Operation_Type_Method_ID,
      DECODE (Operation_Type_Method_ID, 1, 'CREDIT_CARD', 
                                                              2, 'BANK_TRANSFER',
                                                              3, 'CHECK',
                                                              4, 'PAYPAL') as     Operation_Type_Method_Name
      FROM
      T_SA_TMP_DATA
      
--      drop table T_SA_TRANSACTIONS
--      Select * from T_SA_TRANSACTIONS
--      
--      SELECT * FROM DBA_DATA_FILES;
SELECT * FROM T_SA_TRANSACTIONS
