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


