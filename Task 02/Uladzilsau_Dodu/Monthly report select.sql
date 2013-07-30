/* Formatted on 7/30/2013 12:41:15 PM (QP5 v5.139.911.3011) */
  SELECT DECODE ( GROUPING ( event_dt ), 1, 'GRAND TOTAL', event_dt )
       , DECODE ( GROUPING ( company_name ), 1, 'ALL COMPANIES', company_name )
       , ROUND ( AVG ( avg_pct )
               , 2 )
       , SUM ( sum_income )
       , COUNT ( count_trans )
    FROM agr_trans
   WHERE to_char(trunc(event_dt,'YYYY'),'YYYY') = :year
     AND to_char(trunc(event_dt,'Mon'),'Mon') = :month
GROUP BY ROLLUP ( event_dt, company_name )