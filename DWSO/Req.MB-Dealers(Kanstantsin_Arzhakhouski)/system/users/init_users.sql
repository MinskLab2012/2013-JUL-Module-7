--drop user sb_mbackup;

--==============================================================
-- User: sb_mbackup
--==============================================================
CREATE USER sb_mbackup
IDENTIFIED BY "123456"
DEFAULT TABLESPACE ts_sb_m_01;

GRANT CONNECT,RESOURCE TO sb_mbackup;
GRANT SELECT ANY TABLE TO sb_mbackup;




--drop user u_sa_data;

--==============================================================
-- User: u_sa_data
--==============================================================
CREATE USER u_sa_data
  IDENTIFIED BY "123456"
    DEFAULT TABLESPACE ts_sa_data_01;

GRANT CONNECT,RESOURCE TO u_sa_data;
ALTER USER u_sa_data QUOTA UNLIMITED ON ts_sa_data_01;
GRANT SELECT ANY TABLE TO u_sa_data;


--drop user u_dw;

--==============================================================
-- User: u_dw
--==============================================================
CREATE USER u_dw
  IDENTIFIED BY "123456"
    DEFAULT TABLESPACE ts_references_data_01;

GRANT CONNECT,RESOURCE TO u_dw;
ALTER USER u_dw QUOTA UNLIMITED ON ts_references_data_01;
GRANT SELECT ANY TABLE TO u_dw;
GRANT REFERENCES ON u_dw_references.t_geo_objects TO U_DW;

--drop user u_dw_cleansing;

--==============================================================
-- User: u_dw_cleansing
--==============================================================
 
CREATE USER u_dw_cleansing
  IDENTIFIED BY "123456"
    DEFAULT TABLESPACE ts_references_data_01;
alter USER u_dw_cleansing
 
  DEFAULT TABLESPACE ts_references_data_01;

GRANT CONNECT,RESOURCE TO u_dw_cleansing;

ALTER USER u_dw_cleansing QUOTA UNLIMITED ON ts_references_data_01;
GRANT SELECT ANY TABLE TO u_dw_cleansing;