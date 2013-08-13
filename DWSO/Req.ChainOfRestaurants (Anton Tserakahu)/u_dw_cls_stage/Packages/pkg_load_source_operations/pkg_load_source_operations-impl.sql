CREATE OR REPLACE PACKAGE BODY pkg_load_source_operations
AS
   -- Extract Data from temp source
   -- Load All Operations from temp table
   PROCEDURE load_cls_operations
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_operations';

      --Extract data
      INSERT INTO cls_operations ( event_dt
                           , transaction_code
                           , restaurant_code
                           , dish_code
                           , unit_amount )
	   SELECT event_dt
	        , transaction_code
	        , restaurant_code
	        , dish_code
	        , unit_amount
	     FROM u_dw_source.temp_operations;

      --Commit Data
      COMMIT;
   END load_cls_operations;

   
END pkg_load_source_operations;
/