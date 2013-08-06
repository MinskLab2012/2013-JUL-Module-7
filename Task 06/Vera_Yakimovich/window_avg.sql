--Smoothing time series
SELECT month, amount_sold,
  ROUND(AVG(amount_sold) 
      OVER ( ORDER BY month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING ),-2) as mov_avg
FROM (
  SELECT TRUNC(time_id, 'month') as month, ROUND(SUM(amount_sold),-2) as amount_sold
  FROM sales INNER JOIN products ON products.prod_id = sales.prod_id
  GROUP BY TRUNC(time_id, 'month')
);