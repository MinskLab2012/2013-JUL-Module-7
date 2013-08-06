
CREATE USER "U_DW_STAGE" 
  identified by "%PWD%"
    default tablespace ts_stage_data_01
    temporary tablespace ts_stage_temp_01
    QUOTA UNLIMITED ON ts_stage_data_01
 QUOTA UNLIMITED ON ts_stage_temp_01
 QUOTA UNLIMITED ON ts_stage_idx_01
/

GRANT CONNECT,RESOURCE TO "U_DW_STAGE"
/

grant select on u_dw_ext_references.CLS_CNTR2GROUPING_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.CLS_CNTR_GROUPING_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.CLS_GEO_COUNTRIES2_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.CLS_GEO_COUNTRIES_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_CNTR2STRUCTURE_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_CNTR_GROUPING_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_GEO_COUNTRIES2_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_GEO_STRUCTURE_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.CLS_CNTR2STRUCTURE_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.CLS_GEO_STRUCTURE_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_CNTR2GROUPING_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_GEO_COUNTRIES_ISO3166 to u_dw_stage;
grant select on u_dw_ext_references.CLS_LANGUAGES_ISO693 to u_dw_stage;
grant select on u_dw_ext_references.CLS_LNG_MACRO2IND_ISO693 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_LANGUAGES_ISO693 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_LNG_MACRO2IND_ISO693 to u_dw_stage;
grant select on u_dw_ext_references.T_EXT_DISHES to u_dw_stage;
grant select on u_dw_ext_references.CLS_DISHES to u_dw_stage;
grant select on u_dw_ext_references.TEMP_CITY_ADDR to u_dw_stage;
grant select on u_dw_ext_references.CLS_RESTAURANTS to u_dw_stage;
grant select on u_dw_ext_references.CLS_OPERATIONS to u_dw_stage;
grant select on U_DW_EXT_REFERENCES.CLS_PERIODS to U_DW_STAGE;