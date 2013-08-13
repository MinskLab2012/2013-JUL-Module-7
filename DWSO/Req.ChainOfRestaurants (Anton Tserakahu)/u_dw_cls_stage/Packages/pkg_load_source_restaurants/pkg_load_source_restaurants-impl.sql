CREATE OR REPLACE PACKAGE BODY pkg_load_source_restaurants
AS
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_restaurants
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_restaurants';

      --Extract data
      INSERT INTO cls_restaurants ( restaurant_code
                            , restaurant_name
                            , restaurant_desc
                            , restaurant_email
                            , restaurant_phone_number
                            , restaurant_address
                            , restaurant_numb_of_seats
                            , restaurant_numb_of_dining_ro
                            , restaurant_type_name
                            , restaurant_city
                            , restaurant_country_iso_code
                            , restaurant_country_name )
	   SELECT restaurant_code
	        , restaurant_name
	        , restaurant_desc
	        , restaurant_email
	        , restaurant_phone_number
	        , restaurant_address
	        , restaurant_numb_of_seats
	        , restaurant_numb_of_dining_ro
	        , restaurant_type_name
	        , restaurant_city
	        , restaurant_country_iso_code
	        , restaurant_country_name
	     FROM u_dw_source.temp_restaurants;

      --Commit Data
      COMMIT;
   END load_cls_restaurants;

   
END pkg_load_source_restaurants;
/