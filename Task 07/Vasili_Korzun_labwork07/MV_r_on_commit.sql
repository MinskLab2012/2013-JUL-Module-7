drop materialized view monthly_mv_2;
drop materialized view log on tmp_orders;

--grant on commit refresh to u_dw_ext_references; -- as  system

create materialized view log on tmp_orders
with rowid, sequence( transaction_dt
        , transaction_id
        , delivery_system_code
        , country
        , prod_name
        , cost) including new values;


-- I can't use rollup grouping with ON COMMIT clause
create materialized view monthly_mv_2 
build immediate
refresh fast on commit 
as
 SELECT  TRUNC ( transaction_dt
                         , 'dd' )
                      AS day_id
                 , prod_name
                 , delivery_system_code
                , SUM ( cost ) AS amount_sold
                 , COUNT ( transaction_id ) AS cnt
              FROM tmp_orders          
              
              group by TRUNC ( transaction_dt
                         , 'dd' )
                 , prod_name
                 , delivery_system_code        ;
