 WITH source AS (  
  SELECT TRUNC ( event_dt, 'MONTH' )
                                              AS event_dt
                                         , country_desc
                                         , product_name
                                         , sort_name
                                         , SUM ( total_price - ( price ) * set_quantity ) AS income
                                      FROM t_orders
                                     WHERE TRUNC ( event_dt
                                                 , 'MONTH' ) = TO_DATE ( '01/04/2006'
                                                                   , 'dd/mm/yyyy' )
                                       AND country_desc = 'Angola'
                                  GROUP BY TRUNC ( event_dt
                                                 , 'MONTH' )
                                         , country_desc
                                         , product_name
                                         , sort_name)
, cum_source AS ( 
SELECT rownum as row_cnt,  event_dt  , country_desc
                                         , product_name
                                         , sort_name, income,  prod_pct FROM (
SELECT event_dt  , country_desc
                                         , product_name
                                         , sort_name, income,  ROUND (100*income/tot_income, 3) as prod_pct FROM source   CROSS JOIN (SELECT sum(income) as tot_income FROM source)  sou                                  
      order by prod_pct  DESC)
)
SELECT event_dt  , country_desc, CASE
            WHEN GROUPING_ID ( prod_group
                             , product_name
                             , sort_name ) = 7 THEN
               'GRAND TOTAL'
            ELSE
               DECODE ( GROUPING ( product_name ), 1, 'TOTAL IN GROUP ' || prod_group, prod_group )
         END
            AS prod_group
       , product_name
       , sort_name
       , SUM ( income ) AS income
       , SUM ( prod_pct ) AS tot_inc_pct
 FROM (
SELECT event_dt  , country_desc, CASE
                    WHEN cum_pct  <= 80 THEN 'A'
                    WHEN cum_pct <= 95 THEN 'B'
                    ELSE 'C'
                 END
                    AS prod_group ,   product_name
                                         , sort_name, income,  prod_pct FROM( 
SELECT row_cnt, event_dt  , country_desc
                                         , product_name
                                         , sort_name, income,  prod_pct, (SELECT sum(prod_pct) FROM cum_source WHERE row_cnt<=cs.row_cnt) as cum_pct                                         
                                         FROM cum_source cs) )
GROUP BY ROLLUP ( prod_group , ( event_dt  , country_desc,product_name, sort_name ) ) ;
 