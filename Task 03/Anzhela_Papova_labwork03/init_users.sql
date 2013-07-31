--DROP USER sb_mbackup;
--
--DROP USER SA_FINANCE;
--
--DROP USER DW_CL;
--
--DROP USER DW;
--
--DROP USER SAL_DW_CL;
--
--DROP USER SAL_CL;
--
--DROP USER SAL;

--==============================================================
-- User: sb_mbackup
--==============================================================
CREATE USER sb_mbackup
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_dw_cl;
GRANT CONNECT,RESOURCE TO sb_mbackup;
ALTER USER sb_mbackup  QUOTA UNLIMITED ON ts_dw_cl;
GRANT SELECT ON  u_dw_references.t_geo_object_links TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_countries TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_regions TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_parts TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_systems TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_group_systems TO sb_mbackup;
GRANT SELECT ON  u_dw_references.cu_cntr_groups TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_sub_groups TO sb_mbackup;

--==============================================================
-- User: SA_FINANCE
--==============================================================
CREATE USER SA_FINANCE
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_sa_finance_data_01;

GRANT CONNECT,RESOURCE TO SA_FINANCE;
ALTER USER sa_finance  QUOTA UNLIMITED ON ts_sa_finance_data_01;
GRANT SELECT ON hr.employees TO sa_finance;
GRANT SELECT ON hr.departments TO sa_finance;
GRANT SELECT ON hr.countries TO sa_finance;
GRANT SELECT ON hr.regions TO sa_finance;

--==============================================================
-- User: DW_CL
--==============================================================
CREATE USER DW_CL
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_dw_cl;

GRANT CONNECT,RESOURCE TO DW_CL;

--==============================================================
-- User: DW
--==============================================================
CREATE USER DW
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO DW;

--==============================================================
-- User: SAL_DW_CL
--==============================================================
CREATE USER SAL_DW_CL
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_sal_dw_cl;

GRANT CONNECT,RESOURCE, CREATE VIEW TO SAL_DW_CL;

--==============================================================
-- User: SAL_CL
--==============================================================
CREATE USER SAL_CL
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_sal_sl;
GRANT CONNECT,RESOURCE TO SAL_CL;

--==============================================================
-- User: SAL
--==============================================================
CREATE USER SAL
  IDENTIFIED BY "finance"
   DEFAULT TABLESPACE ts_sal_data_01;
GRANT CONNECT,RESOURCE TO SAL;


