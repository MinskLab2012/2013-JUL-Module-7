/* Formatted on 07.08.2013 18:00:36 (QP5 v5.139.911.3011) */

CREATE OR REPLACE PACKAGE BODY pkg_etl_fct_finances_dw
AS
   -- Procedure Reload Data about GDP of countries from Source table gdp_countries
   PROCEDURE load_gdp_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                  , 'mm' )
                                                                          , -12 )
                                , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                     , 'mm' ) )
   AS
   BEGIN
      --Delete old values
      DELETE FROM dw.t_gdp_countries
            WHERE event_dt BETWEEN p_date_from AND p_date_to;

      --Insert Source data
      INSERT INTO dw.t_gdp_countries ( event_dt
                                     , country_geo_id
                                     , gdp
                                     , insert_dt
                                     , update_dt )
         SELECT /*+ parallel(gdp 8) parallel (cntr 8)*/
               TO_DATE ( '01/' || gdp.month || '/' || gdp.year
                       , 'dd/mm/yyyy' )
                   AS event_dt
              , cntr.geo_id AS country_geo_id
              , gdp.gdp
              , SYSDATE
              , SYSDATE
           FROM sa_finance.gdp_countries gdp
              , dw.lc_countries cntr
          WHERE cntr.country_desc = gdp.country
            AND TO_DATE ( '01/' || gdp.month || '/' || gdp.year
                        , 'dd/mm/yyyy' ) BETWEEN p_date_from
                                             AND p_date_to;

      --Commit Results
      COMMIT;
   END load_gdp_countries;


   -- Procedure Reload Data about budget revenues and expenses of countries from Source table finance_countries
   PROCEDURE load_finance_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                  , 'mm' )
                                                                          , -12 )
                                , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                     , 'mm' ) )
   AS
   BEGIN
      --Delete old values
      DELETE FROM dw.t_finance_countries
            WHERE event_dt BETWEEN p_date_from AND p_date_to;

      --Insert Source data
      INSERT INTO dw.t_finance_countries ( event_dt, country_geo_id, fin_group_id, fin_item_id
 , bud_amount, insert_dt, update_dt)
         SELECT /*+ parallel(fcntr 8) parallel (cntr 8)*/
               TO_DATE ( '01/' || fcntr.month || '/' || fcntr.year
                       , 'dd/mm/yyyy' )
                   AS event_dt
              , cntr.geo_id AS country_geo_id
              , fgr.FIN_GROUP_ID
              , fit.FIN_ITEM_ID
             , fcntr.amount
              , SYSDATE
              , SYSDATE
           FROM sa_finance.finance_countries fcntr
              , dw.lc_countries cntr, DW.T_FINANCE_GROUPS fgr,
              DW.T_FINANCE_ITEMS fit
          WHERE cntr.country_desc = fcntr.country
          and fgr.FIN_GROUP_DESC = fcntr.grp
          and  fit.FIN_ITEM_code = fcntr.FIN_ITEM_ID
            AND TO_DATE ( '01/' || fcntr.month || '/' || fcntr.year
                       , 'dd/mm/yyyy' ) BETWEEN p_date_from
                                             AND p_date_to;

      --Commit Results
      COMMIT;
   END load_finance_countries;


   -- Procedure Reload Data about fact funding of countries from Source table fact_financing
   PROCEDURE load_fact_financing ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                   , 'mm' )
                                                                           , -12 )
                                 , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                      , 'mm' ) )
   AS
   BEGIN
      --Delete old values
      DELETE FROM dw.t_fact_financing
            WHERE event_dt BETWEEN p_date_from AND p_date_to;

      --Insert Source data
      INSERT INTO dw.t_fact_financing ( event_dt
                                      , country_geo_id
                                      , fin_source_id
                                      , program_id
                                      , fin_amount
                                      , loan_charge
                                      , end_date
                                      , insert_dt
                                      , update_dt )
         SELECT /*+ parallel(ff 8) parallel (cntr 8) */
               TRUNC ( ff.date_dt
                     , 'mm' )
                   AS event_dt
              , cntr.geo_id AS country_geo_id
              , fs.fin_source_id
              , prg.program_id
              , ff.amount
              , ff.loan_charge
              , ff.end_date
              , SYSDATE
              , SYSDATE
           FROM sa_finance.fact_financing ff
              , dw.lc_countries cntr
              , dw.t_fin_sources fs
              , dw.t_programs prg
          WHERE cntr.country_desc = ff.country
            AND fs.fin_source_code = ff.fin_source_id
            AND prg.program_code = ff.program_code
            AND TRUNC ( ff.date_dt
                      , 'mm' ) BETWEEN p_date_from
                                   AND p_date_to;

      --Commit Results
      COMMIT;
   END load_fact_financing;
END pkg_etl_fct_finances_dw;
/