--DROP MATERIALIZED VIEW report_orders_refresh;
CREATE MATERIALIZED VIEW report_orders_refresh
TABLESPACE ts_references_ext_data_01
PARALLEL 4
BUILD IMMEDIATE
REFRESH FAST NEXT TRUNC(sysdate) +7
ENABLE QUERY REWRITE
AS
SELECT  TRUNC ( event_dt
                            , 'year' ) AS event_year

          , TRUNC ( event_dt
                            , 'q' )
                 AS event_q

          ,  TRUNC ( event_dt
                            , 'month' )

               AS event_month
          , tor.country_desc
          , SUM ( tor.total_price ) AS price
          , SUM ( price * set_quantity ) AS cost
       FROM u_dw_ext_references.t_orders tor
   GROUP BY TRUNC ( event_dt
                  , 'year' )
          , TRUNC ( event_dt
                  , 'q' )
          , TRUNC ( event_dt
                  , 'month' )
          , country_desc;
          
alter session set query_rewrite_enabled = true;
alter session set query_rewrite_integrity = enforced;