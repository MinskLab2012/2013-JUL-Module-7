/* Formatted on 8/12/2013 11:06:19 PM (QP5 v5.139.911.3011) */
CREATE VIEW transact_customers_dec_2013
AS
     SELECT DECODE ( GROUPING ( event_dt ), 1, 'GRAND TOTAL', event_dt ) AS event_dt
          , DECODE ( GROUPING ( company_name ), 1, 'ALL COMPANIES', company_name ) company_name
          , ROUND ( AVG ( pct_goods )
                  , 2 )
               pct_goods
          , SUM ( income ) income
          , COUNT ( amount_tot ) amount_tot
       FROM fct_trans_monthly fct JOIN dim_customers cust ON fct.company_id = cust.customer_id
      WHERE TRUNC ( fct.event_dt
                  , 'MM' ) = '1-JAN-2013'
   GROUP BY ROLLUP ( fct.event_dt, cust.company_name )
   ORDER BY 1;