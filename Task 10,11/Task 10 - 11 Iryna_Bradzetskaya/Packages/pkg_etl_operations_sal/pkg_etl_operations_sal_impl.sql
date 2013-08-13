CREATE OR REPLACE PACKAGE BODY pkg_etl_operations_sal
AS
   -- Reload Data From Stage table to Star
   PROCEDURE load_dim_operations
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_sal.dim_operations sal_t
           USING (SELECT operation_id
                           , operation_name
                           , operation_max_amount                           
                           , operation_min_amount
                           , DW_OM.operation_method_id
                           , operation_method_name
                           , operation_method_type
                           , operation_method_type_id
FROM u_dw.dw_operations DW_O LEFT OUTER JOIN 
u_dw.dw_operation_methods  DW_OM ON (DW_O.operation_method_id= DW_OM.operation_method_id )) dw_t
              ON ( sal_t.operation_id = dw_t.operation_id )
      WHEN NOT MATCHED THEN
         INSERT            ( sal_t.operation_method_id
                           , sal_t.operation_method_name
                           , sal_t.operation_method_type
                           , sal_t.operation_method_type_id
                           , sal_t.operation_name
                           , sal_t.operation_id
                           , sal_t.operation_max_amount                           
                           , sal_t.operation_min_amount
                           , sal_t.insert_dt )
             VALUES ( dw_t.operation_method_id
                    , dw_t.operation_method_name
                    , dw_t.operation_method_type
                    , dw_t.operation_method_type_id
                    , dw_t.operation_name
                    , dw_t.operation_id
                    , dw_t.operation_max_amount                           
                    , dw_t.operation_min_amount
                    , SYSDATE)
      WHEN MATCHED THEN
         UPDATE SET 
                   sal_t.operation_min_amount = dw_t.operation_min_amount 
                  , sal_t.operation_max_amount= dw_t.operation_max_amount
                  ,sal_t.operation_method_type = dw_t.operation_method_type
                  , sal_t.operation_method_type_id = dw_t.operation_method_type_id
                  , sal_t.update_dt = SYSDATE
                  WHERE sal_t.operation_min_amount != dw_t.operation_min_amount 
                  or sal_t.operation_max_amount != dw_t.operation_max_amount
                  or sal_t.operation_method_type != dw_t.operation_method_type
                  or sal_t.operation_method_type_id != dw_t.operation_method_type_id
                  ;

      --Commit Result
      COMMIT;
   END load_dim_operations;
END pkg_etl_operations_sal;


INSERT INTO u_sal.dim_operations (OPERATION_ID, OPERATION_NAME, OPERATION_METHOD_NAME, OPERATION_METHOD_TYPE) VALUES ( -99,'n/d', 'n/d', 'n/d');