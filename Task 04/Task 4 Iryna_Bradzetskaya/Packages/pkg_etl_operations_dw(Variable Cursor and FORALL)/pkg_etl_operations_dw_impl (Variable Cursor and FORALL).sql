CREATE OR REPLACE PACKAGE BODY pkg_etl_operations_dw
AS
   -- Load Data From Sources table to DataBase
   PROCEDURE load_operations
   AS
      TYPE cur IS REF CURSOR;
      TYPE t_id IS TABLE OF NUMBER;
      TYPE t_code IS TABLE OF NUMBER;
      TYPE t_name IS TABLE OF VARCHAR2 ( 50 );
      TYPE t_method_id IS TABLE OF NUMBER;
      TYPE t_min IS TABLE OF NUMBER;
      TYPE t_max IS TABLE OF NUMBER;
      c1             cur;
      blk_id         t_id;
      blk_code       t_code;
      blk_name       t_name;
      blk_min        t_min;
      blk_max        t_max;
   BEGIN
      --Insert Source data
      OPEN c1 FOR
         SELECT DISTINCT sa_t.operation_id
                       , dw_t.operation_code
                       , sa_t.operation_name
                       , sa_t.operation_min_amount
                       , sa_t.operation_max_amount
           FROM    u_sa_data.tmp_operations sa_t
                LEFT OUTER JOIN
                   u_dw.dw_operations dw_t
                ON ( dw_t.operation_code = sa_t.operation_id );

      LOOP
         FETCH c1
         BULK COLLECT INTO blk_id, blk_code, blk_name, blk_min, blk_max
         LIMIT 1000;

         FORALL i IN blk_code.FIRST .. blk_code.LAST
            MERGE INTO u_dw.dw_operations o_s
                 USING (SELECT *
                          FROM u_sa_data.tmp_operations) cls
                    ON ( o_s.operation_code = cls.operation_id )
            WHEN NOT MATCHED THEN
               INSERT            ( operation_id
                                 , operation_code
                                 , operation_name
                                 , operation_max_amount
                                 , operation_min_amount
                                 , insert_dt )
                   VALUES ( seq_operations.NEXTVAL
                          , blk_id ( i )
                          , blk_name ( i )
                          , blk_max ( i )
                          , blk_min ( i )
                          , SYSDATE )
            WHEN MATCHED THEN
               UPDATE SET o_s.operation_name = cls.operation_name
                        , o_s.operation_max_amount = cls.operation_max_amount
                        , o_s.operation_min_amount = cls.operation_min_amount
                        , o_s.update_dt = SYSDATE
                       WHERE o_s.operation_name != cls.operation_name
                          OR  o_s.operation_max_amount != cls.operation_max_amount
                          OR  o_s.operation_min_amount != cls.operation_min_amount;
         EXIT WHEN c1%NOTFOUND;
      END LOOP;
      CLOSE c1;
      DELETE FROM u_dw.dw_operations
            WHERE operation_id IN (SELECT t.operation_id
                                     FROM u_dw.dw_operations t
                                    WHERE t.ROWID > (SELECT MIN ( tt.ROWID )
                                                       FROM u_dw.dw_operations tt
                                                      WHERE t.operation_name = tt.operation_name));

      --Commit Result
      COMMIT;
   END load_operations;
END pkg_etl_operations_dw;
