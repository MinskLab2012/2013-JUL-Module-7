CREATE TABLESPACE ts_star_01
DATAFILE 'db_ts_star_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_fct_arch
DATAFILE 'db_ts_star_02.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

 CREATE TABLESPACE ts_fct_2013
DATAFILE 'db_ts_star_03.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 

