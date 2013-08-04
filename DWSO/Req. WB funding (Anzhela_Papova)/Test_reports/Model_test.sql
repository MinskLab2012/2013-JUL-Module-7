  SELECT DECODE ( GROUPING ( country ), 1, 'All countries', country ) AS country
       , DECODE ( GROUPING ( year ), 1, 'All years', year ) AS year
       , DECODE ( GROUPING ( quarter ), 1, 'All quarters', quarter ) AS quarter
       , SUM ( gdp ) AS gdp
       , SUM ( bud_revenues ) AS bud_revenues
       , SUM ( bud_expences ) AS bud_expences
       , SUM ( bud_deficit ) AS bud_deficit
       , CASE
            WHEN NVL ( SUM ( gdp ), 0 ) = 0 THEN
               0
            ELSE
               ROUND ( SUM ( bud_deficit ) * 100 / SUM ( gdp )
                     , 2 )
         END
            AS bud_def_pct
       , SUM ( fin_amount ) AS fin_amount
    FROM (  SELECT country
                 , year
                 , quarter
                 , gdp
                 , bud_revenues
                 , bud_expences
                 , bud_deficit
                 , bud_def_pct
                 , fin_amount
              FROM fct_finance
          MODEL
             PARTITION BY ( country )
             DIMENSION BY ( year, quarter )
             MEASURES ( gdp, bud_revenues, bud_expences, 0 bud_deficit, 0 bud_def_pct, fin_amount )
             RULES AUTOMATIC ORDER
                ( bud_deficit [year, quarter] =
                      bud_revenues[CV ( year ), CV ( quarter )] - bud_expences[CV ( year ), CV ( quarter )],
                bud_def_pct [year, quarter] =
                      CASE
                         WHEN NVL ( gdp[CV ( year ), CV ( quarter )], 0 ) = 0 THEN
                            0
                         ELSE
                            ROUND ( bud_deficit[CV ( year ), CV ( quarter )] * 100 / gdp[CV ( year ), CV ( quarter )]
                                  , 2 )
                      END )
          ORDER BY country
                 , year
                 , quarter)
GROUP BY ROLLUP ( country, year, quarter )