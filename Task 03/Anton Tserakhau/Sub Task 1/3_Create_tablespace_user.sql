
CREATE TABLESPACE ts_dw_sb_mbackup_01
DATAFILE 'db_qpt_dw_SB_MBackUp_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

 CREATE USER u_dw_sb_mbackup
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_sb_mbackup_01;

GRANT CONNECT,RESOURCE TO
u_dw_sb_mbackup;

ALTER USER u_dw_sb_mbackup  QUOTA  UNLIMITED ON  ts_dw_sb_mbackup_01;

GRANT SELECT ON u_dw_references.w_geo_object_links TO u_dw_sb_mbackup;
GRANT SELECT ON u_dw_references.cu_countries  TO u_dw_sb_mbackup;
GRANT SELECT ON           u_dw_references.cu_geo_regions  TO u_dw_sb_mbackup;
GRANT SELECT ON         u_dw_references.cu_geo_parts  TO u_dw_sb_mbackup;
GRANT SELECT ON        u_dw_references.cu_geo_systems  TO u_dw_sb_mbackup;
GRANT SELECT ON       u_dw_references.cu_cntr_group_systems  TO u_dw_sb_mbackup;
GRANT SELECT ON      u_dw_references.cu_cntr_groups  TO u_dw_sb_mbackup;
GRANT SELECT ON      u_dw_references.cu_cntr_sub_groups  TO u_dw_sb_mbackup;