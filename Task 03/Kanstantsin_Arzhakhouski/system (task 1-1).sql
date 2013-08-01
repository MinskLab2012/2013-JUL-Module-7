/* Formatted on 7/31/2013 4:11:48 PM (QP5 v5.139.911.3011) */
CREATE TABLESPACE ts_sb_mbackup
DATAFILE 'SB_MBackUp_data_01.dat'
SIZE 20M
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;

 CREATE USER sb_mbackup
  IDENTIFIED BY "SB"
    DEFAULT TABLESPACE ts_sb_mbackup;

GRANT CONNECT,RESOURCE TO sb_mbackup;
GRANT SELECT  ANY TABLE TO sb_mbackup;
ALTER USER sb_mbackup QUOTA UNLIMITED ON ts_sb_mbackup;