CREATE USER u_dw_ext_references
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_references_ext_data_01;

GRANT CONNECT,RESOURCE, CREATE ANY MATERIALIZED VIEW TO u_dw_ext_references;

ALTER USER u_stg QUOTA UNLIMITED ON ts_stg_data_01;