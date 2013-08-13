CREATE TABLE t_geo_links_actions
(
   child_geo_id   NUMBER
 , link_type_id   NUMBER
 , new_value      NUMBER
 , action_type_id NUMBER
 , action_dt      DATE
);



GRANT DELETE,INSERT,UPDATE,SELECT ON t_geo_links_actions TO u_dw_cleansing;



CREATE TABLE T_GEO_LINKS_ACTION_TYPES 
(
   ACTION_TYPE_ID     NUMBER(20)           NOT NULL,
   ACTION_DESC        VARCHAR2(50 CHAR)
);

INSERT INTO T_GEO_LINKS_ACTION_TYPES VALUES(1, 'Parent id update');
COMMIT;

GRANT DELETE,INSERT,UPDATE,SELECT ON T_GEO_LINKS_ACTION_TYPES TO u_dw_cleansing;
