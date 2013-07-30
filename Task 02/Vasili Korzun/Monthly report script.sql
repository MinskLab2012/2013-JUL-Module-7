/* Formatted on 7/30/2013 11:58:08 AM (QP5 v5.139.911.3011) */

 -- In Oracle BI Publisher module we've studied how to NOT to write such queries.
 -- Totals and subtotals should be added in Template, not in Data model or DWH.

  SELECT gid
       , DECODE ( gid, 3, 'Grand total', 1, 'Total by '||month_id, month_id ) AS event_date
       , DECODE ( gid, 2, 'Total for ' || payment_system_desc, payment_system_desc ) AS payment_system_desc
       , amount_sold
       , cnt
    FROM (        SELECT GROUPING_ID (  TRUNC ( transaction_dt
                         , 'mm' ), payment_system_desc )
                      AS gid
                 , TRUNC ( transaction_dt
                         , 'mm' )
                      AS month_id
                 , payment_system_desc
                 , SUM ( cost ) AS amount_sold
                 , COUNT ( transaction_id ) AS cnt
              FROM tmp_orders
             WHERE EXTRACT ( YEAR FROM transaction_dt ) = :p_year
               AND country = :P_COUNTRY
          GROUP BY  CUBE (TRUNC ( transaction_dt
                                  , 'mm' )
                 ,  payment_system_desc )
order by month_id, gid, payment_system_desc);
       
       
       
       
       
       
       
