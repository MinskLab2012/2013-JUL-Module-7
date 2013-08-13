/* Formatted on 8/11/2013 2:59:13 PM (QP5 v5.139.911.3011) */
CREATE TABLE dim_ships
(
   ship_id        NUMBER ( 20 ) NOT NULL
 , ship_code      NUMBER ( 20 ) NOT NULL
 , ship_weight    NUMBER ( 10 )
 , ship_height    NUMBER ( 10 )
 , water_volume   NUMBER ( 10 )
 , max_cargo      NUMBER ( 10 )
 , last_insert_dt DATE
 , last_update_dt DATE
)
TABLESPACE dw_star_ships
PCTUSED 0
PCTFREE 10
INITRANS 1
MAXTRANS 255
STORAGE ( INITIAL 64 K NEXT 1 M MINEXTENTS 1 MAXEXTENTS UNLIMITED PCTINCREASE 0 BUFFER_POOL DEFAULT )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;