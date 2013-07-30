/* Formatted on 7/30/2013 1:35:09 PM (QP5 v5.139.911.3011) */
  SELECT year
       , quarter
       , month
       , ROUND ( AVG ( avg_pct )
               , 2 )
            avg_pct
       , SUM ( sum_income ) sum_income
       , COUNT ( count_trans ) count_trans
    FROM (SELECT TO_CHAR ( TRUNC ( event_dt
                                 , 'Year' )
                         , 'YYYY' )
                    year
               , TO_CHAR ( TRUNC ( event_dt
                                 , 'Q' )
                         , 'Q' )
                    quarter
               , TO_CHAR ( TRUNC ( event_dt
                                 , 'Month' )
                         , 'Month' )
                    month
               , avg_pct
               , sum_income
               , count_trans
            FROM agr_trans)
   WHERE year = :year
     AND quarter = :quarter
GROUP BY year
       , quarter
       , month