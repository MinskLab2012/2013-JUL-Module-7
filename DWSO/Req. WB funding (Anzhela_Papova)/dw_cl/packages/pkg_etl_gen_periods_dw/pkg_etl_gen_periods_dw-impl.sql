/* Formatted on 01.08.2013 19:39:23 (QP5 v5.139.911.3011) */
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
      --Delete old values
      DELETE FROM dw.t_gen_periods;

      --Insert Source data
      open c_gp for
         select distinct period_code
                       , period_desc
                       , value_from_num
                       , value_to_num
           from sa_finance.gen_periods;

      loop
         fetch c_gp
         bulk COLLECT into blk_code, blk_desc, blk_from, blk_to
         LIMIT 1000;

         forall i in 1 .. blk_code.COUNT
            insert into dw.t_gen_periods ( period_id
                                         , period_code
                                         , period_desc
                                         , value_from_num
                                         , value_to_num
                                         , insert_dt
                                         , update_dt )
                 values ( gp_seq.NEXTVAL
                        , blk_code ( i )
                        , blk_desc ( i )
                        , blk_from ( i )
                        , blk_to ( i )
                        , SYSDATE
                        , SYSDATE );

         exit when c_gp%NOTFOUND;
      end loop;

      close c_gp;

      --Commit Result
      commit;
   end load_gen_periods;
end pkg_etl_gen_periods_dw;
/