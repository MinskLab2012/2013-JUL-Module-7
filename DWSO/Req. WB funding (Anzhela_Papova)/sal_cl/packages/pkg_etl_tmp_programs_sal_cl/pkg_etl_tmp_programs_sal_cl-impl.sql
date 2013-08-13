/* Formatted on 12.08.2013 11:34:39 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_tmp_programs_sal_cl
AS
   -- Procedure load difference between actual data in the table t_act_programs and data on SAL Layer from dim_programs_scd
   PROCEDURE load_tmp_programs
   AS
   BEGIN
      --Delete old values
      EXECUTE IMMEDIATE 'TRUNCATE TABLE tmp_programs DROP STORAGE';

      --Insert data
      INSERT INTO tmp_programs ( program_id
                               , program_code
                               , program_desc
                               , manager_id
                               , manager_desc
                               , start_date )
         SELECT program_id
              , program_code
              , program_desc
              , manager_id
              , manager_desc
              , start_date
           FROM sal_dw_cl.t_act_programs
         MINUS
         SELECT program_id
              , program_code
              , program_desc
              , manager_id
              , manager_desc
              , valid_from
           FROM sal.dim_programs_scd;

      --Commit Results
      COMMIT;
   END load_tmp_programs;
END pkg_etl_tmp_programs_sal_cl;
/