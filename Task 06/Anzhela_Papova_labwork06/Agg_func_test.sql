--searching max level of gdp of every country, min level of gdp of every country, average level of gdp all countries of every  year

  SELECT /*+ parallel(gdp_q 8)*/ country
       , year
       , quarter
       , gdp
       , SUM ( gdp ) OVER (PARTITION BY country, year ORDER BY quarter) run_total_qty
       , MAX ( gdp ) OVER (PARTITION BY country) max_gdp
       , MIN ( gdp ) OVER (PARTITION BY country) min_gdp
       , ROUND ( AVG ( gdp ) OVER (PARTITION BY year) ) avg_year_gdp
    FROM (  SELECT country
                 , year
                 , 'Q'
                   || TO_CHAR ( TO_DATE ( '01/' || month || '/' || year
                                        , 'dd/mm/yyyy' )
                              , 'Q' )
                      AS quarter
                 , SUM ( gdp ) AS gdp
              FROM gdp_countries
          GROUP BY year
                 , 'Q'
                   || TO_CHAR ( TO_DATE ( '01/' || month || '/' || year
                                        , 'dd/mm/yyyy' )
                              , 'Q' )
                 , country
         ) gdp_q
ORDER BY country
       , year
       , quarter