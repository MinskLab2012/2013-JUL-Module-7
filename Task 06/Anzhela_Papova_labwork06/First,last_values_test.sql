--searching first / last value of budget deficit for 5-year range  for every country

  SELECT country
       , year
       , bud_revenues
       , bud_expences
       , bud_deficit
       , FIRST_VALUE ( bud_deficit )
            OVER (PARTITION BY country ORDER BY year ASC RANGE BETWEEN 2 PRECEDING AND 2 FOLLOWING)
            AS first_val
       , LAST_VALUE ( bud_deficit )
            OVER (PARTITION BY country ORDER BY year ASC RANGE BETWEEN 2 PRECEDING AND 2 FOLLOWING)
            AS last_val
    FROM (  SELECT country
                 , TO_NUMBER ( year ) AS year
                 , SUM ( DECODE ( grp, 'R', amount, 0 ) ) AS bud_revenues
                 , SUM ( DECODE ( grp, 'E', amount, 0 ) ) AS bud_expences
                 , SUM ( DECODE ( grp,  'E', -amount,  'R', amount ) ) AS bud_deficit
              FROM finance_countries
          GROUP BY year
                 , country)
ORDER BY country
       , year