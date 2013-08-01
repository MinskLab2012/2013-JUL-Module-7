/* Formatted on 01.08.2013 15:51:00 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_fin_sources_dw
AS
   -- Reload Data From Sources table to DataBase - Finance Sources
   PROCEDURE load_finance_sources
   AS
   BEGIN
      --Merge Source data
      MERGE INTO dw.t_fin_sources trg
           USING (SELECT DISTINCT fin_source_id
                                , fin_source_name
                    FROM sa_finance.finance_sources) cls
              ON ( trg.fin_source_code = cls.fin_source_id )
      WHEN NOT MATCHED THEN
         INSERT            ( fin_source_id
                           , fin_source_code
                           , fin_source_desc
                           , insert_dt
                           , update_dt )
             VALUES ( fs_seq.NEXTVAL
                    , cls.fin_source_id
                    , cls.fin_source_name
                    , SYSDATE
                    , SYSDATE )
      WHEN MATCHED THEN
         UPDATE SET trg.fin_source_desc = fin_source_name
                  , trg.update_dt = SYSDATE;

      --Commit Result
      COMMIT;
   END load_finance_sources;
END pkg_etl_dim_fin_sources_dw;
/