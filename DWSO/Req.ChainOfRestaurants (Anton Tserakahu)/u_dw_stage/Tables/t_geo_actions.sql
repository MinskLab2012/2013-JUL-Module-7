

DROP TABLE u_dw_stage.t_geo_actions CASCADE CONSTRAINTS;

CREATE TABLE u_dw_stage.t_geo_actions
(
   action_id      NUMBER ( 25 )
 , child_geo_id   NUMBER ( 22 )
 , link_type_id NUMBER(22,0)
 , parent_geo_id_old NUMBER ( 22 )
 , parent_geo_id_new NUMBER ( 22 )
 , action_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;


ALTER TABLE u_dw_stage.t_geo_actions ADD (
  CONSTRAINT t_geo_actions_pk
 PRIMARY KEY
 (action_id));