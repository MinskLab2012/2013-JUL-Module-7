/* Formatted on 12.08.2013 9:15:37 (QP5 v5.139.911.3011) */
ALTER TABLE u_stg.t_orders
 DROP PRIMARY KEY CASCADE;

DROP TABLE u_stg.t_orders CASCADE CONSTRAINTS;

CREATE TABLE u_stg.t_orders
(
   event_dt       DATE
 , order_id       NUMBER ( 20 ) NOT NULL
 , order_code     VARCHAR2 ( 20 BYTE )
 , ord_geo_id     NUMBER ( 22 )
 , customer_id    NUMBER ( 20 )
 , insert_dt      DATE
)
TABLESPACE ts_stg_data_01
PARTITION BY RANGE (event_dt)
   ( PARTITION less_2010
        VALUES LESS THAN
           (TO_DATE ( ' 2012-01-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_archive
   , PARTITION q1y2012
        VALUES LESS THAN
           (TO_DATE ( ' 2012-04-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2012
   , PARTITION q2y2012
        VALUES LESS THAN
           (TO_DATE ( ' 2012-07-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2012
   , PARTITION q3y2012
        VALUES LESS THAN
           (TO_DATE ( ' 2012-10-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2012
   , PARTITION q4y2012
        VALUES LESS THAN
           (TO_DATE ( ' 2013-01-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2012
   , PARTITION q1y2013
        VALUES LESS THAN
           (TO_DATE ( ' 2013-04-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2013
   , PARTITION q2y2013
        VALUES LESS THAN
           (TO_DATE ( ' 2013-07-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2013
   , PARTITION q3y2013
        VALUES LESS THAN
           (TO_DATE ( ' 2013-10-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2013
   , PARTITION q4y2013
        VALUES LESS THAN
           (TO_DATE ( ' 2014-01-01 00:00:00'
                    , 'SYYYY-MM-DD HH24:MI:SS'
                    , 'NLS_CALENDAR=GREGORIAN' ))
        TABLESPACE ts_inc_2013
   , PARTITION inc_others
        VALUES LESS THAN (maxvalue)
        TABLESPACE ts_inc_others );


CREATE UNIQUE INDEX u_stg.pk_t_orders
   ON u_stg.t_orders ( order_id )
   LOGGING
   TABLESPACE ts_stg_data_01;


ALTER TABLE u_stg.t_orders ADD (
  CONSTRAINT pk_t_orders
 PRIMARY KEY
 (order_id)
    USING INDEX
    TABLESPACE ts_stg_data_01
  );

GRANT INSERT, SELECT ON u_stg.t_orders TO u_dw_ext_references;