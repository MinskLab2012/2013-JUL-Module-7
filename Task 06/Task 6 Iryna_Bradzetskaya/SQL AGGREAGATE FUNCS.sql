  SELECT DISTINCT
         "YEAR"
       , "Quarter"
       , cust_rec_cntr
       , payment_sum
       , CASE
            WHEN payment_sum = min_payment_sum THEN 'minimum payments' || ' ' || "YEAR" || '-' || "Quarter" || ' Q'
            ELSE 'maximum payments' || ' ' || "YEAR" || '-' || "Quarter" || ' Q'
         END
            lv
    FROM (SELECT "YEAR"
               , "Quarter"
               , cust_rec_cntr
               , payment_sum
               , MIN ( payment_sum ) OVER (PARTITION BY "YEAR", "Quarter") min_payment_sum
               , MAX ( payment_sum ) OVER (PARTITION BY "YEAR", "Quarter") max_payment_sum
            FROM (SELECT TO_CHAR ( TRUNC ( event_dt
                                         , 'YYYY' )
                                 , 'YYYY' )
                            "YEAR"
                       , TO_CHAR ( TRUNC ( event_dt
                                         , 'Q' )
                                 , 'Q' )
                            "Quarter"
                       , cust_rec_cntr
                       , ROUND ( AVG ( payment_sum ) OVER (PARTITION BY cust_rec_cntr) ) payment_sum
                    FROM u_dw_ext_references.tmp_transactions_info
                   WHERE operation_name = 'DEPOSIT'
                     AND TO_CHAR ( TRUNC ( event_dt
                                         , 'YYYY' )
                                 , 'YYYY' ) IN ('2012')
                     AND TO_CHAR ( TRUNC ( event_dt
                                         , 'Q' )
                                 , 'Q' ) IN ('1')))
   WHERE payment_sum = min_payment_sum
      OR  payment_sum = max_payment_sum
ORDER BY 1
       , 2
       , payment_sum;
