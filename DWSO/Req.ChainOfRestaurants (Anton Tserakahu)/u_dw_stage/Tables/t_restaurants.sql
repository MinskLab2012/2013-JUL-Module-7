
DROP TABLE t_restaurants CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_restaurants
--==============================================================

CREATE TABLE u_dw_stage.t_restaurants
(
   restaurant_id  NUMBER ( 10 ) NOT NULL
 , restaurant_code NUMBER ( 10 ) NOT NULL
 , restaurant_name VARCHAR2 ( 150 ) NOT NULL
 , restaurant_desc VARCHAR2 ( 2000 ) NOT NULL
 , restaurant_email VARCHAR2 ( 200 )
 , restaurant_phone_number VARCHAR2 ( 30 )
 , restaurant_address VARCHAR2 ( 400 ) NOT NULL
 , restaurant_numb_of_seats NUMBER ( 4 ) NOT NULL
 , restaurant_numb_of_dining_room NUMBER ( 4 ) NOT NULL
 , restaurant_type_id NUMBER ( 3 ) NOT NULL
 , restaurant_geo_id NUMBER ( 22, 0 )
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
TABLESPACE ts_dw_stage_data_01;

ALTER TABLE u_dw_stage.t_restaurants
   ADD CONSTRAINT pk_t_restaurants PRIMARY KEY (restaurant_id) USING INDEX   TABLESPACE ts_dw_stage_idx_01;


CREATE INDEX idx_restaurants_name
   ON t_restaurants ( restaurant_name )
   TABLESPACE ts_dw_stage_idx_01;


CREATE INDEX idx_restaurants_address
   ON t_restaurants ( restaurant_address )
   TABLESPACE ts_dw_stage_idx_01;