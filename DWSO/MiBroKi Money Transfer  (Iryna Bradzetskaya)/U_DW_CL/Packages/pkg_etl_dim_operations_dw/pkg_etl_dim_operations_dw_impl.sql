CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_operations_dw
AS
   -- Reload Data From Sources table to DataBase
   PROCEDURE load_tmp_methods
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw.dw_operation_methods o_m
           USING (SELECT DISTINCT operation_method_id
                                , operation_method_name
                                , operation_method_type
                                , operation_method_type_id
                    FROM u_sa_data.tmp_methods) cls
              ON ( o_m.operation_method_code = cls.operation_method_id )
      WHEN NOT MATCHED THEN
         INSERT            ( o_m.operation_method_id
                           , o_m.operation_method_code
                           , o_m.operation_method_name
                           , o_m.operation_method_type
                           , o_m.operation_method_type_id
                           , o_m.insert_dt )
             VALUES ( seq_operation_methods.NEXTVAL
                    , cls.operation_method_id
                    , cls.operation_method_name
                    , cls.operation_method_type
                    , cls.operation_method_type_id
                    , SYSDATE)
      WHEN MATCHED THEN
         UPDATE SET  o_m.operation_method_name = cls.operation_method_name
                   ,o_m.operation_method_type = cls.operation_method_type
                  , o_m.operation_method_type_id = cls.operation_method_type_id
                  , o_m.update_dt = SYSDATE
                  WHERE o_m.operation_method_type != cls.operation_method_type or
                  o_m.operation_method_type_id != cls.operation_method_type_id or
                  o_m.operation_method_name != cls.operation_method_name
                  ;

      --Commit Result
      COMMIT;
   END load_tmp_methods;

   PROCEDURE load_tmp_operations
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw.dw_operations o_s
           USING (SELECT DISTINCT operation_id
                                , operation_name
                                , operation_max_amount
                                , operation_min_amount
                    FROM u_sa_data.tmp_operations) cls
              ON ( o_s.operation_code = cls.operation_id )
      WHEN NOT MATCHED THEN
         INSERT            ( operation_id
                           , operation_code
                           , operation_name
                           , operation_max_amount                           
                           , operation_min_amount
                           , insert_dt
                            )
             VALUES ( seq_operations.NEXTVAL
                    , cls.operation_id
                    , cls.operation_name
                    , cls.operation_max_amount
                    , cls.operation_min_amount
                    , SYSDATE
                     )
      WHEN MATCHED THEN
         UPDATE SET o_s.operation_name = cls.operation_name
                  , o_s.operation_max_amount = cls.operation_max_amount
                  , o_s.operation_min_amount = cls.operation_min_amount
                  , o_s.update_dt = SYSDATE
                  WHERE o_s.operation_code != cls.operation_id;

      --Commit Result
      COMMIT;
   END load_tmp_operations;
END pkg_etl_dim_operations_dw;