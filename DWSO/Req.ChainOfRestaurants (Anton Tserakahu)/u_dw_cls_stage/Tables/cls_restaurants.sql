
DROP TABLE u_dw_cls_stage.cls_restaurants;

--==============================================================
-- Table: cls_restaurants
--==============================================================

CREATE TABLE u_dw_cls_stage.cls_restaurants
(
   restaurant_code NUMBER ( 10 )
 , restaurant_name VARCHAR2 ( 150 )
 , restaurant_desc VARCHAR2 ( 2000 )
 , restaurant_email VARCHAR2 ( 200 )
 , restaurant_phone_number VARCHAR2 ( 30 )
 , restaurant_address VARCHAR2 ( 400 )
 , restaurant_numb_of_seats NUMBER ( 4 )
 , restaurant_numb_of_dining_ro NUMBER ( 4 )
 , restaurant_type_name VARCHAR2 ( 50 )
 , restaurant_city VARCHAR2 ( 70 )
 , restaurant_country_iso_code VARCHAR2 ( 10 )
 , restaurant_country_name VARCHAR2 ( 70 )
);

COMMENT ON TABLE u_dw_cls_stage.cls_restaurants IS
'Cleansing table for loading - Restaurants';