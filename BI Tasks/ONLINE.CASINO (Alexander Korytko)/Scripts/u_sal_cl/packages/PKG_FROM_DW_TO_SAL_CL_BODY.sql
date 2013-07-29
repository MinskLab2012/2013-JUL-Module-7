CREATE OR REPLACE PACKAGE BODY PKG_FROM_DW_TO_SAL_CL
AS
   PROCEDURE LOAD_TO_SAL_CL_USERS
   AS
   BEGIN
      DELETE FROM U_SAL_CL.DIM_USERS
            WHERE USER_ID IN
                     (     SELECT DISTINCT USER_ID FROM U_DW.T_DW_USERS
                      MINUS
                           SELECT DISTINCT USER_ID FROM U_SAL_CL.DIM_USERS);

      MERGE INTO U_SAL_CL.DIM_USERS SAL_CL
           USING (SELECT User_ID,
                         First_Name,
                         Last_Name,
                         Gender,
                         Year_Of_Birth,
                         User_Balance
                        
                    FROM U_DW.T_DW_USERS) DWU
              ON (DWU.User_ID = SAL_CL.User_ID)
      WHEN NOT MATCHED
      THEN
         INSERT            (User_ID,
                            First_Name,
                            Last_Name,
                            Gender,
                            Year_Of_Birth,
                            User_Balance
                            )
             VALUES (DWU.User_ID,
                     DWU.First_Name,
                     DWU.Last_Name,
                     DWU.Gender,
                     DWU.Year_Of_Birth,
                     DWU.User_Balance
                     )
      WHEN MATCHED
      THEN
         UPDATE SET                             
                --  SAL_CL.User_ID = DWU.User_ID,
                    SAL_CL.First_Name = DWU.First_Name,
                    SAL_CL.Last_Name = DWU.Last_Name,
                    SAL_CL.Gender = DWU.Gender,
                    SAL_CL.Year_Of_Birth = DWU.Year_Of_Birth,
                    SAL_CL.User_Balance = DWU.User_Balance;
                   

      COMMIT;
   END LOAD_TO_SAL_CL_USERS;

PROCEDURE LOAD_TO_SAL_CL_TRANSACTIONS
   AS
   BEGIN
    DELETE FROM U_SAL_CL.FCT_TRANSACTIONS WHERE TRANSACTION_ID IN
    (SELECT --+ PARALLEL(U_SAL_CL.FCT_TRANSACTIONS,4)
      DISTINCT TRANSACTION_ID FROM U_SAL_CL.FCT_TRANSACTIONS
     MINUS
    SELECT --+ PARALLEL(U_DW.T_DW_FCT,4) 
      DISTINCT TRANSACTION_ID FROM U_DW.T_DW_FCT_TIMESTAMPS);
     
     MERGE INTO U_SAL_CL.FCT_TRANSACTIONS SAL_CL
     USING (SELECT --+ PARALLEL(U_DW.T_DW_FCT_TIMESTAMPS,4)  
                             TRANSACTION_ID,
                             USER_ID,

                             OPERATION_TYPE_METHOD_ID,
                             OPERATION_TYPE_ID,
                             EVENT_DT,
                             CURRENCY_ID,
                             COUNTRY_ID,
                             FCT_AMOUNT
                        FROM U_DW.T_DW_FCT_TIMESTAMPS) DWU
      ON (SAL_CL.TRANSACTION_ID=DWU.TRANSACTION_ID )
      
      WHEN NOT MATCHED THEN
        INSERT --+ PARALLEL(U_SAL_CL.FCT_TRANSACTIONS,4) 
         (TRANSACTION_ID,USER_ID,OPERATION_TYPE_METHOD_ID,OPERATION_TYPE_ID,EVENT_DT, CURRENCY_ID, COUNTRY_ID, FCT_AMOUNT)
         VALUES
          (DWU.TRANSACTION_ID,(DWU.USER_ID -10000),DWU.OPERATION_TYPE_METHOD_ID,DWU.OPERATION_TYPE_ID,TRUNC(DWU.EVENT_DT), DWU.CURRENCY_ID, DWU.COUNTRY_ID, DWU.FCT_AMOUNT)
      WHEN MATCHED THEN
        UPDATE --+ PARALLEL(U_SAL_CL.FCT_TRANSACTIONS,4)
         SET  
             SAL_CL.USER_ID=(DWU.USER_ID-10000),
             SAL_CL.OPERATION_TYPE_METHOD_ID = DWU.OPERATION_TYPE_METHOD_ID,
             SAL_CL.OPERATION_TYPE_ID = DWU.OPERATION_TYPE_ID,
             SAL_CL.EVENT_DT = TRUNC(DWU.EVENT_DT),
             SAL_CL.CURRENCY_ID = DWU.CURRENCY_ID,
             SAL_CL.COUNTRY_ID = DWU.COUNTRY_ID,
             SAL_CL.FCT_AMOUNT = DWU.FCT_AMOUNT;
             
         COMMIT;   

   END LOAD_TO_SAL_CL_TRANSACTIONS; 
   
   
   
   
   PROCEDURE LOAD_TO_SAL_CL_OPER_TYPE_MET
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DIM_OPERATION_TYPES_METHODS';

      INSERT INTO DIM_OPERATION_TYPES_METHODS (  OPERATION_TYPE_METHOD_ID,
                                                  OPERATION_TYPE_METHOD_DESC
                                               )
         SELECT DISTINCT OPERATION_TYPE_METHOD_ID,
                         OPERATION_TYPE_METHOD_DESC
           FROM U_DW.T_DW_OPERATION_TYPES_METHODS;

      COMMIT;
   END LOAD_TO_SAL_CL_OPER_TYPE_MET;

   PROCEDURE LOAD_TO_SAL_CL_OPER_TYPE
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DIM_OPERATION_TYPES';

      INSERT INTO U_SAL_CL.DIM_OPERATION_TYPES  (          OPERATION_TYPE_ID,
                                                  OPERATION_TYPE_DESC,
                                                  OPERATION_TYPE_MAX_AMOUNT,
                                                  OPERATION_TYPE_MIN_AMOUNT
                                                                                                    
                                               )
         SELECT DISTINCT                          OPERATION_TYPE_ID,
                                                  OPERATION_TYPE_DESC,
                                                  OPERATION_TYPE_MAX_AMOUNT,
                                                  OPERATION_TYPE_MIN_AMOUNT
           FROM U_DW.T_DW_OPERATION_TYPES;

      COMMIT;
   END LOAD_TO_SAL_CL_OPER_TYPE;
   
   PROCEDURE LOAD_TO_SAL_CL_CURRENCY
        AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DIM_CURRENCY_SCD';

      INSERT INTO U_SAL_CL.DIM_CURRENCY_SCD  (  CURRENCY_SUR_ID
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
           FROM U_DW.T_DW_CURRENCY_SCD;

      COMMIT;
   END LOAD_TO_SAL_CL_CURRENCY;  
 END;