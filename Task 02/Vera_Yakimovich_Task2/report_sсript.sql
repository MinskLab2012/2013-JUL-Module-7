SELECT CASE
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
       , SUM ( tot_inc ) AS tot_inc_pct
    FROM (SELECT CASE
                    WHEN cum_tot_inc <= 80 THEN 'A'
                    WHEN cum_tot_inc <= 95 THEN 'B'
                    ELSE 'C'
                 END
                    AS prod_group
               , product_name
               , sort_name
               , income
               , tot_inc
            FROM (SELECT event_dt
                       , country_desc
                       , product_name
                       , sort_name
                       , income
                       , tot_inc
                       , SUM ( tot_inc ) OVER (ORDER BY income DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
                            AS cum_tot_inc
                    FROM (SELECT event_dt
                               , country_desc
                               , product_name
                               , sort_name
                               , income
                               , ROUND ( 1 / COUNT ( * ) OVER ()
                                       , 2 )
                                    AS tot_cnt
                               , ROUND ( 100 * income / SUM ( income ) OVER ()
                                       , 2 )
                                    AS tot_inc
                            FROM (  SELECT TRUNC ( event_dt
                                                 , 'Q' )
                                              AS event_dt
                                         , country_desc
                                         , product_name
                                         , sort_name
                                         , SUM ( total_price - ( price ) * set_quantity ) AS income
                                      FROM t_orders
                                     WHERE TRUNC ( event_dt
                                                 , 'Q' ) = TO_DATE ( '01/10/2006'
                                                                   , 'dd/mm/yyyy' )
                                       AND country_desc = (:countr)
                                  GROUP BY TRUNC ( event_dt
                                                 , 'Q' )
                                         , country_desc
                                         , product_name
                                         , sort_name))))
GROUP BY ROLLUP ( prod_group, ( product_name, sort_name ) )
ORDER BY income DESC
       , 3;