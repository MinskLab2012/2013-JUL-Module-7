
DROP SEQUENCE u_dw.sq_vehicle_type_id;

CREATE SEQUENCE u_dw.sq_vehicle_type_id
   START WITH 1
   INCREMENT BY 1
   NOCACHE
   NOCYCLE;

GRANT SELECT ON u_dw.sq_vehicle_type_id TO u_dw_cleansing;