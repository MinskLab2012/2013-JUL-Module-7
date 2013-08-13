/* Formatted on 10.08.2013 17:24:48 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_gen_periods_sal
AS
   -- Procedure load Data about Budget deficit levels in Dimension entity SCD type 1
   PROCEDURE load_dim_gen_periods
   AS
   BEGIN
      --Merge data
      MERGE INTO sal.dim_gen_periods trg
           USING (SELECT period_id
                       , period_code
                       , period_desc
                       , value_from_num
                       , value_to_num
                       , value_from_dt
                       , value_to_dt
                       , value_from_char
                       , value_to_char
                       , level_code
                    FROM sal_dw_cl.v_gen_periods) cls
              ON ( trg.period_id = cls.period_id )
      WHEN NOT MATCHED THEN
         INSERT            ( period_surr_id
                           , period_id
                           , period_code
                           , period_desc
                           , value_from_num
                           , value_to_num
                           , value_from_dt
                           , value_to_dt
                           , value_from_char
                           , value_to_char
                           , level_code
                           , insert_dt
                           , update_dt )
             VALUES ( periods_seq.NEXTVAL
                    , cls.period_id
                    , cls.period_code
                    , cls.period_desc
                    , cls.value_from_num
                    , cls.value_to_num
                    , cls.value_from_dt
                    , cls.value_to_dt
                    , cls.value_from_char
                    , cls.value_to_char
                    , cls.level_code
                    , SYSDATE
                    , SYSDATE ) ;

      --Commit Results
      COMMIT;
   END load_dim_gen_periods;
END pkg_etl_dim_gen_periods_sal;
/