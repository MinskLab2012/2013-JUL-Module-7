/* Formatted on 04.08.2013 16:46:04 (QP5 v5.139.911.3011) */
WITH tt --my initial pre-agregated data, I need to calculate subtotals and grand total for month and payment system
        AS (  SELECT TO_CHAR (TRUNC (transaction_dt, 'mm'), 'Month')
                        AS month_id,
                     country,
                     payment_system_desc,
                     SUM (cost) AS cc,
                    count(cost) as cnt,
                     '0' as gid
                FROM tmp_orders
               WHERE     EXTRACT (YEAR FROM transaction_dt) = :p_year
                     AND country = :p_country
                     AND payment_system_desc IN ('PayPal', 'WebMoney')
            GROUP BY TRUNC (transaction_dt, 'mm'),
                     country,
                     payment_system_desc)

SELECT decode(gid, 1, 'Total in '||month_id, month_id) as month_id, decode(gid, 2, 'Total for '||payment_system_desc, payment_system_desc) as payment_system,  cc as amount_sold, cnt
  FROM tt
MODEL
   DIMENSION BY (month_id, payment_system_desc)
   MEASURES (cc, cnt, gid)
   RULES
      (
      --calculating subtotals for month
      cc [FOR month_id IN  (SELECT month_id FROM tt), NULL] = SUM (cc)[CV (month_id), ANY],
      cnt [FOR month_id IN  (SELECT month_id FROM tt), NULL] = sum (cnt)[CV (month_id), ANY],
      gid [FOR month_id IN  (SELECT month_id FROM tt), NULL] = '1', -- I need this column to format subtotals  like 'Total ...'
      -- calculating subtotals for payment systems
      cc [NULL, FOR payment_system_desc IN    (SELECT DISTINCT payment_system_desc FROM tt)] =     SUM (cc)[ANY, CV (payment_system_desc)],
      cnt [NULL, FOR payment_system_desc IN    (SELECT DISTINCT payment_system_desc FROM tt)] =     sum (cnt)[ANY, CV (payment_system_desc)],
      gid [NULL, FOR payment_system_desc IN    (SELECT DISTINCT payment_system_desc FROM tt)] = '2',
      -- calculating grand total
      cc ['GRAND TOTAL', NULL] = SUM (cc)[ANY, ANY],
      cnt['GRAND TOTAL', NULL] = SUM (cnt)[ANY, ANY])
      order by month_id, gid, cc;