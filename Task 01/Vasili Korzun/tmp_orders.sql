/* Formatted on 7/29/2013 3:30:37 PM (QP5 v5.139.911.3011) */
drop table tmp_orders purge;

CREATE TABLE tmp_orders
PARALLEL ( DEGREE 10 )
AS
   SELECT event_dt AS transaction_dt
        , transaction_id
        , payment_system_desc
        , payment_system_type
        , delivery_system_code
        , delivery_system_desc
        , first_name
        , last_name
        , birth_day
        , cntr_desc AS country
        , prod_name
        , cost
        , DECODE ( status_code,  1, 'sucess',  2, 'reject',  'fail' ) AS status
     FROM tmp_opers tt
        , cls_payment_systems ps
        , cls_delivery_systems ds
        , (SELECT ROWNUM AS rn
                , first_name
                , last_name
                , birth_day
                , cntr_desc
             FROM cls_customers) cc
        , cls_products prd
    WHERE tt.delivery_system_id = ds.delivery_system_id
      AND tt.payment_system_id = ps.payment_system_id
      AND tt.product_id = prd.prod_id
      AND tt.user_id = cc.rn;




select distinct trunc(transaction_dt, 'yyyy') from tmp_orders;

SELECT TRUNC ( transaction_dt
                       , 'dd' )
                    AS day_id
               , payment_system_desc
               , delivery_system_code
               , country
               , prod_name
               , SUM ( cost ) AS amount_sold
               , COUNT ( transaction_id ) AS cnt
            FROM tmp_orders
        GROUP BY TRUNC ( transaction_dt
                       , 'dd' )
               , payment_system_desc
               , delivery_system_code
               , country
               , prod_name
              --order by day_id
              ;