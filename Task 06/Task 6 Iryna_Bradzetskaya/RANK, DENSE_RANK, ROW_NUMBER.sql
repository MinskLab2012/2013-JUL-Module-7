------------------------------------------------------------------
--DENSE_RANK
------------------------------------------------------------------

SELECT *
    FROM (SELECT "YEAR"
               , "Quarter"
               , cust_rec_cntr
               , count_tr
               , DENSE_RANK ( ) OVER (PARTITION BY "YEAR", "Quarter" ORDER BY count_tr) RANK
            FROM (  SELECT TO_CHAR ( TRUNC ( event_dt
                                           , 'YYYY' )
                                   , 'YYYY' )
                              "YEAR"
                         , TO_CHAR ( TRUNC ( event_dt
                                           , 'Q' )
                                   , 'Q' )
                              "Quarter"
                         , cust_rec_cntr
                         , COUNT ( transaction_id ) count_tr
                      FROM u_dw_ext_references.tmp_transactions_info
                     WHERE operation_name = 'DEPOSIT'
                       AND TO_CHAR ( TRUNC ( event_dt
                                           , 'YYYY' )
                                   , 'YYYY' ) IN ('2007', '2008')
                  GROUP BY cust_rec_cntr
                         , TRUNC ( event_dt
                                 , 'YYYY' )
                         , TRUNC ( event_dt
                                 , 'Q' )))
   WHERE RANK < 4
ORDER BY 1
       , 2
       , RANK;




------------------------------------------------------------------
--ROW_NUMBER
------------------------------------------------------------------


    SELECT "YEAR"
       , "Quarter"
       , cust_rec_cntr
       , TO_CHAR ( payment_sum ) || '$' payment_sum
    FROM (SELECT "YEAR"
               , "Quarter"
               , cust_rec_cntr
               , payment_sum
               , ROW_NUMBER ( ) OVER (PARTITION BY "YEAR", "Quarter" ORDER BY payment_sum) RANK
            FROM (  SELECT TO_CHAR ( TRUNC ( event_dt
                                           , 'YYYY' )
                                   , 'YYYY' )
                              "YEAR"
                         , TO_CHAR ( TRUNC ( event_dt
                                           , 'Q' )
                                   , 'Q' )
                              "Quarter"
                         , cust_rec_cntr
                         , SUM ( payment_sum ) payment_sum
                      FROM u_dw_ext_references.tmp_transactions_info
                     WHERE operation_name = 'DEPOSIT'
                       AND TO_CHAR ( TRUNC ( event_dt
                                           , 'YYYY' )
                                   , 'YYYY' ) IN ('2007', '2008')
                  GROUP BY cust_rec_cntr
                         , TRUNC ( event_dt
                                 , 'YYYY' )
                         , TRUNC ( event_dt
                                 , 'Q' )))
   WHERE RANK = 1
ORDER BY 1
       , 2
       , RANK;




------------------------------------------------------------------
--RANK
------------------------------------------------------------------

SELECT *
    FROM (SELECT "YEAR"
               , "Quarter"
               , cust_rec_cntr
               , count_tr
               , RANK ( ) OVER (ORDER BY count_tr) RANK
            FROM (  SELECT TO_CHAR ( TRUNC ( event_dt
                                           , 'YYYY' )
                                   , 'YYYY' )
                              "YEAR"
                         , TO_CHAR ( TRUNC ( event_dt
                                           , 'Q' )
                                   , 'Q' )
                              "Quarter"
                         , cust_rec_cntr
                         , COUNT ( transaction_id ) count_tr
                      FROM u_dw_ext_references.tmp_transactions_info
                     WHERE operation_name = 'DEPOSIT'
                       AND TO_CHAR ( TRUNC ( event_dt
                                           , 'YYYY' )
                                   , 'YYYY' ) IN ('2002', '2001')
                  GROUP BY cust_rec_cntr
                         , TRUNC ( event_dt
                                 , 'YYYY' )
                         , TRUNC ( event_dt
                                 , 'Q' )))
   WHERE RANK < 10
ORDER BY RANK;
