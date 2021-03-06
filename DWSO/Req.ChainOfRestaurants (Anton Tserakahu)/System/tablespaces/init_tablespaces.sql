--==============================================================

--DROP TABLESPACE ts_dw_source_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--

--DROP TABLESPACE ts_dw_cls_stage_data_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--

--DROP TABLESPACE ts_dw_stage_data_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--

--DROP TABLESPACE ts_dw_stage_idx_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--

--DROP TABLESPACE ts_dw_cls_star_data_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--

--DROP TABLESPACE ts_dw_cls_star_idx_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--

--DROP TABLESPACE ts_dw_star_data_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--

--DROP TABLESPACE ts_dw_star_idx_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--

--==============================================================

--Change parameter:Default DataBase data files location
ALTER SYSTEM SET db_create_file_dest = '/oracle/oradata/$ORACLE_UNQNAME';

CREATE TABLESPACE ts_dw_source_data_01
DATAFILE 'db_qpt_dw_source_data_01.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_cls_stage_data_01
DATAFILE 'db_qpt_dw_cls_stage_data_01.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_stage_data_01
DATAFILE 'db_qpt_dw_stage_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_stage_idx_01
DATAFILE 'db_qpt_dw_stage_idx_01.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_cls_star_data_01
DATAFILE 'db_qpt_dw_cls_star_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_cls_star_idx_01
DATAFILE 'db_qpt_dw_cls_star_idx_01.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_star_data_01
DATAFILE 'db_qpt_dw_star_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_star_idx_01
DATAFILE 'db_qpt_dw_star_idx_01.dat'
SIZE 100M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 
 --Partition
 
 CREATE TABLESPACE ts_data_month_1
DATAFILE 'db_qpt_dw_stage_part_m1.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_2
DATAFILE 'db_qpt_dw_stage_part_m2.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
 CREATE TABLESPACE ts_data_month_3
DATAFILE 'db_qpt_dw_stage_part_m3.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;

 CREATE TABLESPACE ts_data_month_4
DATAFILE 'db_qpt_dw_stage_part_m4.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_data_month_5
DATAFILE 'db_qpt_dw_stage_part_m5.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_6
DATAFILE 'db_qpt_dw_stage_part_m6.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_7
DATAFILE 'db_qpt_dw_stage_part_m7.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_8
DATAFILE 'db_qpt_dw_stage_part_m8.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_9
DATAFILE 'db_qpt_dw_stage_part_m9.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_10
DATAFILE 'db_qpt_dw_stage_part_m10.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_11
DATAFILE 'db_qpt_dw_stage_part_m11.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_data_month_12
DATAFILE 'db_qpt_dw_stage_part_m12.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;



 --Partition cls star
 
 CREATE TABLESPACE ts_cls_star_data_month_1
DATAFILE 'db_qpt_dw_cls_star_part_m1.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_2
DATAFILE 'db_qpt_dw_cls_star_part_m2.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
 CREATE TABLESPACE ts_cls_star_data_month_3
DATAFILE 'db_qpt_dw_cls_star_part_m3.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;

 CREATE TABLESPACE ts_cls_star_data_month_4
DATAFILE 'db_qpt_dw_cls_star_part_m4.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_cls_star_data_month_5
DATAFILE 'db_qpt_dw_cls_star_part_m5.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_6
DATAFILE 'db_qpt_dw_cls_star_part_m6.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_7
DATAFILE 'db_qpt_dw_cls_star_part_m7.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_8
DATAFILE 'db_qpt_dw_cls_star_part_m8.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_9
DATAFILE 'db_qpt_dw_cls_star_part_m9.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_10
DATAFILE 'db_qpt_dw_cls_star_part_m10.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_11
DATAFILE 'db_qpt_dw_cls_star_part_m11.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_cls_star_data_month_12
DATAFILE 'db_qpt_dw_cls_star_part_m12.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;


--Partition star
 
 CREATE TABLESPACE ts_star_data_month_1
DATAFILE 'db_qpt_dw_star_part_m1.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_2
DATAFILE 'db_qpt_dw_star_part_m2.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
 CREATE TABLESPACE ts_star_data_month_3
DATAFILE 'db_qpt_dw_star_part_m3.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;

 CREATE TABLESPACE ts_star_data_month_4
DATAFILE 'db_qpt_dw_star_part_m4.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_star_data_month_5
DATAFILE 'db_qpt_dw_star_part_m5.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_6
DATAFILE 'db_qpt_dw_star_part_m6.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_7
DATAFILE 'db_qpt_dw_star_part_m7.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_8
DATAFILE 'db_qpt_dw_star_part_m8.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_9
DATAFILE 'db_qpt_dw_star_part_m9.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_10
DATAFILE 'db_qpt_dw_star_part_m10.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_11
DATAFILE 'db_qpt_dw_star_part_m11.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
  
 CREATE TABLESPACE ts_star_data_month_12
DATAFILE 'db_qpt_dw_star_part_m12.dat'
SIZE 25M
 AUTOEXTEND ON NEXT 5M
 SEGMENT SPACE MANAGEMENT AUTO;
 