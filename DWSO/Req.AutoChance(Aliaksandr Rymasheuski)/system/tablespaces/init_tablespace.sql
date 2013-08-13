CREATE TABLESPACE ts_sb_m
DATAFILE 'db_qpt_sb_m.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;




CREATE TABLESPACE ts_sa_data_01
DATAFILE 'db_qpt_sa_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 50M
NOLOGGING
DEFAULT NOCOMPRESS
SEGMENT SPACE MANAGEMENT AUTO;







CREATE TABLESPACE ts_sal_cl
DATAFILE 'db_qpt_sal_cl.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
NOLOGGING
DEFAULT NOCOMPRESS
SEGMENT SPACE MANAGEMENT AUTO;





CREATE TABLESPACE ts_str_data
DATAFILE 'db_qpt_str_data.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;




CREATE TABLESPACE ts_customers_part_1
DATAFILE 'db_ts_customers_part_1.dat'
SIZE 30M
 AUTOEXTEND ON NEXT 20M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_customers_part_2
DATAFILE 'db_ts_customers_part_2.dat'
SIZE 30M
 AUTOEXTEND ON NEXT 20M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_customers_part_3
DATAFILE 'db_ts_customers_part_3.dat'
SIZE 30M
 AUTOEXTEND ON NEXT 20M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_customers_part_4
DATAFILE 'db_ts_customers_part_4.dat'
SIZE 30M
 AUTOEXTEND ON NEXT 20M
 SEGMENT SPACE MANAGEMENT AUTO;