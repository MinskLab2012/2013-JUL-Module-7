/* Formatted on 12.08.2013 10:04:28 (QP5 v5.139.911.3011) */
--Script loads initial data to dim_programs_scd (should be run once after getting complete data about programs' managers changing)

INSERT INTO sal.dim_programs_scd ( program_surr_id
                                 , program_id
                                 , program_code
                                 , program_desc
                                 , manager_id
                                 , manager_desc
                                 , valid_from
                                 , valid_to
                                 , is_active
                                 , insert_dt )
   SELECT prg_surr_seq.NEXTVAL AS program_surr_id
        , prg.program_id
        , prg.program_code
        , prg.program_desc
        , mng.manager_id
        , mng.manager_desc
        , pmng.start_date AS valid_from
        , LEAD ( pmng.start_date
               , 1
               , TO_DATE ( '31/12/9999'
                         , 'dd/mm/yyyy' ) )
          OVER (PARTITION BY pmng.program_id ORDER BY pmng.start_date ASC)
             AS valid_to
        , DECODE ( LEAD ( pmng.start_date
                        , 1
                        , TO_DATE ( '31/12/9999'
                                  , 'dd/mm/yyyy' ) )
                   OVER (PARTITION BY pmng.program_id ORDER BY pmng.start_date ASC)
                 , TO_DATE ( '31/12/9999'
                           , 'dd/mm/yyyy' ), 'Y'
                 , 'N' )
             AS is_active
        , SYSDATE
     FROM dw.t_programs prg
        , dw.t_managers mng
        , dw.t_program_manager pmng
    WHERE prg.program_id = pmng.program_id
      AND mng.manager_id = pmng.manager_id;

COMMIT;