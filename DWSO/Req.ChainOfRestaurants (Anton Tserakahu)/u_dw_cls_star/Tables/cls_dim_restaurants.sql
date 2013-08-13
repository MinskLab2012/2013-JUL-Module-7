
DROP TABLE u_dw_cls_star.cls_dim_restaurants CASCADE CONSTRAINT;

/*==============================================================*/

/* Table: DIM_RESTAURANTS                                       */

/*==============================================================*/

CREATE TABLE u_dw_cls_star.cls_dim_restaurants
(
   restaurant_id  NUMBER ( 10 ) NOT NULL
 , restaurant_code NUMBER ( 10 ) NOT NULL
 , restaurant_name VARCHAR2 ( 150 ) NOT NULL
 , restaurant_desc VARCHAR2 ( 2000 ) NOT NULL
 , restaurant_email VARCHAR2 ( 200 )
 , restaurant_phone_number VARCHAR2 ( 30 )
 , restaurant_address VARCHAR2 ( 400 ) NOT NULL
 , restaurant_number_of_seats NUMBER ( 4 ) NOT NULL
 , restaurant_number_of_dining_ro NUMBER ( 4 ) NOT NULL
 , restaurant_type_id NUMBER ( 3 ) NOT NULL
 , restaurant_type_name VARCHAR2 ( 50 ) NOT NULL
 , restaurant_type_desc VARCHAR2 ( 200 ) NOT NULL
 , restaurant_city_geo_id NUMBER ( 10 ) NOT NULL
 , restaurant_city_id NUMBER ( 10 ) NOT NULL
 , restaurant_city_desc VARCHAR2 ( 150 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_restaurants PRIMARY KEY ( restaurant_id )
);