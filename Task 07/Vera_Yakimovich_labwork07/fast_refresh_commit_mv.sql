/* Formatted on 13.08.2013 5:37:22 (QP5 v5.139.911.3011) */
--DROP MATERIALIZED VIEW LOG ON u_stg.t_orders;
CREATE MATERIALIZED VIEW LOG ON u_stg.t_orders
WITH ROWID, SEQUENCE (event_dt, order_id )

INCLUDING NEW VALUES;

--DROP MATERIALIZED VIEW last_orders;
CREATE MATERIALIZED VIEW last_orders
TABLESPACE ts_stg_data_01
PARALLEL 4
BUILD IMMEDIATE
REFRESH COMPLETE ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT event_dt, COUNT(DISTINCT order_id) AS cnt
       FROM u_stg.t_orders
   WHERE event_dt >= TO_DATE ('01/06/2013','dd/mm/yyyy')
   GROUP BY event_dt;
--

--UPDATE t_orders
--   SET event_dt     =
--          TO_DATE ( '02/06/2013'
--                  , 'dd/mm/yyyy' )
-- WHERE TRUNC ( event_dt ) = TO_DATE ( '07/06/2013'
--                                    , 'dd/mm/yyyy' );
--
--COMMIT;
--
--  SELECT TRUNC ( event_dt )
--       , SUM ( cnt )
--    FROM last_orders
--GROUP BY TRUNC ( event_dt )
--ORDER BY 1;