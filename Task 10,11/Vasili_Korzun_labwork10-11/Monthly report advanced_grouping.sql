/* Formatted on 04.08.2013 17:18:19 (QP5 v5.139.911.3011) */
 -- In Oracle BI Publisher module we've studied how to NOT to write such queries.
 -- Totals and subtotals should be added in Template, not in Data model or DWH.

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
  FROM (  SELECT GROUPING_ID (TRUNC (transaction_dt, 'mm'),
                              payment_system_desc)
                    AS gid,
                 TO_CHAR (TRUNC (transaction_dt, 'mm'), 'Month') AS month_id,
                 payment_system_desc,
                 SUM (cost) AS amount_sold,
                 COUNT (transaction_id) AS cnt
            FROM tmp_orders
           WHERE     EXTRACT (YEAR FROM transaction_dt) = :p_year
               --  AND country = :p_country
               --  AND payment_system_desc IN ('PayPal', 'WebMoney')
        GROUP BY CUBE (TRUNC (transaction_dt, 'mm'), payment_system_desc));