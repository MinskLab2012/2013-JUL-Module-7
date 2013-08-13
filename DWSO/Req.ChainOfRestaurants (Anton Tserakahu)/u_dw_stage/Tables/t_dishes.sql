
DROP TABLE t_dishes CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_dishes
--==============================================================

CREATE TABLE u_dw_stage.t_dishes
(
   dish_id        NUMBER ( 15 ) NOT NULL
 , dish_code      VARCHAR2 ( 15 ) NOT NULL
 , dish_name      VARCHAR2 ( 400 ) NOT NULL
 , dish_desc      VARCHAR2 ( 2000 ) NOT NULL
 , dish_weight    NUMBER ( 10, 5 ) NOT NULL
 , dish_type_id   NUMBER ( 3 ) NOT NULL
 , dish_cuisine_id NUMBER ( 3 ) NOT NULL
 , start_unit_price_dol NUMBER ( 10, 5 )
)
TABLESPACE ts_dw_stage_data_01;

ALTER TABLE u_dw_stage.t_dishes
   ADD CONSTRAINT pk_t_dishes PRIMARY KEY (dish_id) USING INDEX  TABLESPACE ts_dw_stage_idx_01;

CREATE INDEX idx_dishes_name
   ON t_dishes ( dish_name )
   TABLESPACE ts_dw_stage_idx_01;