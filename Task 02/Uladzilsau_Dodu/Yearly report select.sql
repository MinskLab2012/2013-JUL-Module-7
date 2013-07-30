/* Formatted on 7/30/2013 5:25:30 PM (QP5 v5.139.911.3011) */
  SELECT DECODE ( GROUPING_ID ( TO_CHAR ( TRUNC ( event_dt
                                                , 'YYYY' )
                                        , 'YYYY' )
                              , company_name )
                , 2, 'ALL YEARS '
                , 3, 'GRAND TOTAL'
                , TO_CHAR ( TRUNC ( event_dt
                                  , 'YYYY' )
                          , 'YYYY' ) )
       , DECODE ( GROUPING_ID ( TO_CHAR ( TRUNC ( event_dt
                                                , 'YYYY' )
                                        , 'YYYY' )
                              , company_name )
                , 1, 'ALL COMPANIES '
                , 3, ' '
                , company_name )
       , ROUND ( AVG ( avg_pct )
               , 2 )
            avg_pct
       , SUM ( sum_income ) sum_income
       , COUNT ( count_trans ) count_trans
    FROM agr_trans
   WHERE TO_CHAR ( TRUNC ( event_dt
                         , 'YYYY' )
                 , 'YYYY' ) = :year
GROUP BY CUBE ( TO_CHAR ( TRUNC ( event_dt
                                , 'YYYY' )
                        , 'YYYY' ), company_name );