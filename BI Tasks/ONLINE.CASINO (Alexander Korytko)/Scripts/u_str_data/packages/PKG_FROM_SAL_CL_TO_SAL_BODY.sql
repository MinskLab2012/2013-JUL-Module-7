CREATE OR REPLACE PACKAGE BODY PKG_FROM_SAL_CL_TO_SAL
AS
   PROCEDURE LOAD_TO_SAL_USERS
   AS
   BEGIN
      DELETE FROM U_STR_DATA.DIM_USERS
            WHERE USER_ID IN
                     (     SELECT DISTINCT USER_ID FROM U_SAL_CL.DIM_USERS
                      MINUS
                           SELECT DISTINCT USER_ID FROM U_STR_DATA.DIM_USERS);

      MERGE INTO U_STR_DATA.DIM_USERS SAL
           USING (SELECT User_ID,
                         First_Name,
                         Last_Name,
                         Gender,
                         Year_Of_Birth,
                         User_Balance
                        
                    FROM U_SAL_CL.DIM_USERS) SAL_CL
              ON (SAL_CL.User_ID = SAL.User_ID)
      WHEN NOT MATCHED
      THEN
         INSERT            (User_ID,
                            First_Name,
                            Last_Name,
                            Gender,
                            Year_Of_Birth,
                            User_Balance
                            )
             VALUES (SAL_CL.User_ID,
                     SAL_CL.First_Name,
                     SAL_CL.Last_Name,
                     SAL_CL.Gender,
                     SAL_CL.Year_Of_Birth,
                     SAL_CL.User_Balance
                     )
      WHEN MATCHED
      THEN
         UPDATE SET                             
                --  SAL_CL.User_ID = DWU.User_ID,
                    SAL.First_Name = SAL_CL.First_Name,
                    SAL.Last_Name = SAL_CL.Last_Name,
                    SAL.Gender = SAL_CL.Gender,
                    SAL.Year_Of_Birth = SAL_CL.Year_Of_Birth,
                    SAL.User_Balance = SAL_CL.User_Balance;
                   

      COMMIT;
   END LOAD_TO_SAL_USERS;

PROCEDURE LOAD_TO_SAL_TRANSACTIONS
   AS
   BEGIN
    DELETE FROM U_STR_DATA.FCT_TRANSACTIONS WHERE TRANSACTION_ID IN
    (SELECT --+ PARALLEL(U_STR_DATA.FCT_TRANSACTIONS,4)
      DISTINCT TRANSACTION_ID FROM U_STR_DATA.FCT_TRANSACTIONS
     MINUS
    SELECT --+ PARALLEL(U_SAL_CL.FCT_TRANSACTIONS,4) 
      DISTINCT TRANSACTION_ID FROM U_SAL_CL.FCT_TRANSACTIONS);
     
     MERGE INTO U_STR_DATA.FCT_TRANSACTIONS SAL
     USING (SELECT --+ PARALLEL(U_SAL_CL.FCT_TRANSACTIONS,4)  
                             TRANSACTION_ID,
                             USER_ID,
                             OPERATION_TYPE_METHOD_ID,
                             OPERATION_TYPE_ID,
                             EVENT_DT,
                             CURRENCY_ID,
                             COUNTRY_ID,
                             FCT_AMOUNT
                        FROM U_SAL_CL.FCT_TRANSACTIONS) SAL_CL
      ON (SAL.TRANSACTION_ID=SAL_CL.TRANSACTION_ID )
      
      WHEN NOT MATCHED THEN
        INSERT --+ PARALLEL(U_STR_DATA.FCT_TRANSACTIONS,4) 
         (TRANSACTION_ID,USER_ID,OPERATION_TYPE_METHOD_ID,OPERATION_TYPE_ID,EVENT_DT, CURRENCY_ID, COUNTRY_ID, FCT_AMOUNT)
         VALUES
          (SAL_CL.TRANSACTION_ID,SAL_CL.USER_ID,SAL_CL.OPERATION_TYPE_METHOD_ID,SAL_CL.OPERATION_TYPE_ID,SAL_CL.EVENT_DT, SAL_CL.CURRENCY_ID, SAL_CL.COUNTRY_ID, SAL_CL.FCT_AMOUNT)
      WHEN MATCHED THEN
        UPDATE --+ PARALLEL(U_STR_DATA.FCT_TRANSACTIONS,4)
         SET  
             SAL.USER_ID=SAL_CL.USER_ID,
             SAL.OPERATION_TYPE_METHOD_ID = SAL_CL.OPERATION_TYPE_METHOD_ID,
             SAL.OPERATION_TYPE_ID = SAL_CL.OPERATION_TYPE_ID,
             SAL.EVENT_DT = SAL_CL.EVENT_DT,
             SAL.CURRENCY_ID = SAL_CL.CURRENCY_ID,
             SAL.COUNTRY_ID = SAL_CL.COUNTRY_ID,
             SAL.FCT_AMOUNT = SAL_CL.FCT_AMOUNT;
             
         COMMIT;   

   END LOAD_TO_SAL_TRANSACTIONS; 
   
   
   
   
   PROCEDURE LOAD_TO_SAL_OPER_TYPE_MET
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE U_STR_DATA.DIM_OPERATION_TYPES_METHODS';

      INSERT INTO U_STR_DATA.DIM_OPERATION_TYPES_METHODS (  OPERATION_TYPE_METHOD_ID,
                                                  OPERATION_TYPE_METHOD_DESC
                                               )
         SELECT DISTINCT OPERATION_TYPE_METHOD_ID,
                         OPERATION_TYPE_METHOD_DESC
           FROM U_SAL_CL.DIM_OPERATION_TYPES_METHODS;

      COMMIT;
   END LOAD_TO_SAL_OPER_TYPE_MET;

   PROCEDURE LOAD_TO_SAL_OPER_TYPE
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE U_STR_DATA.DIM_OPERATION_TYPES';

      INSERT INTO U_STR_DATA.DIM_OPERATION_TYPES  ( OPERATION_TYPE_ID,
                                                    OPERATION_TYPE_DESC,
                                                    OPERATION_TYPE_MAX_AMOUNT,
                                                    OPERATION_TYPE_MIN_AMOUNT
                                                                                                    
                                                  )
                                                  
         SELECT DISTINCT                          OPERATION_TYPE_ID,
                                                  OPERATION_TYPE_DESC,
                                                  OPERATION_TYPE_MAX_AMOUNT,
                                                  OPERATION_TYPE_MIN_AMOUNT
           FROM U_SAL_CL.DIM_OPERATION_TYPES;

      COMMIT;
   END LOAD_TO_SAL_OPER_TYPE;
   
   PROCEDURE LOAD_TO_SAL_CL_CURRENCY
        AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE U_STR_DATA.DIM_CURRENCY_SCD';

      INSERT INTO U_STR_DATA.DIM_CURRENCY_SCD  (  CURRENCY_SUR_ID
                                              , CURRENCY_ID
                                              , CURRENCY_TYPE_ID
                                              , CURRENCY_DESC
                                              , ACTUAL
                                              , BEGIN_EVENT
                                              , END_EVENT
                                                                                                    
                                               )
                                               
         SELECT DISTINCT                        CURRENCY_SUR_ID
                                              , CURRENCY_ID
                                              , CURRENCY_TYPE_ID
                                              , CURRENCY_DESC
                                              , ACTUAL
                                              , BEGIN_EVENT
                                              , END_EVENT
           FROM U_SAL_CL.DIM_CURRENCY_SCD;

      COMMIT;
   END LOAD_TO_SAL_CL_CURRENCY;  
   
   
 END;