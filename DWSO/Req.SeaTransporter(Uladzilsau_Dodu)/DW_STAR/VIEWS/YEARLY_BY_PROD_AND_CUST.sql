/* Formatted on 8/12/2013 11:17:10 PM (QP5 v5.139.911.3011) */
CREATE VIEW yearly_by_product_and_cust
AS
     SELECT DECODE ( GROUPING ( TRUNC ( event_dt
                                      , 'YYYY' ) )
                   , 1, 'GRAND TOTAL'
                   , TRUNC ( event_dt
                           , 'YYYY' ) )
               AS event_dt
          , DECODE ( GROUPING ( company_name ), 1, 'ALL COMPANIES', company_name ) company_name
          , DECODE ( GROUPING ( prod_name ), 1, 'All Products', prod_name ) product_name
          , ROUND ( AVG ( pct_goods )
                  , 2 )
               pct_goods
          , SUM ( income ) income
          , COUNT ( amount_tot ) amount_tot
       FROM fct_trans_monthly fct
            JOIN dim_customers cust
               ON fct.company_id = cust.customer_id
            JOIN dim_products_scd scd
               ON fct.product_id = scd.prod_id
   GROUP BY ROLLUP ( TRUNC ( event_dt
                           , 'YYYY' ), cust.company_name, prod_name )
   ORDER BY 1;