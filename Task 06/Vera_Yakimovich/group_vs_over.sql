--Incorrect usage of analityc
SELECT distinct year, prod_name, 
FIRST_VALUE (unit_cost)
  OVER ( PARTITION BY prod_name, year 
         ORDER BY unit_cost ROWS UNBOUNDED PRECEDING) as f_v,
LAST_VALUE (unit_cost) 
  OVER ( PARTITION BY prod_name, year 
          ORDER BY unit_cost ROWS BETWEEN UNBOUNDED PRECEDING 
                                      AND UNBOUNDED FOLLOWING) as l_v
FROM (
SELECT prod_name, time_id, 
    TO_CHAR(TRUNC(time_id, 'year'),'YYYY')as year, unit_cost
FROM costs INNER JOIN products ON products.prod_id = costs.prod_id
WHERE PROD_CATEGORY = 'Electronics'
)
ORDER BY year, prod_name;

SELECT year, prod_name, MIN(unit_cost) as f_v, MAX (unit_cost) as l_v
FROM (
SELECT prod_name, time_id, TO_CHAR(TRUNC(time_id, 'year'),'YYYY')as year, unit_cost
FROM costs INNER JOIN products ON products.prod_id = costs.prod_id
WHERE PROD_CATEGORY = 'Electronics'
)
GROUP BY year, prod_name
ORDER BY year, prod_name;