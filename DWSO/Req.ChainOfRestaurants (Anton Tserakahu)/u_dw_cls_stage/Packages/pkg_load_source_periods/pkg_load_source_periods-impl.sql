CREATE OR REPLACE PACKAGE BODY pkg_load_source_periods
AS
   -- Extract Data from temp source
   -- Load All Operations from temp table
   PROCEDURE load_cls_periods
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_periods';

      --Extract data
      INSERT INTO cls_periods ( period_code
                        , period_desc
                        , start_dt
                        , end_dt
                        , period_type_name
                        , period_type_desc )
	   SELECT period_code
	        , period_desc
	        , start_dt
	        , end_dt
	        , period_type_name
	        , period_type_desc
	     FROM u_dw_source.temp_periods;

      --Commit Data
      COMMIT;
   END load_cls_periods;

   
END pkg_load_source_periods;
/