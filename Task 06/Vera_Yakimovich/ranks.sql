--Dense_rank, rank, rownum
SELECT year, prod_category, prod_name, unit_cost, 
DENSE_RANK () OVER(PARTITION BY prod_category, year ORDER BY unit_cost DESC ) as dense_rank__price,
RANK () OVER(PARTITION BY prod_category, year ORDER BY unit_cost DESC) as raank_price,
rownum
FROM (
SELECT prod_category, prod_name, TO_CHAR(TRUNC(time_id, 'year'),'YYYY')as year, ROUND(SUM(amount_sold),-4) as unit_cost
FROM sales INNER JOIN products ON products.prod_id = sales.prod_id
GROUP BY TRUNC(time_id, 'year'),prod_category, prod_name
);