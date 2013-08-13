--DROP USER U_CLS_STAR CASCADE;
CREATE USER "U_CLS_STAR"
  IDENTIFIED BY "12345678"
    DEFAULT TABLESPACE ts_cls_star_01;


GRANT CONNECT,CREATE VIEW,RESOURCE TO "U_CLS_STAR";

ALTER USER u_cls_star QUOTA UNLIMITED ON ts_cls_star_01;
ALTER USER u_cls_star QUOTA UNLIMITED ON TS_CLS_FCT_MONTHLY;
ALTER USER u_cls_star QUOTA UNLIMITED ON TS_CLS_FCT_DAILY;



GRANT SELECT ON U_STG.T_GEO_OBJECT_ACTIONS TO u_cls_star;
GRANT SELECT ON U_STG.T_GEO_OBJECT_LINKS TO u_cls_star;
GRANT SELECT ON U_STG.T_COUNTRIES TO u_cls_star;
GRANT SELECT ON U_STG.T_GEO_REGIONS TO u_cls_star;
GRANT SELECT ON U_STG.T_GEO_PARTS TO u_cls_star;
GRANT SELECT ON U_STG.T_MEASURES TO u_cls_star;
GRANT SELECT ON U_STG.LC_COUNTRIES TO u_cls_star;
GRANT SELECT ON U_STG.LC_GEO_REGIONS TO u_cls_star;
GRANT SELECT ON U_STG.LC_GEO_PARTS TO u_cls_star;
GRANT SELECT ON u_stg.t_products TO u_cls_star;
GRANT SELECT ON u_stg.lc_products TO u_cls_star;
GRANT SELECT ON u_stg.t_prod_category TO u_cls_star;
GRANT SELECT ON u_stg.t_measures  TO u_cls_star;
GRANT SELECT ON u_stg.lc_prod_categories TO u_cls_star;
GRANT SELECT ON u_stg.t_customers TO u_cls_star;
GRANT SELECT ON u_stg.lc_customers TO u_cls_star;
GRANT SELECT ON u_stg.t_cust_status  TO u_cls_star;
GRANT SELECT ON u_stg.lc_cust_status TO u_cls_star;
GRANT SELECT ON u_stg.t_order_items  TO u_cls_star;
GRANT SELECT ON u_stg.t_orders TO u_cls_star;


/