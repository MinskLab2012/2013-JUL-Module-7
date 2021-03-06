/* Formatted on 7/30/2013 1:31:02 PM (QP5 v5.139.911.3011) */
SELECT calendar_year
     , quarter
     , month_name
     , week_no
     , day_no_in_month
     , day_in_week
     -- deleting holiday flag from rows generated by rollup
     , DECODE ( gid
              , 0, ( CASE TRIM ( day_in_week )
                       WHEN 'Saturday' THEN 'yes'
                       WHEN 'Sunday' THEN 'yes'
                       ELSE 'no'
                    END )
              , NULL )
          AS holiday
     , amount_sold
     , cnt
  FROM (  SELECT GROUPING_ID ( TRUNC ( transaction_dt
                                     , 'YYYY' )
                             , TRUNC ( transaction_dt
                                     , 'Q' )
                             , TRUNC ( transaction_dt
                                     , 'mm' )
                             , TRUNC ( transaction_dt
                                     , 'w' )
                             , TRUNC ( transaction_dt
                                     , 'dd' ) )
                    AS gid
               , TO_CHAR ( TRUNC ( transaction_dt
                                 , 'YYYY' )
                         , 'YYYY' )
                    AS calendar_year
               , TO_CHAR ( TRUNC ( transaction_dt
                                 , 'Q' )
                         , 'Q' )
                    AS quarter
               , TO_CHAR ( TRUNC ( transaction_dt
                                 , 'mm' )
                         , 'Month' )
                    AS month_name
               , TO_CHAR ( TRUNC ( transaction_dt
                                 , 'w' )
                         , 'W' )
                    AS week_no
               , TO_CHAR ( TRUNC ( transaction_dt
                                 , 'DD' )
                         , 'DD' )
                    AS day_no_in_month
               , TO_CHAR ( TRUNC ( transaction_dt
                                 , 'DD' )
                         , 'Day' )
                    AS day_in_week
               , SUM ( cost ) AS amount_sold
               , COUNT ( transaction_id ) AS cnt
            FROM tmp_orders
        GROUP BY ROLLUP ( TRUNC ( transaction_dt
                                , 'YYYY' )
                       , TRUNC ( transaction_dt
                               , 'Q' )
                       , TRUNC ( transaction_dt
                               , 'mm' )
                       , TRUNC ( transaction_dt
                               , 'w' )
                       , ( TRUNC ( transaction_dt
                                 , 'dd' ), TRUNC ( transaction_dt
                                                 , 'dd' ) ) )
        ORDER BY 2
               , 3
               , 4
               , 5
               , 6
               , 1);