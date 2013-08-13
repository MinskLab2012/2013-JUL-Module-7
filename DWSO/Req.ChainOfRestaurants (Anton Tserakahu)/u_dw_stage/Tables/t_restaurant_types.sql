
DROP TABLE t_restaurant_types CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_restaurant_types
--==============================================================

CREATE TABLE u_dw_stage.t_restaurant_types
(
   restaurant_type_id NUMBER ( 3 ) NOT NULL
 , restaurant_type_desc VARCHAR2 ( 200 ) NOT NULL
 , restaurant_type_name VARCHAR2 ( 50 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;

ALTER TABLE u_dw_stage.t_restaurant_types
   ADD CONSTRAINT pk_t_restaurant_types PRIMARY KEY (restaurant_type_id) USING INDEX  TABLESPACE ts_dw_stage_idx_01;

CREATE INDEX idx_restaurant_types_name
   ON t_restaurant_types ( restaurant_type_name )
   TABLESPACE ts_dw_stage_idx_01;