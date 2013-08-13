DROP SEQUENCE u_dw.sq_city_id;

CREATE SEQUENCE u_dw.sq_city_id
   START WITH 1
   INCREMENT BY 1
   NOCACHE
   NOCYCLE;

GRANT SELECT ON u_dw.sq_city_id TO u_dw_cleansing;