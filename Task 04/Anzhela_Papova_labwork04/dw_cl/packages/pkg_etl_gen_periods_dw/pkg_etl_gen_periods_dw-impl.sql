/* Formatted on 01.08.2013 22:09:57 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_gen_periods_dw
AS
   -- Load Data From Sources table to DataBase - Finance Items
   PROCEDURE load_gen_periods
   AS
      TYPE var_cur IS REF CURSOR;

      TYPE tmp_code IS TABLE OF VARCHAR2 ( 20 );

      TYPE tmp_desc IS TABLE OF VARCHAR2 ( 50 );

      TYPE tmp_from IS TABLE OF NUMBER;

      TYPE tmp_to IS TABLE OF NUMBER;

      c_gp           var_cur;
      blk_code       tmp_code;
      blk_desc       tmp_desc;
      blk_from       tmp_from;
      blk_to         tmp_to;
   BEGIN
      --Insert Source data
      OPEN c_gp FOR
         SELECT DISTINCT period_code
                       , period_desc
                       , value_from_num
                       , value_to_num
           FROM sa_finance.gen_periods
          WHERE period_code NOT IN (SELECT period_code
                                      FROM dw.t_gen_periods);

      LOOP
         FETCH c_gp
         BULK COLLECT INTO blk_code, blk_desc, blk_from, blk_to
         LIMIT 1000;

         FORALL i IN 1 .. blk_code.COUNT
            INSERT INTO dw.t_gen_periods ( period_id
                                         , period_code
                                         , period_desc
                                         , value_from_num
                                         , value_to_num
                                         , insert_dt
                                         , update_dt )
                 VALUES ( gp_seq.NEXTVAL
                        , blk_code ( i )
                        , blk_desc ( i )
                        , blk_from ( i )
                        , blk_to ( i )
                        , SYSDATE
                        , SYSDATE );

         EXIT WHEN c_gp%NOTFOUND;
      END LOOP;

      CLOSE c_gp;

      --Commit Result
      COMMIT;
   END load_gen_periods;
END pkg_etl_gen_periods_dw;
/