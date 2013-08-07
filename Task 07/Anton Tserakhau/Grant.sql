
GRANT CREATE   VIEW TO u_dw_stage;
GRANT CREATE ANY TABLE TO u_dw_stage;


/*SELECT 'grant update on u_dw_ext_references.' || object_name || ' to u_dw_stage;'
  FROM all_objects
 WHERE owner = 'U_DW_EXT_REFERENCES'
   AND object_type IN ('VIEW', 'TABLE');*/

GRANT CREATE DATABASE LINK TO u_dw_stage;

GRANT ON COMMIT REFRESH on u_dw_ext_references.CLS_DISHES TO U_DW_STAGE;
GRANT ON COMMIT REFRESH on u_dw_ext_references.CLS_RESTAURANTS TO U_DW_STAGE;
GRANT ON COMMIT REFRESH on u_dw_ext_references.CLS_OPERATIONS TO U_DW_STAGE;
GRANT ON COMMIT REFRESH on u_dw_ext_references.CLS_PERIODS TO U_DW_STAGE;
GRANT QUERY REWRITE  TO U_DW_STAGE;

GRANT ON COMMIT REFRESH on U_DW_STAGE.T_OPERATIONS TO U_DW_STAGE;

GRANT ON COMMIT REFRESH on u_dw_references.lc_cities  TO U_DW_STAGE;
GRANT ON COMMIT REFRESH on u_dw_references.t_geo_object_links TO U_DW_STAGE;
GRANT ON COMMIT REFRESH on u_dw_references.cu_countries TO U_DW_STAGE;

GRANT UPDATE ON u_dw_ext_references.cls_dishes TO u_dw_stage;
GRANT UPDATE ON u_dw_ext_references.cls_restaurants TO u_dw_stage;
GRANT UPDATE ON u_dw_ext_references.cls_periods TO u_dw_stage;
GRANT UPDATE ON u_dw_ext_references.cls_operations TO u_dw_stage;