/* Formatted on 12.08.2013 11:58:29 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_programs_scd_sal
AS
   -- Procedure load Programs and their managers in Dimension entity SCD type 2
   PROCEDURE load_dim_programs_scd
   AS
   BEGIN
      --Update data about validity
      UPDATE sal.dim_programs_scd trg
         SET trg.valid_to =
                TRUNC ( SYSDATE
                      , 'dd' )
           , trg.is_active = 'N'
       WHERE trg.is_active = 'Y' and trg.program_id IN (SELECT program_id
                                  FROM tmp_programs);

      --Insert data
      INSERT INTO sal.dim_programs_scd trg ( program_surr_id
                                           , program_id
                                           , program_code
                                           , program_desc
                                           , manager_id
                                           , manager_desc
                                           , valid_from
                                           , valid_to
                                           , is_active
                                           , insert_dt )
         SELECT prg_surr_seq.NEXTVAL
              , cls.program_id
              , cls.program_code
              , cls.program_desc
              , cls.manager_id
              , cls.manager_desc
              , TRUNC ( SYSDATE
                      , 'dd' )
              , TO_DATE ( '31/12/9999'
                        , 'dd/mm/yyyy' )
              , 'Y'
              , SYSDATE
           FROM tmp_programs cls;

      --Commit Results
      COMMIT;
   END load_dim_programs_scd;
END pkg_etl_dim_programs_scd_sal;
/