/* Formatted on 13.08.2013 9:30:10 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_act_fct_finances_dw_cl
AS
   -- Package  load Fact data for rewriting from DW Layer
   PROCEDURE load_act_fct_fin_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                          , 'yyyy' )
                                                                                  , -12 )
                                        , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                             , 'mm' ) )
   AS
   BEGIN
      --Delete old values
      EXECUTE IMMEDIATE 'TRUNCATE TABLE  t_act_fct_finances DROP STORAGE';

                   --Insert Source data
                   INSERT /*+ APPEND*/
                         INTO  t_act_fct_finances ( event_dt
                                                  , country_geo_id
                                                  , program_id
                                                  , period_id_dl
                                                  , fin_source_id
                                                  , fin_amount
                                                  , gdp
                                                  , bud_deficit )
         SELECT event_dt
              , country_geo_id
              , program_id
              , NVL ( period_id, -99 ) AS period_id_dl
              , fin_source_id
              , fin_amount
              , gdp
              , bud_deficit
           FROM (  SELECT event_dt
                        , country_geo_id
                        , program_id
                        , fin_source_id
                        , SUM ( fin_amount ) AS fin_amount
                        , SUM ( gdp ) AS gdp
                        , SUM ( bud_deficit ) AS bud_deficit
                     FROM (SELECT /*+ parallel(gdp 8)*/
                                 event_dt
                                , NVL ( country_geo_id, -98 ) AS country_geo_id
                                , -99 AS program_id
                                , -99 AS fin_source_id
                                , 0 AS fin_amount
                                , gdp
                                , 0 AS bud_deficit
                             FROM dw.t_gdp_countries gdp
                           UNION ALL
                           SELECT /*+ parallel(fcntr 8)*/
                                 event_dt
                                , NVL ( country_geo_id, -98 ) AS country_geo_id
                                , -99 AS program_id
                                , -99 AS fin_source_id
                                , 0 AS fin_amount
                                , 0 AS gdp
                                , DECODE ( fin_group_id,  '1', bud_amount,  '2', -bud_amount ) AS bud_deficit
                             FROM dw.t_finance_countries fcntr
                           UNION ALL
                           SELECT /*+ parallel(ff 8)*/
                                 event_dt
                                , NVL ( country_geo_id, -98 ) AS country_geo_id
                                , NVL ( program_id, -98 ) AS program_id
                                , NVL ( fin_source_id, -98 ) AS fin_source_id
                                , fin_amount
                                , 0 AS gdp
                                , 0 AS bud_deficit
                             FROM dw.t_fact_financing ff)
                 GROUP BY event_dt
                        , country_geo_id
                        , program_id
                        , fin_source_id)
              , dw.t_gen_periods
          WHERE CASE WHEN NVL ( gdp, 0 ) = 0 THEN NULL ELSE bud_deficit * 100 / gdp END >= value_from_num(+)
            AND CASE WHEN NVL ( gdp, 0 ) = 0 THEN NULL ELSE bud_deficit * 100 / gdp END <= value_to_num(+)
            AND event_dt >= p_date_from AND event_dt <= p_date_to;

      --Commit Results
      COMMIT;
   END load_act_fct_fin_countries;
END pkg_etl_act_fct_finances_dw_cl;
/