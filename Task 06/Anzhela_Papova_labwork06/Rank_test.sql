--searching countries which have top 10 level of year funding and top 3 level of individual funding
--in descending total funding order with density amount funding (in %) in total funding

  SELECT *
    FROM (SELECT country
               , year
               , fin_amount
               , ROUND ( ( ratio_to_report ( fin_amount ) OVER () ) * 100
                       , 2 )
                    AS density
               , RANK ( ) OVER (PARTITION BY country ORDER BY fin_amount DESC) AS cntr_rank
               , DENSE_RANK ( ) OVER (PARTITION BY year ORDER BY fin_amount DESC) year_rank
               , ROW_NUMBER ( ) OVER (ORDER BY fin_amount DESC) tot_rank
            FROM (  SELECT country
                         , TO_CHAR ( date_dt
                                   , 'yyyy' )
                              AS year
                         , SUM ( amount ) AS fin_amount
                      FROM fact_financing
                  GROUP BY TO_CHAR ( date_dt
                                   , 'yyyy' )
                         , country))
   WHERE year_rank <= 10
     AND cntr_rank <= 3
ORDER BY 6