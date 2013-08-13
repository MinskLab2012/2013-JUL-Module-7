SELECT CASE WHEN quarter = '-' THEN 'TOTAL FOR YEAR' ELSE year END year
     , CASE
          WHEN ( quarter NOT IN ('-') )
           AND ( month IN ('-') ) THEN
             'TOTAL FOR QUARTER'
          ELSE
             quarter
       END
          quarter
     , CASE
          WHEN month NOT IN ('-')
           AND ( day IN ('-') ) THEN
             'TOTAL FOR MONTH'
          ELSE
             month
       END
          month
     , day
     , count_transactions
  FROM (  SELECT DECODE ( GROUPING ( TRUNC ( event_dt
                                           , 'YYYY' ) )
                        , 1, '-'
                        , TRUNC ( event_dt
                                , 'YYYY' ) )
                    AS year
               , DECODE ( GROUPING ( TRUNC ( event_dt
                                           , 'Q' ) )
                        , 1, '-'
                        , TRUNC ( event_dt
                                , 'Q' ) )
                    AS quarter
               , DECODE ( GROUPING ( TRUNC ( event_dt
                                           , 'Month' ) )
                        , 1, '-'
                        , TRUNC ( event_dt
                                , 'Month' ) )
                    AS month
               , DECODE ( GROUPING ( TRUNC ( event_dt
                                           , 'DDD' ) )
                        , 1, '-'
                        , TRUNC ( event_dt
                                , 'DDD' ) )
                    AS day
               , COUNT ( payment_sum ) count_transactions
            FROM u_dw_ext_references.tmp_transactions_info
           WHERE tariff_type IN ('Local Transfer', 'International Transfer')
             AND EXTRACT ( YEAR FROM event_dt ) IN (2000)
        GROUP BY ROLLUP ( TRUNC ( event_dt
                                , 'YYYY' ), TRUNC ( event_dt
                                                  , 'Q' ), TRUNC ( event_dt
                                                                 , 'Month' ), TRUNC ( event_dt
                                                                                    , 'DDD' ) )
          HAVING GROUPING_ID ( TRUNC ( event_dt
                                     , 'YYYY' )
                             , TRUNC ( event_dt
                                     , 'Q' )
                             , TRUNC ( event_dt
                                     , 'Month' )
                             , TRUNC ( event_dt
                                     , 'DDD' ) ) IN (0, 1, 3, 7));