
DROP TABLE t_dish_cuisines CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_dish_cuisines
--==============================================================

CREATE TABLE u_dw_stage.t_dish_cuisines
(
   dish_cuisine_id NUMBER ( 3 ) NOT NULL
 , dish_cuisine_desc VARCHAR2 ( 500 ) NOT NULL
 , dish_cuisine_name VARCHAR2 ( 50 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;

ALTER TABLE u_dw_stage.t_dish_cuisines
   ADD CONSTRAINT pk_t_dish_cuisines PRIMARY KEY (dish_cuisine_id) USING INDEX  TABLESPACE ts_dw_stage_idx_01;

CREATE INDEX idx_dish_cuisines_name
   ON t_dish_cuisines ( dish_cuisine_name )
   TABLESPACE ts_dw_stage_idx_01;