/* Formatted on 08.08.2013 14:29:40 (QP5 v5.139.911.3011) */
ALTER TABLE u_dw_references.t_actions
 DROP PRIMARY KEY CASCADE;

DROP TABLE u_dw_references.t_actions CASCADE CONSTRAINTS;

CREATE TABLE u_dw_references.t_actions
(
   action_id      NUMBER ( 25 )
 , child_geo_id   NUMBER ( 22 )
 , parent_geo_id_old NUMBER ( 22 )
 , parent_geo_id_new NUMBER ( 22 )
 , action_dt      DATE
)
TABLESPACE ts_references_data_01;


CREATE UNIQUE INDEX u_dw_references.t_actions_pk
   ON u_dw_references.t_actions ( action_id )
   TABLESPACE ts_references_data_01;


ALTER TABLE u_dw_references.t_actions ADD (
  CONSTRAINT t_actions_pk
 PRIMARY KEY
 (action_id));