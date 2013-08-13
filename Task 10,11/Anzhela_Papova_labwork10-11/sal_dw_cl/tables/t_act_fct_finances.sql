/* Formatted on 12.08.2013 14:59:44 (QP5 v5.139.911.3011) */
--DROP TABLE t_act_fct_finances CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_act_fct_finances
(
   event_dt date
 , country_geo_id number
 , program_id number
 , period_id_dl number
 , fin_source_id number
 , fin_amount number
 , gdp number
 , bud_deficit number
);