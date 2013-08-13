/* Formatted on 13.08.2013 11:25:07 (QP5 v5.139.911.3011) */
  SELECT TRUNC ( fct.event_dt
               , 'Q' )
            AS quarter_id
       , DECODE ( GROUPING ( cntr.region_desc ), 1, 'All regions', cntr.region_desc ) AS region
       , DECODE ( GROUPING ( cntr.country_desc ), 1, 'All countries', cntr.country_desc ) AS country
       , SUM ( fct.gdp ) AS gdp
       , SUM ( fct.bud_deficit ) AS bud_deficit
       , CASE
            WHEN NVL ( SUM ( fct.gdp ), 0 ) = 0 THEN
               0
            ELSE
               ROUND ( SUM ( fct.bud_deficit ) * 100 / SUM ( fct.gdp )
                     , 2 )
         END
            AS def_level
       , SUM ( fct.fin_amount ) AS fin_amount
    FROM fct_wb_fin_countries_mm fct
       , dim_countries_scd cntr
   WHERE fct.dim_countries_surr_id = cntr.country_surr_id
GROUP BY TRUNC ( fct.event_dt
               , 'Q' )
       , ROLLUP ( cntr.region_desc, cntr.country_desc )
ORDER BY quarter_id
       , region;