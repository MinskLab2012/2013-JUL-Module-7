CREATE OR REPLACE PACKAGE BODY pkg_load_dim_currency_sal
AS
   PROCEDURE load_currency
   AS

      CURSOR c_currency
      IS
         SELECT CUR.CURRENCY_ID
       , CUR.CURRENCY_TYPE_ID
       , CUR_A.VALUE_NEW
       , CUR.CURRENCY_NAME
       , CUR.CURRENCY_CODE
       , CUR.CURRENCY_DESC
       , CUR_T.CURRENCY_TYPE_DESC
        FROM U_DW.DW_CURRENCY CUR
        LEFT OUTER JOIN U_DW.dw_currency_types CUR_T ON (CUR_T.CURRENCY_TYPE_ID = cur.currency_type_id)
        LEFT OUTER JOIN U_DW.dw_currency_actions CUR_A ON ( CUR_A.CURRENCY_ID = cur.currency_id)
        WHERE CUR.CURRENCY_CODE IN (
         SELECT CURRENCY_CODE FROM U_DW.DW_CURRENCY
         MINUS
         
         SELECT CURRENCY_CODE
           FROM u_sal.DIM_CURRENCY_SCD WHERE valid_to = TO_DATE ( '01/01/9999'
                                   , 'mm/dd/yyyy' ))
                                   
                                   
                                   
                                  and ( CUR_A.CURRENCY_ID, CUR_A.action_date ) IN (  SELECT CURRENCY_ID
                                                       , MAX ( action_date )
                                                    FROM u_dw.DW_CURRENCY_ACTIONS
                                                   WHERE CURRENCY_action_type_id = 1
                                                GROUP BY CURRENCY_ID);

          
   BEGIN
      FOR i IN c_currency LOOP
         INSERT INTO u_sal.DIM_CURRENCY_SCD ( CURRENCY_SUR_ID 
   , CURRENCY_TYPE_ID
   , CURRENCY_DESC
   , CURRENCY_NAME
   , CURRENCY_CODE    
   , CURRENCY_TO_DOLLAR  
   , CURRENCY_TYPE_DESC
   , VALID_FROM  
   , VALID_TO
 )
              VALUES (  i.CURRENCY_ID 
                     , i.CURRENCY_TYPE_ID
                     , i.CURRENCY_DESC
                     , i.CURRENCY_NAME
                     , i.CURRENCY_CODE 
                     , i.VALUE_NEW 
                     , i.CURRENCY_TYPE_DESC
                     , ( SELECT MAX ( action_date )
                           FROM u_dw.DW_CURRENCY_ACTIONS
                          WHERE CURRENCY_ACTION_TYPE_ID = 1
                            AND CURRENCY_ID = i.CURRENCY_ID )
                     , TO_DATE ( '01/01/9999'
                               , 'mm/dd/yyyy' ) );


         UPDATE u_sal.DIM_CURRENCY_SCD
            SET valid_to     =
                   ( SELECT MAX ( action_date )
                           FROM u_dw.DW_CURRENCY_ACTIONS
                          WHERE CURRENCY_ACTION_TYPE_ID = 1
                            AND CURRENCY_ID = i.CURRENCY_ID  )
          WHERE valid_to = TO_DATE ( '01/01/9999'
                                   , 'mm/dd/yyyy' )
            AND CURRENCY_CODE = i.CURRENCY_CODE
            AND valid_from < (SELECT MAX ( action_date )
                           FROM u_dw.DW_CURRENCY_ACTIONS
                          WHERE CURRENCY_ACTION_TYPE_ID = 1
                            AND CURRENCY_ID = i.CURRENCY_ID);
      END LOOP;

      COMMIT;

   END load_currency;
END pkg_load_dim_currency_sal;