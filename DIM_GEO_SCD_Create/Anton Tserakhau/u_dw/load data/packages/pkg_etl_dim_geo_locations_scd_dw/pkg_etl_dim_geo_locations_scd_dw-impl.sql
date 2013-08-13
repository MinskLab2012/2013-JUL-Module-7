CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_geo_loc_scd_dw
AS

   -- Load dim_geo_locations_scd
   PROCEDURE load_dim_geo_locations_scd
   AS
   BEGIN
      
	MERGE INTO u_dw.dim_geo_locations_scd tgr
	     USING (SELECT *
	              FROM u_dw_references.view_dim_geo_country) cls
	        ON ( tgr.surr_id = cls.surr_id )
	WHEN NOT MATCHED THEN
	   INSERT            ( surr_id
	                     , country_geo_id
	                     , country_id
	                     , country_code_a2
	                     , country_code_a3
	                     , country_desc
	                     , region_geo_id
	                     , region_id
	                     , region_code
	                     , region_desc
	                     , part_geo_id
	                     , part_id
	                     , part_code
	                     , part_desc
	                     , geo_system_geo_id
	                     , geo_system_id
	                     , geo_system_code
	                     , geo_system_desc
	                     , from_dt
	                     , to_dt
	                     , status )
	       VALUES ( seq_dim_geo_locations_scd.NEXTVAL
	              , cls.country_geo_id
	              , cls.country_id
	              , cls.country_code_a2
	              , cls.country_code_a3
	              , cls.country_desc
	              , cls.region_geo_id
	              , cls.region_id
	              , cls.region_code
	              , cls.region_desc
	              , cls.part_geo_id
	              , cls.part_id
	              , cls.part_code
	              , cls.part_desc
	              , cls.geo_system_geo_id
	              , cls.geo_system_id
	              , cls.geo_system_code
	              , cls.geo_system_desc
	              , cls.from_dt
	              , cls.to_dt
	              , cls.status );
	
	   --Commit Resulst
	COMMIT;


   END load_dim_geo_locations_scd;



END pkg_etl_dim_geo_loc_scd_dw;
/