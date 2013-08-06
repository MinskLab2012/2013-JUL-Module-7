/* Formatted on 06.08.2013 20:12:11 (QP5 v5.139.911.3011) */
--DROP MATERIALIZED VIEW report_orders_complete;
CREATE MATERIALIZED VIEW report_orders_complete
TABLESPACE ts_references_ext_data_01
PARALLEL 4
BUILD IMMEDIATE
REFRESH COMPLETE
ENABLE QUERY REWRITE
AS
SELECT TO_CHAR ( TRUNC ( event_dt
                            , 'year' ) , 'YYYY')
               AS ord_year
          , TO_CHAR ( TRUNC ( event_dt
                            , 'q' )
                    , 'Q' )
               AS ord_q
          , TO_CHAR ( TRUNC ( event_dt
                            , 'month' )
                    , 'MM' )
               AS ord_mon
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


BEGIN
   dbms_mview.refresh ( 'report_orders_complete'
                      , 'c' );
END;