/* Formatted on 7/30/2013 8:03:27 PM (QP5 v5.139.911.3011) */
  SELECT DECODE ( GROUPING ( EXTRACT ( YEAR FROM TRUNC ( event_date
                                                       , 'Year' ) ) )
                , 1, 'All Years'
                , EXTRACT ( YEAR FROM TRUNC ( event_date
                                            , 'Year' ) ) )
            "Year"
       , DECODE ( GROUPING ( CEIL ( TO_CHAR ( TRUNC ( event_date
                                                    , 'Q' )
                                            , 'mm' )
                                   / 3 ) )
                , 1, 'All Quarters'
                , CEIL ( TO_CHAR ( TRUNC ( event_date
                                         , 'Q' )
                                 , 'mm' )
                        / 3 ) )
            "Quarter"
       , DECODE ( GROUPING ( TRUNC ( event_date
                                   , 'Month' ) )
                , 1, 'All Months'
                , TRUNC ( event_date
                        , 'Month' ) )
            " Month"
       , DECODE ( GROUPING ( TRUNC ( event_date
                                   , 'DDD' ) )
                , 1, 'All Days'
                , TRUNC ( event_date
                        , 'DDD' ) )
            " Day"
       , SUM ( amount_sold ) sold
    FROM operations
GROUP BY ROLLUP ( EXTRACT ( YEAR FROM TRUNC ( event_date
                                            , 'Year' ) ), CEIL ( TO_CHAR ( TRUNC ( event_date
                                                                                 , 'Q' )
                                                                         , 'mm' )
                                                                / 3 ), TRUNC ( event_date
                                                                             , 'Month' ), TRUNC ( event_date
                                                                                                , 'DDD' ) );