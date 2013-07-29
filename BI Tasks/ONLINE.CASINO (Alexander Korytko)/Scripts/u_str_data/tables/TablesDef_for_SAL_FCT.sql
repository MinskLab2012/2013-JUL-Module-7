--DROP TABLE FCT_TRANSACTIONS CASCADE CONSTRAINTS;   
   

CREATE TABLE FCT_TRANSACTIONS
(
   TRANSACTION_ID             NUMBER,
   OPERATION_TYPE_ID          NUMBER,
   OPERATION_TYPE_METHOD_ID   NUMBER,
   COUNTRY_ID                 NUMBER,
   USER_ID                    NUMBER (32),
   EVENT_DT                   DATE,
   CURRENCY_ID                NUMBER (32),
   FCT_AMOUNT                 NUMBER (32)
)

      partition by range (EVENT_DT)     
    ( 
     partition p1 values less than (to_date('01-04-2011','dd-mm-yyyy')) tablespace TS_SAL_M1,
      partition p2 values less than (to_date('01-05-2011','dd-mm-yyyy')) tablespace TS_SAL_M2,
       partition p3 values less than (to_date('01-06-2011','dd-mm-yyyy')) tablespace TS_SAL_M3,
        partition p4 values less than (to_date('01-07-2011','dd-mm-yyyy')) tablespace TS_SAL_M4,
         partition p5 values less than (to_date('01-08-2011','dd-mm-yyyy')) tablespace TS_SAL_M5,
          partition p6 values less than (to_date('01-09-2011','dd-mm-yyyy')) tablespace TS_SAL_M6,
           partition p7 values less than (to_date('01-10-2011','dd-mm-yyyy')) tablespace TS_SAL_M7,
            partition p8 values less than (to_date('01-11-2011','dd-mm-yyyy')) tablespace TS_SAL_M8,
             partition p9 values less than (to_date('01-12-2011','dd-mm-yyyy')) tablespace TS_SAL_M9,
              partition p10 values less than (to_date('01-01-2012','dd-mm-yyyy')) tablespace TS_SAL_M10,
               partition p11 values less than (to_date('01-02-2012','dd-mm-yyyy')) tablespace TS_SAL_M11,
                partition p12 values less than (to_date('01-03-2012','dd-mm-yyyy')) tablespace TS_SAL_M12,
                 partition p13 values less than (MAXVALUE) tablespace TS_SAL_M13
      );
      

