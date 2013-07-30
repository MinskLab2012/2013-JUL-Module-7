  SELECT DECODE ( GROUPING_ID ( TRUNC ( event_dt
                                      , 'Year' )
                              , TRUNC ( event_dt
                                      , 'Q' )
                              , TRUNC ( event_dt
                                      , 'Month' )
                              , TRUNC ( event_dt
                                      , 'DDD' ) )
                , 7, 'Total for year'
                , 15, 'GRANT TOTAL'
                , TRUNC ( event_dt
                        , 'Year' ) )
            AS year
       , DECODE ( GROUPING_ID ( TRUNC ( event_dt
                                      , 'Year' )
                              , TRUNC ( event_dt
                                      , 'Q' )
                              , TRUNC ( event_dt
                                      , 'Month' )
                              , TRUNC ( event_dt
                                      , 'DDD' ) )
                , 3, 'Total for quarter'
                , TRUNC ( event_dt
                        , 'Q' ) )
            AS quarter
       , DECODE ( GROUPING_ID ( TRUNC ( event_dt
                                      , 'Year' )
                              , TRUNC ( event_dt
                                      , 'Q' )
                              , TRUNC ( event_dt
                                      , 'Month' )
                              , TRUNC ( event_dt
                                      , 'DDD' ) )
                , 1, 'Total for month'
                , TRUNC ( event_dt
                        , 'Month' ) )
            AS month
       , DECODE ( GROUPING_ID ( TRUNC ( event_dt
                                      , 'Year' )
                              , TRUNC ( event_dt
                                      , 'Q' )
                              , TRUNC ( event_dt
                                      , 'Month' )
                              , TRUNC ( event_dt
                                      , 'DDD' ) )
                , 15, ''
                , TRUNC ( event_dt
                        , 'DDD' ) )
            AS day
       , TO_CHAR ( SUM ( price - cost )
                 , '$999,999,999,999' )
            AS profit
       , COUNT ( * ) AS quantity
    FROM contracts
   WHERE cost < price
     AND EXTRACT ( YEAR FROM event_dt ) = 2013
GROUP BY ROLLUP ( TRUNC ( event_dt
                        , 'Year' ), TRUNC ( event_dt
                                          , 'Q' ), TRUNC ( event_dt
                                                         , 'Month' ), TRUNC ( event_dt
                                                                            , 'DDD' ) );