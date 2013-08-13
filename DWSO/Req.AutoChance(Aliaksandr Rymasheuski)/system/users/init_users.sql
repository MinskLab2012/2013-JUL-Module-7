--drop user sb_mbackup;

--==============================================================
-- User: sb_mbackup
--==============================================================
CREATE USER sb_mbackup
IDENTIFIED BY "123456"
DEFAULT TABLESPACE ts_sb_m;

GRANT CONNECT,RESOURCE TO sb_mbackup;
GRANT SELECT ANY TABLE TO sb_mbackup;




--drop user u_sa_data;

--==============================================================
-- User: u_sa_data
--==============================================================
CREATE USER u_sa_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_data_01;

GRANT CONNECT,RESOURCE TO u_sa_data;
ALTER USER u_sa_data QUOTA UNLIMITED ON ts_sa_data_01;
GRANT SELECT ANY TABLE TO u_sa_data;


--drop user u_dw;

--==============================================================
-- User: u_dw
--==============================================================
CREATE USER u_dw
  IDENTIFIED BY "%PWD%"
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
  IDENTIFIED BY "%PWD%";

GRANT CONNECT,RESOURCE TO u_dw_cleansing;

ALTER USER u_dw_cleansing QUOTA UNLIMITED ON ts_references_data_01;
GRANT SELECT ANY TABLE TO u_dw_cleansing;


 
 --drop user u_str_data;

--==============================================================
-- User: u_str_data
--==============================================================
CREATE USER u_str_data
  IDENTIFIED BY "%PWD%" ;

GRANT CONNECT,RESOURCE TO u_str_data;
ALTER USER u_str_data DEFAULT TABLESPACE  ts_str_data;
ALTER USER u_str_data QUOTA UNLIMITED ON ts_str_data;
ALTER USER u_str_data QUOTA UNLIMITED ON ts_customers_part_1;
ALTER USER u_str_data QUOTA UNLIMITED ON ts_customers_part_2;
ALTER USER u_str_data QUOTA UNLIMITED ON ts_customers_part_3;
ALTER USER u_str_data QUOTA UNLIMITED ON ts_customers_part_4;
ALTER USER u_str_data QUOTA UNLIMITED ON ts_sal_cl;
GRANT SELECT ANY TABLE TO u_str_data;
GRANT CREATE VIEW TO u_str_data;



--drop user u_sal_cl;

--==============================================================
-- User: u_sal_cl
--==============================================================
 CREATE USER u_sal_cl
  IDENTIFIED BY "%PWD%"
   DEFAULT TABLESPACE ts_sal_cl;

GRANT CONNECT,RESOURCE TO u_sal_cl;

ALTER USER u_sal_cl QUOTA UNLIMITED ON ts_sal_cl;
ALTER USER u_sal_cl QUOTA UNLIMITED ON ts_str_data;
GRANT SELECT ANY TABLE TO u_sal_cl;