 WITH source AS (  
  SELECT event_dt
                                         , country_desc
                                         , DIM_PRODUCTS.PRODUCT_DESC
                                         , category_desc
                                         , SUM ( amount_sold - total_cost ) AS income
                                      FROM FCT_INCOME_PRODUCTS_MONTHLY fct
                                      INNER JOIN dim_geo ON FCT.ORD_GEO_ID = DIM_GEO.COUNTRY_GEO_ID
                                      INNER JOIN DIM_PRODUCTS ON FCT.PRODUCT_ID = DIM_PRODUCTS.PRODUCT_ID
                                   
                                     WHERE event_dt
                                                  = TO_DATE ( '01/04/2006'
                                                                   , 'dd/mm/yyyy' )
                                       AND country_desc = 'Angola'
                                  GROUP BY  event_dt
                                         , country_desc
                                         , PRODUCT_DESC
                                         , category_desc   )
, cum_source AS (
SELECT rownum as row_cnt,  event_dt  , country_desc
                                         , PRODUCT_DESC
                                         , category_desc, income,  prod_pct FROM (
SELECT event_dt  , country_desc
                                         , PRODUCT_DESC
                                         , category_desc, income,  ROUND (100*income/tot_income, 3) as prod_pct FROM source   CROSS JOIN (SELECT sum(income) as tot_income FROM source)  sou                                  
      order by prod_pct  DESC)
)
SELECT event_dt  , country_desc, CASE
            WHEN GROUPING_ID ( prod_group
                             , PRODUCT_DESC
                             , category_desc ) = 7 THEN
               'GRAND TOTAL'
            ELSE
               DECODE ( GROUPING ( PRODUCT_DESC ), 1, 'TOTAL IN GROUP ' || prod_group, prod_group )
         END
            AS prod_group
       , PRODUCT_DESC
       , category_desc
       , SUM ( income ) AS income
       , SUM ( prod_pct ) AS tot_inc_pct
 FROM (
SELECT event_dt  , country_desc, CASE
                    WHEN cum_pct  <= 80 THEN 'A'
                    WHEN cum_pct <= 95 THEN 'B'
                    ELSE 'C'
                 END
                    AS prod_group ,   PRODUCT_DESC
                                         , category_desc, income,  prod_pct FROM( 
SELECT row_cnt, event_dt  , country_desc
                                         , PRODUCT_DESC
                                         , category_desc, income,  prod_pct, (SELECT sum(prod_pct) FROM cum_source WHERE row_cnt<=cs.row_cnt) as cum_pct                                         
                                         FROM cum_source cs) )
GROUP BY ROLLUP ( prod_group , ( event_dt  , country_desc, PRODUCT_DESC, category_desc ) ) ;
 