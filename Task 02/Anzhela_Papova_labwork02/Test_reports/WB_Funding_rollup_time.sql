/* Formatted on 30.07.2013 19:37:04 (QP5 v5.139.911.3011) */
  SELECT DECODE ( GROUPING ( TRUNC ( tmp.event_dt
                                   , 'yyyy' ) )
                , 1, 'All years'
                , TRUNC ( tmp.event_dt
                        , 'yyyy' ) )
            AS year_id
       , DECODE ( GROUPING ( TRUNC ( tmp.event_dt
                                   , 'Q' ) )
                , 1, 'All quarters'
                , TRUNC ( tmp.event_dt
                        , 'Q' ) )
            AS quarter_id
       , DECODE ( GROUPING ( TRUNC ( tmp.event_dt
                                   , 'mm' ) )
                , 1, 'All months'
                , TRUNC ( tmp.event_dt
                        , 'mm' ) )
            AS month_id
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
GROUP BY ROLLUP ( TRUNC ( tmp.event_dt
                        , 'yyyy' ), TRUNC ( tmp.event_dt
                                          , 'Q' ), TRUNC ( tmp.event_dt
                                                         , 'mm' ) )
ORDER BY 1
       , 2
       , 3