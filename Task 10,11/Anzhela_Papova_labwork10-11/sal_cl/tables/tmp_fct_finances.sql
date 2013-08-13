/* Formatted on 12.08.2013 14:59:44 (QP5 v5.139.911.3011) */
--DROP TABLE tmp_fct_finances CASCADE CONSTRAINTS PURGE;

CREATE TABLE tmp_fct_finances
(
   event_dt       DATE
 , dim_countries_surr_id NUMBER
 , dim_programs_surr_id NUMBER
 , dim_gen_periods_surr_id NUMBER
 , dim_fin_sources_id NUMBER
 , fin_amount     NUMBER
 , gdp            NUMBER
 , bud_deficit    NUMBER
 , ta_dim_cntr_country_geo_id NUMBER
 , ta_dim_prg_program_id NUMBER
 , ta_dim_prd_period_id_dl NUMBER
 , insert_dt      DATE
 , update_dt      DATE
);