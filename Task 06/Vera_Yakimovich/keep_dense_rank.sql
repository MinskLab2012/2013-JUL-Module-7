-- Product price grouth
SELECT year, prod_name, MIN(unit_cost) KEEP (DENSE_RANK FIRST ORDER BY time_id) as start_price,
MAX(unit_cost) KEEP (DENSE_RANK LAST ORDER BY time_id) as end_price
FROM (
SELECT prod_name, time_id, TO_CHAR(TRUNC(time_id, 'year'),'YYYY')as year, unit_cost
FROM costs INNER JOIN products ON products.prod_id = costs.prod_id
WHERE PROD_CATEGORY = 'Electronics'
)
GROUP BY year, prod_name;