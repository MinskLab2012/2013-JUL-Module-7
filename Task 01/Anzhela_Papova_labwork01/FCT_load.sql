/* Formatted on 29.07.2013 22:20:39 (QP5 v5.139.911.3011) */

SELECT event_dt
     , dim_countries_surr_id
     , dim_programs_surr_id
     , dim_fin_sources_id
     , gen_periods.period_id as dim_gen_def_lev_surr_id
     , fin_amount
     , gdp
     , bud_deficit
  FROM (  SELECT tmp.event_dt
               , cntr.rn AS dim_countries_surr_id
               , tmp.dim_programs_surr_id
               , tmp.dim_fin_sources_id
               , SUM ( tmp.fin_amount ) AS fin_amount
               , SUM ( tmp.gdp ) AS gdp
               , SUM ( bud_deficit ) AS bud_deficit
            FROM (SELECT /*+ parallel(ff 8)*/
                        TRUNC ( ff.date_dt
                              , 'mm' )
                            AS event_dt
                       , ff.country
                       , prg.rn AS dim_programs_surr_id
                       , ff.fin_source_id AS dim_fin_sources_id
                       , ff.amount AS fin_amount
                       , 0 AS gdp
                       , 0 AS bud_deficit
                    FROM fact_financing ff
                       , (SELECT ROWNUM AS rn
                               , program_code
                               , program_name AS program_desc
                               , manager_fn || ' ' || manager_ln AS manager_desc
                               , start_date AS valid_from
                               , end_date AS valid_to
                            FROM programs) prg
                   WHERE prg.program_code = ff.program_code
                   and ff.date_dt >= prg.valid_from
                   and ff.date_dt <= prg.valid_to
                  UNION ALL
                  SELECT /*+ parallel(gdp 8)*/
                        TO_DATE ( '01/' || gdp.month || '/' || gdp.year
                                , 'dd/mm/yyyy' )
                            AS event_dt
                       , gdp.country
                       , -99 AS dim_programs_surr_id
                       , -99 AS dim_fin_sources_id
                       , 0 AS fin_amount
                       , gdp.gdp
                       , 0 AS bud_deficit
                    FROM gdp_countries gdp
                  UNION ALL
                  SELECT /*+ parallel(fcntr 8)*/
                        TO_DATE ( '01/' || fcntr.month || '/' || fcntr.year
                                , 'dd/mm/yyyy' )
                            AS event_dt
                       , fcntr.country
                       , -99 AS dim_programs_surr_id
                       , -99 AS dim_fin_sources_id
                       , 0 AS fin_amount
                       , 0 AS gdp
                       , DECODE ( fcntr.grp,  'R', fcntr.amount,  'E', -fcntr.amount ) AS bud_deficit
                    FROM finance_countries fcntr) tmp
               , (SELECT /*+ parallel (cnt 8)*/
                        ROWNUM AS rn
                       , country
                    FROM (SELECT DISTINCT cnt.country
                            FROM (SELECT country
                                    FROM fact_financing
                                  UNION ALL
                                  SELECT country
                                    FROM gdp_countries
                                  UNION ALL
                                  SELECT country
                                    FROM finance_countries) cnt)) cntr
           WHERE tmp.country = cntr.country
        GROUP BY tmp.event_dt
               , cntr.rn
               , tmp.dim_programs_surr_id
               , tmp.dim_fin_sources_id)
     , gen_periods
 WHERE gen_periods.level_code(+) = 'Deficit level'
   AND CASE WHEN NVL ( gdp, 0 ) = 0 THEN 0 ELSE bud_deficit * 100 / gdp END >= value_from_num(+)
   AND CASE WHEN NVL ( gdp, 0 ) = 0 THEN 0 ELSE bud_deficit * 100 / gdp END <= value_to_num(+)