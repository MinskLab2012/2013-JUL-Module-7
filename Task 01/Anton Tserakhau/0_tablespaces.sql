CREATE TABLESPACE ts_references_ext_temp_data_01
DATAFILE 'db_qpt_ext_references_temp_data_01.dat'
SIZE 20M
 AUTOEXTEND ON
    NEXT 20M
 SEGMENT SPACE MANAGEMENT AUTO;

 ALTER USER u_dw_ext_references QUOTA UNLIMITED ON ts_references_ext_temp_data_01;

CREATE TABLESPACE ts_references_ext_data_02
DATAFILE 'db_qpt_ext_references_data_02.dat'
SIZE 20M
 AUTOEXTEND ON
    NEXT 20M
 SEGMENT SPACE MANAGEMENT AUTO;

 ALTER USER u_dw_ext_references QUOTA UNLIMITED ON ts_references_ext_data_02;