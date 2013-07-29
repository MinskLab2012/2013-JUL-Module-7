CREATE OR REPLACE PACKAGE BODY PKG_FROM_CL_TO_DW
AS
   PROCEDURE LOAD_TO_DW_USERS
   AS
   BEGIN
      DELETE FROM U_DW.T_DW_USERS
            WHERE USER_ID IN
                     (     SELECT DISTINCT USER_ID FROM U_DW_CL.T_DW_CL_USERS
                      MINUS
                           SELECT DISTINCT USER_ID FROM U_DW.T_DW_USERS);

      MERGE INTO U_DW.T_DW_USERS DWU
           USING (SELECT User_ID,
                         First_Name,
                         Last_Name,
                         Gender,
                         Year_Of_Birth,
                         User_Balance,
                         Country_ID,
                         Marige_Status
                    FROM U_DW_CL.T_DW_CL_USERS) CLU
              ON (DWU.User_ID = CLU.User_ID)
      WHEN NOT MATCHED
      THEN
         INSERT            (User_ID,
                            First_Name,
                            Last_Name,
                            Gender,
                            Year_Of_Birth,
                            User_Balance,
                            Country_ID,
                            Marige_Status)
             VALUES (CLU.User_ID,
                     CLU.First_Name,
                     CLU.Last_Name,
                     CLU.Gender,
                     CLU.Year_Of_Birth,
                     CLU.User_Balance,
                     CLU.Country_ID,
                     CLU.Marige_Status)
      WHEN MATCHED
      THEN
         UPDATE SET                             --  DWU.User_ID = CLU.User_ID,
                    DWU.First_Name = CLU.First_Name,
                    DWU.Last_Name = CLU.Last_Name,
                    DWU.Gender = CLU.Gender,
                    DWU.Year_Of_Birth = CLU.Year_Of_Birth,
                    DWU.User_Balance = CLU.User_Balance,
                    DWU.Country_ID = CLU.Country_ID,
                    DWU.Marige_Status = CLU.Marige_Status;

      COMMIT;
   END LOAD_TO_DW_USERS;

PROCEDURE LOAD_TO_DW_FCT
   AS
   BEGIN
    DELETE FROM U_DW.T_DW_FCT WHERE TRANSACTION_ID IN
    (SELECT --+ PARALLEL(U_DW_CL.T_DW_FCT,4)
      DISTINCT TRANSACTION_ID FROM U_DW_CL.T_DW_CL_TRANSACTIONS
     MINUS
    SELECT --+ PARALLEL(U_DW_CL.T_DW_FCT,4) 
      DISTINCT TRANSACTION_ID FROM U_DW.T_DW_FCT);
     
     MERGE INTO U_DW.T_DW_FCT DWF
     USING (SELECT --+ PARALLEL(U_DW_CL.T_DW_CL_TRANSACTIONS,4)  
                             TRANSACTION_ID,
                             USER_ID,

                             OPERATION_TYPE_METHOD_ID,
                             OPERATION_TYPE_ID,
                             EVENT_DT,
                             CURRENCY_ID,
                             COUNTRY_ID,
                             AMOUNT
                        FROM U_DW_CL.T_DW_CL_TRANSACTIONS) CLF
      ON (DWF.TRANSACTION_ID=CLF.TRANSACTION_ID )
      
      WHEN NOT MATCHED THEN
        INSERT --+ PARALLEL(U_DW_CL.T_DW_FCT,4) 
         (TRANSACTION_ID,USER_ID,OPERATION_TYPE_METHOD_ID,OPERATION_TYPE_ID,EVENT_DT, CURRENCY_ID, COUNTRY_ID, FCT_AMOUNT)
         VALUES
          (CLF.TRANSACTION_ID,(CLF.USER_ID +10000),CLF.OPERATION_TYPE_METHOD_ID,CLF.OPERATION_TYPE_ID,TRUNC(CLF.EVENT_DT), CLF.CURRENCY_ID, CLF.COUNTRY_ID, CLF.AMOUNT)
      WHEN MATCHED THEN
        UPDATE --+ PARALLEL(U_DW_CL.T_DW_FCT,4)
         SET  
             DWF.USER_ID=(CLF.USER_ID+10000),
             DWF.OPERATION_TYPE_METHOD_ID = CLF.OPERATION_TYPE_METHOD_ID,
             DWF.OPERATION_TYPE_ID = CLF.OPERATION_TYPE_ID,
             DWF.EVENT_DT = TRUNC(CLF.EVENT_DT),
             DWF.CURRENCY_ID = CLF.CURRENCY_ID,
             DWF.COUNTRY_ID = CLF.COUNTRY_ID,
             DWF.FCT_AMOUNT = CLF.AMOUNT;
             
         COMMIT;   

   END LOAD_TO_DW_FCT; 
   
   
   PROCEDURE LOAD_TO_DW_OPER_TYPE_METHOD
   AS
   BEGIN
      DECLARE
         IFEXT   NUMBER;
      BEGIN
         DELETE FROM U_DW.T_DW_OPERATION_TYPES_METHODS
               WHERE OPERATION_TYPE_METHOD_ID IN
                        (SELECT DISTINCT OPERATION_TYPE_METHOD_ID
                           FROM U_DW_CL.T_DW_CL_TRANSACTIONS
                         MINUS
                         SELECT DISTINCT OPERATION_TYPE_METHOD_ID
                           FROM U_DW.T_DW_OPERATION_TYPES_METHODS);

         FOR CURS IN (SELECT DISTINCT 
                             OPERATION_TYPE_METHOD_ID,
                             OPERATION_TYPE_METHOD_NAME

                        FROM U_DW_CL.T_DW_CL_TRANSACTIONS)
         LOOP
            SELECT COUNT (OPERATION_TYPE_METHOD_ID)
              INTO IFEXT
              FROM U_DW.T_DW_OPERATION_TYPES_METHODS
             WHERE OPERATION_TYPE_METHOD_ID = CURS.OPERATION_TYPE_METHOD_ID;

            IF IFEXT != 0
            THEN
               UPDATE U_DW.T_DW_OPERATION_TYPES_METHODS
                  SET OPERATION_TYPE_METHOD_DESC = CURS.OPERATION_TYPE_METHOD_NAME
                      
                WHERE U_DW.T_DW_OPERATION_TYPES_METHODS.OPERATION_TYPE_METHOD_ID = CURS.OPERATION_TYPE_METHOD_ID;
            ELSE
               INSERT INTO U_DW.T_DW_OPERATION_TYPES_METHODS (OPERATION_TYPE_METHOD_ID,
                                                               OPERATION_TYPE_METHOD_DESC
                                                               )
                    VALUES ( CURS.OPERATION_TYPE_METHOD_ID,
                            CURS.OPERATION_TYPE_METHOD_NAME);
            END IF;
         END LOOP;

         COMMIT;
      END;
   END LOAD_TO_DW_OPER_TYPE_METHOD; 

   
   PROCEDURE LOAD_TO_DW_OPER_TYPE
   AS
   BEGIN
      DECLARE
      IFEXT NUMBER;
      V_OPERATION_TYPE_ID number;
      V_OPERATION_TYPE_DESC varchar2(32);
      V_OPERATION_TYPE_MAX_AMOUNT number;
      V_OPERATION_TYPE_MIN_AMOUNT number;
      CURSOR CUR is (SELECT DISTINCT OPERATION_TYPE_ID, OPERATION_TYPE_NAME, 100 as OPERATION_TYPE_MAX_AMOUNT , 10 as OPERATION_TYPE_MIN_AMOUNT FROM U_DW_CL.T_DW_CL_TRANSACTIONS);
      BEGIN
      DELETE FROM U_DW.T_DW_OPERATION_TYPES WHERE OPERATION_TYPE_ID IN
      (SELECT DISTINCT OPERATION_TYPE_ID FROM U_DW_CL.T_DW_CL_TRANSACTIONS
      MINUS
      SELECT DISTINCT OPERATION_TYPE_ID FROM U_DW.T_DW_OPERATION_TYPES);
      OPEN CUR;
      LOOP
      FETCH CUR INTO V_OPERATION_TYPE_ID, V_OPERATION_TYPE_DESC, V_OPERATION_TYPE_MAX_AMOUNT, V_OPERATION_TYPE_MIN_AMOUNT;
      SELECT COUNT (OPERATION_TYPE_ID) INTO IFEXT FROM U_DW.T_DW_OPERATION_TYPES WHERE OPERATION_TYPE_ID=V_OPERATION_TYPE_ID;
      
      IF IFEXT!=0
      THEN
      UPDATE U_DW.T_DW_OPERATION_TYPES SET
        OPERATION_TYPE_DESC=V_OPERATION_TYPE_DESC
       , OPERATION_TYPE_MAX_AMOUNT=V_OPERATION_TYPE_MAX_AMOUNT
       , OPERATION_TYPE_MIN_AMOUNT=V_OPERATION_TYPE_MIN_AMOUNT
       WHERE OPERATION_TYPE_ID=V_OPERATION_TYPE_ID;
       ELSE
       INSERT INTO U_DW.T_DW_OPERATION_TYPES(OPERATION_TYPE_ID, OPERATION_TYPE_DESC, OPERATION_TYPE_MAX_AMOUNT, OPERATION_TYPE_MIN_AMOUNT)
       VALUES (V_OPERATION_TYPE_ID, V_OPERATION_TYPE_DESC, V_OPERATION_TYPE_MAX_AMOUNT, V_OPERATION_TYPE_MIN_AMOUNT);
       END IF;
       
       EXIT WHEN CUR%NOTFOUND;
       END LOOP;
       CLOSE CUR;
       COMMIT;
     END;
     END LOAD_TO_DW_OPER_TYPE;
     
 END;