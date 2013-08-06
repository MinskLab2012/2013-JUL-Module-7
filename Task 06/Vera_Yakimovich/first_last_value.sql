-- first and last sum in last 3 months
SELECT month,amount_sold, FIRST_VALUE(amount_sold) OVER ( ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as start_sum,
 LAST_VALUE(amount_sold) OVER ( ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as end_sum
FROM (
SELECT TRUNC(time_id, 'month') as month, ROUND(SUM(amount_sold),-2) as amount_sold
FROM sales INNER JOIN products ON products.prod_id = sales.prod_id
GROUP BY TRUNC(time_id, 'month')
)
ORDER BY month;