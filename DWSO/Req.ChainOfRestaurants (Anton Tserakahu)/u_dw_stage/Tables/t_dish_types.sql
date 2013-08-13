
DROP TABLE t_dish_types CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_dish_types
--==============================================================

CREATE TABLE u_dw_stage.t_dish_types
(
   dish_type_id   NUMBER ( 3 ) NOT NULL
 , dish_type_desc VARCHAR2 ( 500 ) NOT NULL
 , dish_type_name VARCHAR2 ( 50 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;

ALTER TABLE u_dw_stage.t_dish_types
   ADD CONSTRAINT pk_t_dish_types PRIMARY KEY (dish_type_id) USING INDEX  TABLESPACE ts_dw_stage_idx_01;

CREATE INDEX idx_dish_types_name
   ON t_dish_types ( dish_type_name )
   TABLESPACE ts_dw_stage_idx_01;