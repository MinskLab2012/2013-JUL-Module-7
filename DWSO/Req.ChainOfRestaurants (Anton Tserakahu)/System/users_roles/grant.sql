
ALTER USER u_dw_source QUOTA UNLIMITED ON ts_dw_source_data_01;

ALTER USER u_dw_cls_stage QUOTA UNLIMITED ON ts_dw_cls_stage_data_01;

GRANT SELECT ON u_dw_source.t_ext_geo_countries_iso3166 TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.t_ext_geo_countries2_iso3166 TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.t_ext_geo_structure_iso3166 TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.t_ext_cntr2structure_iso3166 TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.t_ext_cntr_grouping_iso3166 TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.t_ext_cntr2grouping_iso3166 TO u_dw_cls_stage;

GRANT SELECT ON u_dw_source.temp_restaurants TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.t_ext_dishes TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.temp_operations TO u_dw_cls_stage;
GRANT SELECT ON u_dw_source.temp_periods TO u_dw_cls_stage;


ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_dw_stage_data_01;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_dw_stage_idx_01;


ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_1;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_2;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_3;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_4;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_5;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_6;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_7;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_8;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_9;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_10;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_11;
ALTER USER u_dw_stage QUOTA UNLIMITED ON ts_data_month_12;


--Select 'GRANT SELECT ON u_dw_cls_stage.' || table_name || ' TO u_dw_stage;' from DBA_TABLES where owner='U_DW_CLS_STAGE';

GRANT SELECT ON u_dw_cls_stage.CLS_CNTR2GROUPING_ISO3166 TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_CNTR2STRUCTURE_ISO3166 TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_CNTR_GROUPING_ISO3166 TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_GEO_COUNTRIES2_ISO3166 TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_GEO_COUNTRIES_ISO3166 TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_GEO_STRUCTURE_ISO3166 TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_DISHES TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_OPERATIONS TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_RESTAURANTS TO u_dw_stage;
GRANT SELECT ON u_dw_cls_stage.CLS_PERIODS TO u_dw_stage;

GRANT CREATE VIEW TO u_dw_stage;

--Select 'GRANT SELECT ON u_dw_stage.' || table_name || ' TO u_dw_cls_star;' from DBA_TABLES where owner='U_DW_STAGE';

GRANT SELECT ON u_dw_stage.LC_CNTR_GROUP_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.LC_CNTR_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.LC_CNTR_SUB_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_GEO_OBJECTS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.LC_COUNTRIES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.LC_GEO_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.LC_GEO_PARTS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.LC_GEO_REGIONS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_CITIES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_GEO_ACTIONS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_RESTAURANT_TYPES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_RESTAURANTS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_DISH_TYPES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_DISH_CUISINES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_DISHES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_TYPE_PERIODS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_PERIODS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_DISH_ACTIONS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_OPERATIONS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_GEO_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_GEO_PARTS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_GEO_REGIONS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_CNTR_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_CNTR_SUB_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_CNTR_GROUP_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_COUNTRIES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_GEO_TYPES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.T_GEO_OBJECT_LINKS TO u_dw_cls_star;

--Select 'GRANT SELECT ON u_dw_stage.' || VIEW_NAME || ' TO u_dw_cls_star;' from DBA_VIEWS where owner='U_DW_STAGE';

GRANT SELECT ON u_dw_stage.W_GEO_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_GEO_PARTS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_GEO_REGIONS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_CNTR_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_CNTR_SUB_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_CNTR_GROUP_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_GEO_OBJECT_LINKS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_GEO_OBJECTS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.VL_GEO_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.VL_GEO_PARTS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.VL_GEO_REGIONS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.VL_CNTR_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.VL_CNTR_SUB_GROUPS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.VL_CNTR_GROUP_SYSTEMS TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.VL_COUNTRIES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_COUNTRIES TO u_dw_cls_star;
GRANT SELECT ON u_dw_stage.W_GEO_TYPES TO u_dw_cls_star;


ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_dw_cls_star_data_01;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_dw_cls_star_idx_01;




ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_1;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_2;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_3;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_4;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_5;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_6;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_7;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_8;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_9;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_10;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_11;
ALTER USER u_dw_cls_star QUOTA UNLIMITED ON ts_cls_star_data_month_12;



ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_1;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_2;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_3;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_4;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_5;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_6;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_7;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_8;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_9;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_10;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_11;
ALTER USER u_dw_star QUOTA UNLIMITED ON ts_star_data_month_12;




--Select 'GRANT SELECT ON u_dw_cls_star.' || table_name || ' TO u_dw_star;' from DBA_TABLES where owner='U_DW_CLS_STAR';



GRANT SELECT ON u_dw_cls_star.CLS_DIM_RESTAURANTS TO u_dw_star;
GRANT SELECT ON u_dw_cls_star.CLS_DIM_GEN_PERIODS TO u_dw_star;
GRANT SELECT ON u_dw_cls_star.CLS_DIM_TIME_DD TO u_dw_star;
GRANT SELECT ON u_dw_cls_star.CLS_DIM_GEO_LOCATIONS TO u_dw_star;
GRANT SELECT ON u_dw_cls_star.CLS_DIM_DISHES_SCD TO u_dw_star;
GRANT SELECT ON u_dw_cls_star.CLS_FCT_OPERATIONS_DD TO u_dw_star;


ALTER USER u_dw_star QUOTA UNLIMITED ON ts_dw_star_data_01;
