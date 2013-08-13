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
CREATE TABLESPACE sb_mbackup DATAFILE 'DATA1.dbf' SIZE 100 M LOGGING;
GRANT CREATE SESSION TO sb_mbackup;

CREATE USER sb_mbackup
  IDENTIFIED BY pass
    DEFAULT TABLESPACE sb_mbackup;
GRANT CONNECT,RESOURCE TO sb_mbackup;
ALTER USER sb_mbackup  QUOTA UNLIMITED ON ts_dw_cl;

GRANT SELECT ON u_dw_references.cu_geo_regions TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_parts TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_systems TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_group_systems TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_groups TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_sub_groups TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_countries TO sb_mbackup;
GRANT SELECT ON u_dw_references.w_geo_object_links TO sb_mbackup;
GRANT CREATE TABLE  TO sb_mbackup;

--==============================================================
-- User: U_SA_DATA
--==============================================================
CREATE USER u_sa_data
  IDENTIFIED BY pass
    DEFAULT TABLESPACE ts_sa_data_01;

GRANT CONNECT,RESOURCE TO u_sa_data;
ALTER USER u_sa_data  QUOTA UNLIMITED ON ts_sa_data_01;
GRANT SELECT ON hr.employees TO u_sa_data;
GRANT SELECT ON u_dw_references.cu_countries TO u_sa_data;

--==============================================================
-- User: U_DW_CL
--==============================================================
CREATE USER u_dw_cl
  IDENTIFIED BY pass
    DEFAULT TABLESPACE ts_dw_cl_data_01;

GRANT CONNECT,RESOURCE TO u_dw_cl;
GRANT INSERT ON u_dw.dw_operations TO u_dw_cl;
GRANT INSERT ON u_dw.dw_operation_methods TO u_dw_cl;
GRANT SELECT ON u_sa_data.tmp_currency TO u_dw_cl;
GRANT SELECT ON u_sa_data.tmp_customers TO u_dw_cl;
GRANT SELECT ON u_sa_data.tmp_methods TO u_dw_cl;
GRANT SELECT ON u_sa_data.tmp_operations TO u_dw_cl;
GRANT SELECT ON u_sa_data.tmp_tariffs TO u_dw_cl;
GRANT SELECT ON u_sa_data.tmp_transactions TO u_dw_cl;
GRANT UPDATE ON u_dw.dw_operations TO u_dw_cl;
GRANT UPDATE ON u_dw.dw_operation_methods TO u_dw_cl;
GRANT UPDATE ON u_sa_data.tmp_methods  TO u_dw_cl;
GRANT SELECT ON u_dw.dw_customers TO u_dw_cl;
GRANT DELETE ON u_dw.dw_customers TO u_dw_cl;
GRANT UPDATE ON u_dw.dw_customers TO u_dw_cl;
GRANT INSERT ON u_dw.dw_customers TO u_dw_cl;
GRANT SELECT ON u_sa_data.tmp_customers TO u_dw_cl;
GRANT SELECT ON u_dw_references.cu_countries TO u_dw_cl;
GRANT UPDATE ON u_sa_data.tmp_customers TO u_dw_cl;
GRANT SELECT  ON u_sa_data.tmp_tariffs TO u_dw_cl;
GRANT INSERT  ON u_sa_data.tmp_tariffs TO u_dw_cl;
GRANT INSERT  ON u_dw.dw_tariffs TO u_dw_cl;
GRANT UPDATE  ON u_dw.dw_tariffs TO u_dw_cl;
GRANT DELETE  ON u_dw.dw_tariffs TO u_dw_cl;
GRANT SELECT  ON u_dw.dw_tariffs TO u_dw_cl;
GRANT CREATE ANY TABLE TO u_dw_cl;
GRANT COMMENT ANY TABLE TO u_dw_cl;
GRANT INSERT ON   u_dw.dw_gen_periods TO u_dw_cl;
GRANT ON COMMIT REFRESH TO u_sa_data;
GRANT ON COMMIT REFRESH TO u_dw_cl;

GRANT SELECT ON u_sa_data.tmp_transactions_info TO u_dw_cl WITH GRANT OPTION;
GRANT CREATE MATERIALIZED VIEW TO u_dw_cl;
ALTER USER u_dw_cl QUOTA UNLIMITED ON ts_dw_cl_data_01;

CREATE materialized view MV_MONTHLY_REP_DEMAND
GRANT UPDATE ON u_sa_data.tmp_transactions_info to U_DW_CL;



--==============================================================
-- User: U_DW
--==============================================================
CREATE USER u_dw
  IDENTIFIED BY pass
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO u_dw;
GRANT CREATE TABLE  TO u_dw;
GRANT SELECT ON u_dw.dw_currency  TO u_dw;
GRANT SELECT ON u_dw.DW_TRANSACTIONS ON TO U_DW;
GRANT SELECT ON u_dw.dw_tariffs TO u_dw;
GRANT SELECT ON u_dw.dw_tariffs TO u_dw;
GRANT SELECT ON u_dw.dw_operation_methods TO u_dw;
GRANT SELECT ON u_dw.dw_customers TO u_dw;
GRANT SELECT ON u_dw.dw_customers TO u_dw;
GRANT SELECT ON u_dw.dw_currency_actions TO u_dw;
GRANT SELECT ON u_dw.dw_currency_actions TO u_dw;
ALTER USER u_dw_cl QUOTA UNLIMITED ON ts_dw_data_01;



--==============================================================
-- User: U_SAL_CL
--==============================================================
CREATE USER u_sal_cl
  IDENTIFIED BY pass
    DEFAULT TABLESPACE ts_sal_cl_data_01;

GRANT CONNECT,RESOURCE TO u_sal_cl;
GRANT CREATE TABLE  TO u_sal_cl;
GRANT SELECT ON u_dw.dw_currency  TO u_sal_cl;
GRANT SELECT ON u_dw.DW_TRANSACTIONS ON TO U_SAL_CL;
GRANT SELECT ON u_dw.dw_tariffs TO u_sal_cl;
GRANT SELECT ON u_dw.dw_tariffs TO u_sal_cl;
GRANT SELECT ON u_dw.dw_operation_methods TO u_sal_cl;
GRANT SELECT ON u_dw.dw_customers TO u_sal_cl;
GRANT SELECT ON u_dw.dw_customers TO u_sal_cl;
GRANT SELECT ON u_dw.dw_currency_actions TO u_sal_cl;
GRANT SELECT ON u_dw.dw_currency_actions TO u_sal_cl;
GRANT SELECT ON u_dw_references.cu_countries TO u_sal_cl;
GRANT INSERT ON u_sal.dim_customers  TO u_sal_cl;
GRANT SELECT ON u_sal.dim_customers  TO u_sal_cl;
GRANT UPDATE ON u_sal.dim_customers  TO u_sal_cl;
GRANT DELETE ON u_sal.dim_customers  TO u_sal_cl;
GRANT INSERT ON u_sal.dim_operations  TO u_sal_cl;
GRANT SELECT ON u_sal.dim_operations  TO u_sal_cl;
GRANT UPDATE ON u_sal.dim_operations  TO u_sal_cl;
GRANT DELETE ON u_sal.dim_operations  TO u_sal_cl;
GRANT SELECT ON u_dw.dw_operation_methods  TO u_sal_cl;
GRANT SELECT ON u_dw.dw_operations  TO u_sal_cl;
GRANT CREATE VIEW TO u_sal_cl;
GRANT UPDATE ON   u_sal.dim_locations_scd TO u_sal_cl;
GRANT SELECT ON   u_sal.dim_locations_scd TO u_sal_cl;
GRANT INSERT ON   u_sal.dim_locations_scd TO u_sal_cl;
GRANT UPDATE ON   u_sal.dim_currency_scd TO u_sal_cl;
GRANT SELECT ON   u_sal.dim_currency_scd TO u_sal_cl;
GRANT INSERT ON   u_sal.dim_currency_scd TO u_sal_cl;
GRANT SELECT ON u_dw.dw_currency_actions TO u_sal_cl;
GRANT SELECT ON u_dw.dw_currency_types TO u_sal_cl;
GRANT SELECT ON u_dw.dw_currency TO u_sal_cl;
GRANT INSERT ON   u_dw.dw_gen_periods TO u_sal_cl;
GRANT DELETE ON   u_dw.dw_gen_periods TO u_sal_cl;
GRANT SELECT ON   u_dw.dw_gen_periods  TO u_sal_cl;
GRANT SELECT ON   u_sal.dim_gen_periods TO u_sal_cl;
GRANT SELECT ON  u_dw.dw_transactions TO u_sal_cl;
GRANT INSERT ON    u_sal.dim_gen_periods TO u_sal_cl;
GRANT UPDATE ON    u_sal.dim_gen_periods TO u_sal_cl;
ALTER USER u_sal_cl QUOTA UNLIMITED ON ts_sal_cl_data_01;

GRANT ALTER ANY TABLE    TO u_sal_cl;
GRANT UPDATE ON   u_sal.fct_transactions_daily  TO u_sal_cl;
GRANT SELECT ON   u_sal.fct_transactions_daily  TO u_sal_cl;
GRANT INSERT ON   u_sal.fct_transactions_daily  TO u_sal_cl;
--==============================================================
-- User: U_SAL
--==============================================================
CREATE USER u_sal
  IDENTIFIED BY pass
    DEFAULT TABLESPACE ts_sal_data_01;

GRANT CONNECT,RESOURCE TO u_sal_cl;
GRANT CREATE TABLE  TO u_sal_cl;