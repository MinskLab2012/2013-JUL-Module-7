CREATE OR REPLACE PACKAGE BODY pkg_load_source_dishes
AS
   -- Extract Data from external source = External Table
   -- Load All Dishes from external table
   PROCEDURE load_cls_dishes
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dishes';

      --Extract data
      INSERT INTO cls_dishes ( dish_code
                       , dish_name
                       , dish_desc
                       , dish_weight
                       , dish_type_name
                       , dish_cuisine_name
                       , dish_start_price_dol )
	   SELECT dish_code
	        , dish_name
	        , dish_desc
	        , ROUND ( dbms_random.VALUE ( 50
	                                    , 550 )
	                , -1 )
	             dish_weight
	        , dish_type
	        , dish_region AS dish_cuisine
	        , ROUND ( dbms_random.VALUE ( 2
	                                    , 70 )
	                , 2 )
	     FROM u_dw_source.t_ext_dishes;

      --Commit Data
      COMMIT;
   END load_cls_dishes;

   
END pkg_load_source_dishes;
/