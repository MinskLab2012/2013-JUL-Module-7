--==============================================================

--DROP USER u_dw_source;
--

--DROP USER u_dw_cls_stage;
--

--DROP USER u_dw_stage;
--

--DROP USER u_dw_references;
--

--DROP USER u_dw_str_cls;
--

--DROP USER u_str_data;
--

--==============================================================
-- User: u_dw_source
--==============================================================
CREATE USER u_dw_source
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_source_data_01;

GRANT CONNECT,RESOURCE TO u_dw_source;

--==============================================================
-- User: u_dw_cls_stage
--==============================================================
CREATE USER u_dw_cls_stage
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_cls_stage_data_01;

GRANT CONNECT,RESOURCE TO u_dw_cls_stage;

--==============================================================
-- User: u_dw_stage
--==============================================================
CREATE USER u_dw_stage
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_stage_data_01;

GRANT CONNECT,RESOURCE TO u_dw_stage;

--==============================================================
-- User: u_dw_cls_star
--==============================================================
CREATE USER u_dw_cls_star
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_cls_star_data_01;

GRANT CONNECT,RESOURCE, CREATE VIEW TO u_dw_cls_star;

--==============================================================
-- User: u_dw_star
--==============================================================
CREATE USER u_dw_star
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_star_data_01;

GRANT CONNECT,RESOURCE TO u_dw_star;

