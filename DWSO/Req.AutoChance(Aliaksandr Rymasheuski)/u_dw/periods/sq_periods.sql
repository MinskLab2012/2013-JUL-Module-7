DROP SEQUENCE u_str_data.sq_per_id;

CREATE SEQUENCE u_str_data.sq_per_id
   START WITH 1
   INCREMENT BY 1
   NOCACHE
   NOCYCLE;

GRANT SELECT ON u_str_data.sq_per_id TO u_sal_cl;