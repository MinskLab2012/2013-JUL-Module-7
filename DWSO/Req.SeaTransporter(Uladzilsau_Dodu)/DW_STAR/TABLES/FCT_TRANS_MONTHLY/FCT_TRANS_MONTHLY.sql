/* Formatted on 8/11/2013 4:24:18 PM (QP5 v5.139.911.3011) */
CREATE TABLE fct_trans_monthly
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
)
PARTITION BY HASH (event_dt)
   ( PARTITION par_agg_1
        TABLESPACE dw_star_agg_2008
   , PARTITION par_agg_2
        TABLESPACE dw_star_agg_2009
   , PARTITION par_agg_3
        TABLESPACE dw_star_agg_2010
   , PARTITION par_agg_4
        TABLESPACE dw_star_agg_2011
   , PARTITION par_agg_5
        TABLESPACE dw_star_agg_2012
   , PARTITION par_agg_6
        TABLESPACE dw_star_agg_2013 )
PARALLEL;