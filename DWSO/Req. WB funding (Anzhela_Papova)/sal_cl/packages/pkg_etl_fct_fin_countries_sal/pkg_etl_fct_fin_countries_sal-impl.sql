/* Formatted on 13.08.2013 12:59:33 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_fct_fin_countries_sal
AS
   -- Procedure load Data into fact table
   PROCEDURE load_fct_fin_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                      , 'yyyy' )
                                                                              , -12 )
                                    , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                         , 'mm' ) )
   AS
      p              NUMBER;
      p1             VARCHAR2 ( 10 );
      sql_stmt       VARCHAR2 ( 300 );
   BEGIN
      p           :=
         ABS ( TO_NUMBER ( TO_CHAR ( p_date_to
                                   , 'yyyy' ) )
              - TO_NUMBER ( TO_CHAR ( p_date_from
                                    , 'yyyy' ) ) )
         + 1;


      FOR i IN 1 .. p LOOP
         p1          :=
            TO_CHAR (  TO_NUMBER ( TO_CHAR ( p_date_from
                                           , 'yyyy' ) )
                     + i
                     - 1 );
         sql_stmt    :=
            'Alter table SAL.FCT_WB_FIN_COUNTRIES_MM exchange partition Y' || p1 || ' with table tmp_fct_finances';

         --Delete old values
         EXECUTE IMMEDIATE 'Truncate table tmp_fct_finances drop storage';

         --Insert data into tmp_fct_finances
         INSERT /* +APPEND*/
               INTO tmp_fct_finances ( event_dt
                                     , dim_countries_surr_id
                                     , dim_programs_surr_id
                                     , dim_gen_periods_surr_id
                                     , dim_fin_sources_id
                                     , fin_amount
                                     , gdp
                                     , bud_deficit
                                     , ta_dim_cntr_country_geo_id
                                     , ta_dim_prg_program_id
                                     , ta_dim_prd_period_id_dl
                                     , insert_dt
                                     , update_dt )
            SELECT cls.event_dt
                          , cntr.country_surr_id
                          , prg.program_surr_id
                          , prd.period_surr_id
                          , cls.fin_source_id
                          , cls.fin_amount
                          , cls.gdp
                          , cls.bud_deficit
                          , cls.country_geo_id
                          , cls.program_id
                          , cls.period_id_dl
                          , SYSDATE
                          , SYSDATE
              FROM sal_dw_cl.t_act_fct_finances cls
                 , sal.dim_countries_scd cntr
                 , sal.dim_programs_scd prg
                 , sal.dim_gen_periods prd
             WHERE cls.country_geo_id = cntr.country_geo_id
               AND cls.event_dt BETWEEN cntr.valid_from AND cntr.valid_to
               AND cls.program_id = prg.program_id
               AND cls.event_dt BETWEEN prg.valid_from AND prg.valid_to
               AND cls.period_id_dl = prd.period_id
               AND ( prd.level_code = 'Deficit level'
                 OR  prd.level_code = 'n.a.'
                 OR  prd.level_code = 'n.d.' )
               AND TO_CHAR ( event_dt
                           , 'yyyy' ) = p1;

         --Commit Results
         COMMIT;

         --Update data in the fact table using Exchange partition
         EXECUTE IMMEDIATE sql_stmt;
      END LOOP;
   END load_fct_fin_countries;
END pkg_etl_fct_fin_countries_sal;
/