
DROP TABLE t_type_periods CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_type_periods
--==============================================================

CREATE TABLE u_dw_stage.t_type_periods
(
   period_type_id NUMBER ( 10 ) NOT NULL
 , period_type_desc VARCHAR2 ( 50 ) NOT NULL
 , period_type_name VARCHAR2 ( 150 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;

ALTER TABLE u_dw_stage.t_type_periods
   ADD CONSTRAINT pk_t_type_periods PRIMARY KEY (period_type_id) USING INDEX  TABLESPACE ts_dw_stage_idx_01;

CREATE INDEX idx_type_periods_name
   ON t_type_periods ( period_type_name )
   TABLESPACE ts_dw_stage_idx_01;