CREATE TABLESPACE ts_cls_star_01
DATAFILE 'db_ts_cls_star_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE TS_CLS_FCT_MONTHLY
DATAFILE 'TS_CLS_FCT_MONTHLY.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

 CREATE TABLESPACE TS_CLS_FCT_DAILY
DATAFILE 'TS_CLS_FCT_DAILY.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 

