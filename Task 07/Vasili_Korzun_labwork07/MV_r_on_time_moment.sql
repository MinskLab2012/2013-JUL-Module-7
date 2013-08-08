drop materialized view monthly_mv_3;





-- I can't use rollup grouping with ON COMMIT clause
create materialized view monthly_mv_3 
build immediate
refresh complete on demand start with to_date(  'August 6, 2013, 2:12 PM',
    'Month dd, YYYY, HH:MI AM')
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
                             
 /*                
                 select to_date(  'August 6, 2013, 2:06 PM',
    'Month dd, YYYY, HH:MI AM'), sysdate from dual;
    
    select * from user_objects
    where object_name ='MONTHLY_MV_3';
    */