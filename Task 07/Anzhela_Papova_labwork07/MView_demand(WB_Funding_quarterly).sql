/* Formatted on 06.08.2013 13:43:37 (QP5 v5.139.911.3011) */
ALTER SESSION SET query_rewrite_enabled = TRUE;
ALTER SESSION SET query_rewrite_integrity = enforced;

CREATE MATERIALIZED VIEW MV_Funding_quarterly
BUILD IMMEDIATE
REFRESH ON DEMAND
ENABLE QUERY REWRITE
AS
  SELECT TRUNC ( tmp.event_dt
               , 'Q' )
            AS quarter_id
       , DECODE ( GROUPING ( hr.regions.region_name ), 1, 'All regions', hr.regions.region_name ) AS region
       , DECODE ( GROUPING ( tmp.country ), 1, 'All countries', tmp.country ) AS country
       , SUM ( tmp.gdp ) AS gdp
       , SUM ( tmp.bud_deficit ) AS bud_deficit
       , CASE
            WHEN NVL ( SUM ( tmp.gdp ), 0 ) = 0 THEN
               0
            ELSE
               ROUND ( SUM ( tmp.bud_deficit ) * 100 / SUM ( tmp.gdp )
                     , 2 )
         END
            AS def_level
       , SUM ( tmp.fin_amount ) AS fin_amount
    FROM (SELECT /*+ parallel(ff 8)*/
                TRUNC ( ff.date_dt
                      , 'mm' )
                    AS event_dt
               , ff.country
               , ff.amount AS fin_amount
               , 0 AS gdp
               , 0 AS bud_deficit
            FROM fact_financing ff
          UNION ALL
          SELECT /*+ parallel(gdp 8)*/
                TO_DATE ( '01/' || gdp.month || '/' || gdp.year
                        , 'dd/mm/yyyy' )
                    AS event_dt
               , gdp.country
               , 0 AS fin_amount
               , gdp.gdp AS gdp
               , 0 AS bud_deficit
            FROM gdp_countries gdp
          UNION ALL
          SELECT /*+ parallel(fcntr 8)*/
                TO_DATE ( '01/' || fcntr.month || '/' || fcntr.year
                        , 'dd/mm/yyyy' )
                    AS event_dt
               , fcntr.country
               , 0 AS fin_amount
               , 0 AS gdp
               , DECODE ( fcntr.grp,  'R', fcntr.amount,  'E', -fcntr.amount ) AS bud_deficit
            FROM finance_countries fcntr) tmp
       , hr.regions
       , hr.countries
   WHERE hr.countries.country_name = tmp.country
     AND hr.countries.region_id = hr.regions.region_id
GROUP BY TRUNC ( tmp.event_dt
               , 'Q' )
       , ROLLUP ( hr.regions.region_name, tmp.country )
ORDER BY 1
       , 2