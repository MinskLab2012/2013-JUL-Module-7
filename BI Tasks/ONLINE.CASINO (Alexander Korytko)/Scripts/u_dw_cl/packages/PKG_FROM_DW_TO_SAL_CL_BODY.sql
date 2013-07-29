CREATE OR REPLACE PACKAGE BODY PKG_FROM_DW_TO_SAL_CL
AS
   PROCEDURE LOAD_TO_SAL_CL_USERS
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE T_DW_CL_USERS';

      INSERT INTO T_DW_CL_USERS (User_ID,
                                 First_Name,
                                 Last_Name,
                                 Gender,
                                 Year_Of_Birth,
                                 User_Balance,
                                 Country_ID,
                                 Marige_Status)
         SELECT DISTINCT User_ID,
                         First_Name,
                         Last_Name,
                         Gender,
                         Year_Of_Birth,
                         User_Balance,
                         Country_ID,
                         Marige_Status
           FROM U_SA_DATA.T_SA_USERS;

      COMMIT;
   END LOAD_TO_CL_USERS;


   PROCEDURE LOAD_TO_CL_TRANSACTIONS
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE T_DW_CL_TRANSACTIONS';

      INSERT INTO T_DW_CL_TRANSACTIONS (TRANSACTION_ID,
                                        EVENT_DT,
                                        COUNTRY_ID,
                                        USER_ID,
                                        CURRENCY_ID,
                                        CURRENCY_NAME,
                                        AMOUNT,
                                        OPERATION_TYPE_ID,
                                        OPERATION_TYPE_NAME,
                                        OPERATION_TYPE_METHOD_ID,
                                        OPERATION_TYPE_METHOD_NAME)
         SELECT DISTINCT TRANSACTION_ID,
                         EVENT_DT,
                         COUNTRY_ID,
                         USER_ID,
                         CURRENCY_ID,
                         CURRENCY_NAME,
                         AMOUNT,
                         OPERATION_TYPE_ID,
                         OPERATION_TYPE_NAME,
                         OPERATION_TYPE_METHOD_ID,
                         OPERATION_TYPE_METHOD_NAME
           FROM U_SA_DATA.T_SA_TRANSACTIONS;

      COMMIT;
   END LOAD_TO_CL_TRANSACTIONS;
END;