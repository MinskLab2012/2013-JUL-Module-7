/* Formatted on 10.08.2013 17:19:42 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_fin_sources_sal
AS
   -- Procedure load Data about finance sources in Dimension entity SCD type 1
   PROCEDURE load_dim_fin_sources
   AS
   BEGIN
      --Merge data
      MERGE INTO sal.dim_fin_sources trg
           USING (SELECT fin_source_id
                       , fin_source_code
                       , fin_source_desc
                    FROM sal_dw_cl.v_fin_sources) cls
              ON ( trg.fin_source_id = cls.fin_source_id )
      WHEN NOT MATCHED THEN
         INSERT            ( fin_source_id
                           , fin_source_code
                           , fin_source_desc
                           , insert_dt
                           , update_dt )
             VALUES ( cls.fin_source_id
                    , cls.fin_source_code
                    , cls.fin_source_desc
                    , SYSDATE
                    , SYSDATE )
      WHEN MATCHED THEN
         UPDATE SET trg.fin_source_desc = cls.fin_source_desc
                  , trg.update_dt = SYSDATE
                 WHERE trg.fin_source_desc <> cls.fin_source_desc;

      --Commit Results
      COMMIT;
   END load_dim_fin_sources;
END pkg_etl_dim_fin_sources_sal;
/