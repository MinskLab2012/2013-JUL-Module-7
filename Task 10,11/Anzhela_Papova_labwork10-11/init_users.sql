/* Formatted on 10.08.2013 15:19:10 (QP5 v5.139.911.3011) */
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
GRANT SELECT ON u_dw_references.t_geo_object_links TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_countries TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_regions TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_parts TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_geo_systems TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_group_systems TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_groups TO sb_mbackup;
GRANT SELECT ON u_dw_references.cu_cntr_sub_groups TO sb_mbackup;

--==============================================================
-- User: SA_FINANCE
--==============================================================
CREATE USER sa_finance
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_sa_finance_data_01;

GRANT CONNECT,RESOURCE TO sa_finance;
ALTER USER sa_finance  QUOTA UNLIMITED ON ts_sa_finance_data_01;
GRANT SELECT ON hr.employees TO sa_finance;
GRANT SELECT ON hr.departments TO sa_finance;
GRANT SELECT ON hr.countries TO sa_finance;
GRANT SELECT ON hr.regions TO sa_finance;


--==============================================================
-- User: DW_CL
--==============================================================
CREATE USER dw_cl
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_dw_cl;

GRANT CONNECT,RESOURCE TO dw_cl;
ALTER USER dw_cl  QUOTA UNLIMITED ON ts_dw_cl;
GRANT SELECT ON sa_finance.fact_financing TO  dw_cl;
GRANT SELECT ON sa_finance.finance_countries TO  dw_cl;
GRANT SELECT ON sa_finance.finance_items TO  dw_cl;
GRANT SELECT ON sa_finance.finance_sources TO  dw_cl;
GRANT SELECT ON sa_finance.gdp_countries TO  dw_cl;
GRANT SELECT ON sa_finance.gen_periods TO  dw_cl;
GRANT SELECT ON sa_finance.programs TO  dw_cl;

GRANT SELECT ON dw.t_fin_sources TO  dw_cl;
GRANT UPDATE ON dw.t_fin_sources TO  dw_cl;
GRANT INSERT ON dw.t_fin_sources TO  dw_cl;

GRANT SELECT ON dw.t_finance_groups TO  dw_cl;
GRANT UPDATE ON dw.t_finance_groups TO  dw_cl;
GRANT INSERT ON dw.t_finance_groups TO  dw_cl;

GRANT SELECT ON dw.t_finance_items TO  dw_cl;
GRANT UPDATE ON dw.t_finance_items TO  dw_cl;
GRANT INSERT ON dw.t_finance_items TO  dw_cl;

GRANT SELECT ON dw.t_gen_periods TO  dw_cl;
GRANT UPDATE ON dw.t_gen_periods TO  dw_cl;
GRANT INSERT ON dw.t_gen_periods TO  dw_cl;
GRANT DELETE ON dw.t_gen_periods TO  dw_cl;

GRANT SELECT ON dw.t_managers TO  dw_cl;
GRANT UPDATE ON dw.t_managers TO  dw_cl;
GRANT INSERT ON dw.t_managers TO  dw_cl;

GRANT SELECT ON dw.t_programs TO  dw_cl;
GRANT UPDATE ON dw.t_programs TO  dw_cl;
GRANT INSERT ON dw.t_programs TO  dw_cl;

GRANT SELECT ON dw.t_program_manager TO  dw_cl;
GRANT UPDATE ON dw.t_program_manager TO  dw_cl;
GRANT INSERT ON dw.t_program_manager TO  dw_cl;

GRANT SELECT ON dw.t_gdp_countries TO  dw_cl;
GRANT UPDATE ON dw.t_gdp_countries TO  dw_cl;
GRANT INSERT ON dw.t_gdp_countries TO  dw_cl;
GRANT DELETE ON dw.t_gdp_countries TO  dw_cl;

GRANT SELECT ON dw.t_finance_countries TO  dw_cl;
GRANT UPDATE ON dw.t_finance_countries TO  dw_cl;
GRANT INSERT ON dw.t_finance_countries TO  dw_cl;
GRANT DELETE ON dw.t_finance_countries TO  dw_cl;

GRANT SELECT ON dw.t_fact_financing TO  dw_cl;
GRANT UPDATE ON dw.t_fact_financing TO  dw_cl;
GRANT INSERT ON dw.t_fact_financing TO  dw_cl;
GRANT DELETE ON dw.t_fact_financing TO  dw_cl;

GRANT SELECT ON dw.t_geo_object_links TO  dw_cl;
GRANT UPDATE ON dw.t_geo_object_links TO  dw_cl;
GRANT INSERT ON dw.t_geo_object_links TO  dw_cl;
GRANT DELETE ON dw.t_geo_object_links TO  dw_cl;

GRANT SELECT ON dw.lc_countries TO  dw_cl;
GRANT UPDATE ON dw.lc_countries TO  dw_cl;
GRANT INSERT ON dw.lc_countries TO  dw_cl;

GRANT SELECT ON dw.cu_countries TO  dw_cl;
GRANT UPDATE ON dw.cu_countries TO  dw_cl;
GRANT INSERT ON dw.cu_countries TO  dw_cl;

GRANT SELECT ON u_dw_ext_references.cls_cntr_grouping_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.cls_cntr2grouping_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.cls_cntr2structure_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.cls_geo_countries_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.cls_geo_countries2_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.cls_geo_structure_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.t_ext_cntr_grouping_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.t_ext_cntr2grouping_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.t_ext_cntr2structure_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.t_ext_geo_countries_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.t_ext_geo_countries2_iso3166 TO dw_cl;
GRANT SELECT ON u_dw_ext_references.t_ext_geo_structure_iso3166 TO dw_cl;

GRANT INSERT ON u_dw_ext_references.cls_lng_macro2ind_iso693 TO dw_cl;
GRANT INSERT ON u_dw_ext_references.cls_cntr_grouping_iso3166 TO dw_cl;
GRANT INSERT ON u_dw_ext_references.cls_cntr2grouping_iso3166 TO dw_cl;
GRANT INSERT ON u_dw_ext_references.cls_cntr2structure_iso3166 TO dw_cl;
GRANT INSERT ON u_dw_ext_references.cls_geo_countries_iso3166 TO dw_cl;
GRANT INSERT ON u_dw_ext_references.cls_geo_countries2_iso3166 TO dw_cl;
GRANT INSERT ON u_dw_ext_references.cls_geo_structure_iso3166 TO dw_cl;

GRANT DELETE ON u_dw_ext_references.cls_lng_macro2ind_iso693 TO dw_cl;
GRANT DELETE ON u_dw_ext_references.cls_cntr_grouping_iso3166 TO dw_cl;
GRANT DELETE ON u_dw_ext_references.cls_cntr2grouping_iso3166 TO dw_cl;
GRANT DELETE ON u_dw_ext_references.cls_cntr2structure_iso3166 TO dw_cl;
GRANT DELETE ON u_dw_ext_references.cls_geo_countries_iso3166 TO dw_cl;
GRANT DELETE ON u_dw_ext_references.cls_geo_countries2_iso3166 TO dw_cl;
GRANT DELETE ON u_dw_ext_references.cls_geo_structure_iso3166 TO dw_cl;

GRANT READ ON DIRECTORY ext_references TO dw_cl;
GRANT WRITE ON DIRECTORY ext_references TO dw_cl;

--==============================================================
-- User: DW
--==============================================================
CREATE USER dw
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO dw;
GRANT CREATE VIEW TO dw;

--==============================================================
-- User: SAL_DW_CL
--==============================================================
CREATE USER sal_dw_cl
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_sal_dw_cl;
ALTER USER sal_dw_cl  QUOTA UNLIMITED ON ts_sal_dw_cl;

GRANT CONNECT,RESOURCE, CREATE VIEW TO sal_dw_cl;

GRANT SELECT ON dw.t_fin_sources TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_finance_items TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_finance_groups TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_gen_periods TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_managers TO sal_dw_cl with grant option;
GRANT SELECT ON dw.lc_cntr_group_systems TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_cntr_group_systems TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_cntr_groups TO sal_dw_cl with grant option;
GRANT SELECT ON dw.lc_cntr_groups TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_cntr_sub_groups TO sal_dw_cl with grant option;
GRANT SELECT ON dw.lc_cntr_sub_groups TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_countries TO sal_dw_cl with grant option;
GRANT SELECT ON dw.lc_countries TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_geo_object_links TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_geo_objects TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_geo_parts TO sal_dw_cl with grant option;
GRANT SELECT ON dw.lc_geo_parts TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_geo_regions TO sal_dw_cl with grant option;
GRANT SELECT ON dw.lc_geo_regions TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_geo_systems TO sal_dw_cl with grant option;
GRANT SELECT ON dw.lc_geo_systems TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_geo_types TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_weeks TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_years TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_months TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_days TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_quarters TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_programs TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_gdp_countries TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_fact_financing TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_program_manager TO sal_dw_cl with grant option;
GRANT SELECT ON dw.t_finance_countries TO sal_dw_cl with grant option;

GRANT SELECT ON dw.w_geo_types TO sal_dw_cl;
GRANT SELECT ON dw.w_cntr_group_systems TO sal_dw_cl;
GRANT SELECT ON dw.cu_cntr_group_systems TO sal_dw_cl;
GRANT SELECT ON dw.vl_cntr_group_systems TO sal_dw_cl;
GRANT SELECT ON dw.w_cntr_groups TO sal_dw_cl;
GRANT SELECT ON dw.cu_cntr_groups TO sal_dw_cl;
GRANT SELECT ON dw.vl_cntr_groups TO sal_dw_cl;
GRANT SELECT ON dw.w_cntr_sub_groups TO sal_dw_cl;
GRANT SELECT ON dw.cu_cntr_sub_groups TO sal_dw_cl;
GRANT SELECT ON dw.vl_cntr_sub_groups TO sal_dw_cl;
GRANT SELECT ON dw.w_countries TO sal_dw_cl;
GRANT SELECT ON dw.vl_countries TO sal_dw_cl;
GRANT SELECT ON dw.cu_countries TO sal_dw_cl;
GRANT SELECT ON dw.w_geo_object_links TO sal_dw_cl;
GRANT SELECT ON dw.w_geo_objects TO sal_dw_cl;
GRANT SELECT ON dw.w_geo_parts TO sal_dw_cl;
GRANT SELECT ON dw.vl_geo_parts TO sal_dw_cl;
GRANT SELECT ON dw.cu_geo_parts TO sal_dw_cl;
GRANT SELECT ON dw.w_geo_regions TO sal_dw_cl;
GRANT SELECT ON dw.vl_geo_regions TO sal_dw_cl;
GRANT SELECT ON dw.cu_geo_regions TO sal_dw_cl;
GRANT SELECT ON dw.w_geo_systems TO sal_dw_cl;
GRANT SELECT ON dw.vl_geo_systems TO sal_dw_cl;
GRANT SELECT ON dw.cu_geo_systems TO sal_dw_cl;

--==============================================================
-- User: SAL_CL
--==============================================================
CREATE USER sal_cl
  IDENTIFIED BY "finance"
    DEFAULT TABLESPACE ts_sal_sl;
GRANT CONNECT,RESOURCE TO sal_cl;
ALTER USER sal_cl  QUOTA UNLIMITED ON ts_sal_sl;

GRANT SELECT ON sal_dw_cl.v_gen_periods TO sal_cl;
GRANT SELECT ON sal_dw_cl.v_time_mm TO sal_cl;
GRANT SELECT ON sal_dw_cl.v_fin_sources TO sal_cl;
GRANT SELECT ON sal_dw_cl.t_act_programs TO sal_cl;
GRANT SELECT ON sal_dw_cl.t_act_countries TO sal_cl;
GRANT SELECT ON sal_dw_cl.t_act_fct_finances TO sal_cl;

GRANT SELECT ON sal.dim_fin_sources TO sal_cl;
GRANT UPDATE ON sal.dim_fin_sources TO sal_cl;
GRANT INSERT ON sal.dim_fin_sources TO sal_cl;
GRANT DELETE ON sal.dim_fin_sources TO sal_cl;

GRANT SELECT ON sal.dim_gen_periods TO sal_cl;
GRANT UPDATE ON sal.dim_gen_periods TO sal_cl;
GRANT INSERT ON sal.dim_gen_periods TO sal_cl;
GRANT DELETE ON sal.dim_gen_periods TO sal_cl;

GRANT SELECT ON sal.dim_time_mm TO sal_cl;
GRANT UPDATE ON sal.dim_time_mm TO sal_cl;
GRANT INSERT ON sal.dim_time_mm TO sal_cl;
GRANT DELETE ON sal.dim_time_mm TO sal_cl;

GRANT SELECT ON sal.dim_programs_scd TO sal_cl;
GRANT UPDATE ON sal.dim_programs_scd TO sal_cl;
GRANT INSERT ON sal.dim_programs_scd TO sal_cl;
GRANT DELETE ON sal.dim_programs_scd TO sal_cl;

GRANT SELECT ON sal.dim_countries_scd TO sal_cl;
GRANT UPDATE ON sal.dim_countries_scd TO sal_cl;
GRANT INSERT ON sal.dim_countries_scd TO sal_cl;
GRANT DELETE ON sal.dim_countries_scd TO sal_cl;

GRANT SELECT ON sal.fct_wb_fin_countries_mm TO sal_cl;
GRANT UPDATE ON sal.fct_wb_fin_countries_mm TO sal_cl;
GRANT INSERT ON sal.fct_wb_fin_countries_mm TO sal_cl;
GRANT DELETE ON sal.fct_wb_fin_countries_mm TO sal_cl;

--==============================================================
-- User: SAL
--==============================================================
CREATE USER sal
  IDENTIFIED BY "finance"
   DEFAULT TABLESPACE ts_sal_data_01;
GRANT CONNECT,RESOURCE TO sal;
ALTER USER sal  QUOTA UNLIMITED ON ts_sal_data_01;
ALTER USER sal  QUOTA UNLIMITED ON ts_sal_sl;

GRANT SELECT ON sal_cl.periods_seq TO sal;
GRANT SELECT ON sal_cl.prg_surr_seq TO sal;