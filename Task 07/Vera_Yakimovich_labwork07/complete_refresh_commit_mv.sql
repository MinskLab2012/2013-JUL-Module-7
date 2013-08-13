--drop MATERIALIZED VIEW LOG ON u_dw_ext_references.t_orders;
CREATE MATERIALIZED VIEW LOG ON u_dw_ext_references.t_orders
WITH ROWID, SEQUENCE (
event_dt           ,
order_code         ,
country_code     ,
country_desc        ,
company_code       ,
company_name        ,
comp_country_code   ,
comp_country_desc   ,
comp_status_code ,
comp_status        ,
product_code   ,
product_name   ,
sort_code  ,
sort_name     ,
measure_code ,
measure      ,
quantity     ,
price      ,
set_quantity  ,
total_price  ,
tras_id
)
INCLUDING NEW VALUES;

DROP MATERIALIZED VIEW report_orders;
CREATE MATERIALIZED VIEW report_orders
TABLESPACE ts_references_ext_data_01
PARALLEL 4
BUILD IMMEDIATE
REFRESH COMPLETE ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT  event_dt             
          , tor.country_desc
          , SUM ( tor.total_price ) AS price
          , SUM ( price * set_quantity ) AS cost
       FROM u_dw_ext_references.t_orders tor
   GROUP BY event_dt
          , country_desc;
          
          

--UPDATE t_orders SET country_desc = 'Afghanistan'CHECK'
--WHERE country_code = 'AFG';
--COMMIT;
--SELECT * FROM t_orders WHERE country_code = 'AFG';
--
--SELECT * FROM report_orders
--ORDER BY 2;