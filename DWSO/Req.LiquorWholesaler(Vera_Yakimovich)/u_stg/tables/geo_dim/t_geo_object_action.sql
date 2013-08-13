/* Formatted on 13.08.2013 6:21:48 (QP5 v5.139.911.3011) */
ALTER TABLE u_stg.t_geo_object_actions
 DROP PRIMARY KEY CASCADE;

DROP TABLE u_stg.t_geo_object_actions CASCADE CONSTRAINTS;

CREATE TABLE u_stg.t_geo_object_actions
(
   act_id         NUMBER ( 20 ) NOT NULL
 , action_type    VARCHAR2 ( 80 BYTE )
 , geo_id         NUMBER ( 22 )
 , v_old_int      NUMBER ( 22 )
 , v_new_int      NUMBER ( 22 )
 , action_dt      DATE
)
TABLESPACE ts_stg_data_01;


CREATE UNIQUE INDEX u_stg.t_actions_pk
   ON u_stg.t_geo_object_actions ( act_id )
   LOGGING
   TABLESPACE ts_stg_data_01;


ALTER TABLE u_stg.t_geo_object_actions ADD (
  CONSTRAINT t_actions_pk
 PRIMARY KEY
 (act_id)
    USING INDEX
    TABLESPACE ts_stg_data_01
 );

GRANT INSERT, SELECT, UPDATE ON u_stg.t_geo_object_actions TO u_dw_ext_references;