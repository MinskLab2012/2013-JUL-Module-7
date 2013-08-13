/* Formatted on 8/12/2013 8:52:49 PM (QP5 v5.139.911.3011) */
CREATE TABLE fct_trans_monthly_2008
(
   event_dt       DATE NOT NULL
 , ship_id        NUMBER ( 20 )
 , arr_time_dt    DATE
 , arr_port_id    NUMBER ( 20 )
 , dep_time_dt    DATE
 , dep_port_id    NUMBER ( 20 )
 , company_id     NUMBER ( 20 )
 , product_id     NUMBER ( 20 )
 , insurance_id   NUMBER ( 20 )
 , pct_goods      NUMBER ( 8, 2 )
 , income         NUMBER ( 10, 2 )
 , amount_tot     NUMBER ( 10 )
 , last_insert_dt DATE
 , last_update_dt DATE
);