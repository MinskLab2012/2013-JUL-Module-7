/* Formatted on 13.08.2013 17:00:13 (QP5 v5.139.911.3011) */
SELECT DECODE (gid,
               3, 'Grand total',
               1, 'Total in ' || month_id,
               month_id)
          AS event_date,
       DECODE (gid,
               2, 'Total for ' || payment_system_desc,
               payment_system_desc)
          AS payment_system_desc,
       amount_sold,
       cnt
  FROM    (  SELECT GROUPING_ID (TRUNC (event_dt, 'month'),
                                 payment_system_surr_id)
                       AS gid,
                    TRUNC (event_dt, 'month') AS month_id,
                    payment_system_surr_id,
                    SUM (amount_sold) AS amount_sold,
                    SUM (quantity_sold) AS cnt
               FROM fct_sales_dd
              WHERE EXTRACT (YEAR FROM event_dt) = :p_year
           GROUP BY CUBE (TRUNC (event_dt, 'month'), payment_system_surr_id)) agg
       JOIN
          dim_payment_systems_scd dps
       ON agg.payment_system_surr_id = dps.payment_system_surr_id;