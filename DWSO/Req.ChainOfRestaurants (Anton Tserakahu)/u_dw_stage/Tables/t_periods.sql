
DROP TABLE t_periods CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_periods
--==============================================================

CREATE TABLE u_dw_stage.t_periods
(
   period_id      VARCHAR2 ( 150 ) NOT NULL
 , period_desc    VARCHAR2 ( 500 ) NOT NULL
 , period_code    VARCHAR2 ( 50 ) NOT NULL
 , period_type_id NUMBER ( 10 ) NOT NULL
 , start_dt       DATE NOT NULL
 , end_dt         DATE NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;

ALTER TABLE u_dw_stage.t_periods
   ADD CONSTRAINT pk_t_periods PRIMARY KEY (period_id) USING INDEX  TABLESPACE ts_dw_stage_idx_01;

CREATE INDEX idx_restaurant_types_name
   ON t_restaurant_types ( restaurant_type_name )
   TABLESPACE ts_dw_stage_idx_01;