

DROP TABLE u_dw_stage.t_dish_actions CASCADE CONSTRAINTS;

CREATE TABLE u_dw_stage.t_dish_actions
(
   action_id      NUMBER ( 25 )
 , dish_id   NUMBER ( 22 )
 , price_old NUMBER ( 10,5 )
 , price_new NUMBER ( 10,5 )
 , action_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;


ALTER TABLE u_dw_stage.t_dish_actions ADD (
  CONSTRAINT t_dish_actions_pk
 PRIMARY KEY
 (action_id));