/* Formatted on 12.08.2013 10:49:40 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_act_programs_dw_cl
AS
   -- Procedure load Actual Data about  programs and theirs managers from DW Layer
   PROCEDURE load_act_programs
   AS
   BEGIN
      --Delete old values
      EXECUTE IMMEDIATE 'TRUNCATE TABLE t_act_programs DROP STORAGE';

      --Insert Source data
      INSERT INTO t_act_programs ( program_id
                                 , program_code
                                 , program_desc
                                 , manager_id
                                 , manager_desc
                                 , start_date )
         SELECT /*+ parallel(prg 8) parallel (mng 8) parallel (prmn 8) parallel (prsd 8)*/
               prsd.program_id
              , prg.program_code
              , prg.program_desc
              , mng.manager_id
              , mng.manager_desc
              , prsd.start_date
           FROM dw.t_programs prg
              , dw.t_managers mng
              , dw.t_program_manager prmn
              , (  SELECT prmn.program_id
                        , MAX ( prmn.start_date ) AS start_date
                     FROM dw.t_program_manager prmn
                 GROUP BY prmn.program_id) prsd
          WHERE prmn.program_id = prg.program_id
            AND prmn.manager_id = mng.manager_id
            AND ( prmn.program_id = prsd.program_id
             AND prmn.start_date = prsd.start_date );

      --Commit Results
      COMMIT;
   END load_act_programs;
END pkg_etl_act_programs_dw_cl;
/