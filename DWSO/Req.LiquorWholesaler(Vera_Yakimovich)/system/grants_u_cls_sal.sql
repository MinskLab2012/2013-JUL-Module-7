/* Formatted on 13.08.2013 16:47:14 (QP5 v5.139.911.3011) */
GRANT SELECT,INSERT ON   u_sal.dim_geo TO u_cls_star;
GRANT SELECT,INSERT ON   u_sal.dim_products TO u_cls_star;
GRANT SELECT,INSERT ON   u_sal.dim_customers TO u_cls_star;
GRANT SELECT,INSERT ON   u_sal.dim_times TO u_cls_star;

GRANT DROP ANY  TABLE TO u_cls_star;

  GRANT  ALTER  ON    u_sal.fct_income_products_monthly   TO u_cls_star;
  GRANT  SELECT  ON    u_sal.fct_income_products_monthly   TO u_cls_star;
  ALTER USER u_cls_star QUOTA UNLIMITED ON ts_fct_arch;
  ALTER USER u_sal QUOTA UNLIMITED ON ts_cls_fct_monthly;
  GRANT ALTER TABLESPACE TO  u_cls_star;

   GRANT  ALTER  ON    u_sal.fct_income_products_daily   TO u_cls_star;
  GRANT  SELECT  ON    u_sal.fct_income_products_daily   TO u_cls_star;
  ALTER USER u_cls_star QUOTA UNLIMITED ON ts_fct_2013;
  ALTER USER u_sal QUOTA UNLIMITED ON ts_cls_fct_daily;
  GRANT ALTER TABLESPACE TO  u_cls_star;