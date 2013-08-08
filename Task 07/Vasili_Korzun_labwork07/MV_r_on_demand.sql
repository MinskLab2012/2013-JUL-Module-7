/* Formatted on 8/6/2013 12:40:31 PM (QP5 v5.139.911.3011) */
-- grant create materialized view to u_dw_ext_references; --run as SYSTEM

drop materialized view monthly_mv_1;
CREATE MATERIALIZED VIEW monthly_mv_1 
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND 
AS
 SELECT DECODE (gid,
               3, 'Grand total',
               1, 'Total in ' || month_id,
               month_id)
          AS event_date,
       DECODE (gid,
               2, 'Total for ' || payment_system_desc,
               payment_system_desc)
          AS payment_system_desc,
       amount_sold,
       cnt
  FROM (  SELECT GROUPING_ID (TRUNC (transaction_dt, 'mm'),
                              payment_system_desc)
                    AS gid,
                 TO_CHAR (TRUNC (transaction_dt, 'mm'), 'Month') AS month_id,
                 payment_system_desc,
                 SUM (cost) AS amount_sold,
                 COUNT (transaction_id) AS cnt
            FROM tmp_orders
          WHERE     trunc(transaction_dt, 'yyyy') = trunc(sysdatem 'yyyy')  -- materialized view for current year
        GROUP BY CUBE (TRUNC (transaction_dt, 'mm'), payment_system_desc));

/*
Using group by clause allows me only to REFRESH COMPLETE
*/
BEGIN
   dbms_mview.refresh ( 'monthly_mv_1' , 'a' );
END;