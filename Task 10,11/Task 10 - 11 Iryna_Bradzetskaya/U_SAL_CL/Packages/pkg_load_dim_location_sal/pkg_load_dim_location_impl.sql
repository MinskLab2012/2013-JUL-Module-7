CREATE OR REPLACE PACKAGE BODY pkg_load_dim_location
AS
   PROCEDURE load_location
   AS
   
      CURSOR c_countries
      IS
         SELECT *
        FROM v_all_countries WHERE COUNTRY_GEO_ID IN (
         SELECT COUNTRY_GEO_ID FROM U_SAL_CL.V_ALL_COUNTRIES
         MINUS
         
         SELECT geo_id
           FROM u_sal.DIM_LOCATIONS_SCD WHERE valid_to = TO_DATE ( '01/01/9999'
                                   , 'mm/dd/yyyy' ));

      CURSOR c_regions
      IS
           SELECT * FROM V_ALL_REGIONS WHERE region_geo_id IN (
        SELECT region_geo_id FROM U_SAL_CL.V_ALL_REGIONS
         MINUS
         
         SELECT geo_id 
           FROM u_sal.DIM_LOCATIONS_SCD WHERE valid_to = TO_DATE ( '01/01/9999'
                                   , 'mm/dd/yyyy' ));
      
   BEGIN
      FOR i IN c_countries LOOP
         INSERT INTO u_sal.DIM_LOCATIONS_SCD ( geo_surr_id 
   , geo_id 
   , geo_country_id
   , country_id
   , country_code_a2     
   , country_code_a3     
   , geo_country_name 
   , geo_region_id    
   , geo_region_code
   , geo_region_desc   
   , geo_part_id       
   , geo_part_desc       
   , geo_part_code   
   , level_code      
   , valid_from      
   , valid_to   )
              VALUES ( SEQ_GEO_SURR_ID.NEXTVAL
                     , i.country_geo_id
                     , i.country_geo_id
                     , i.country_id
                     , i.country_code_a2
                     , i.country_code_a3
                     , i.country_name
                     , i.src_continent_id
                     , i.region_code
                     , i.region_desc
                     , i.part_id
                     , i.part_desc
                     , i.part_code
                     , 'Countries'
                     , ( SELECT MAX ( action_date )
                           FROM u_dw.GEO_LINKS_ACTIONS
                          WHERE action_type_id = 1
                            AND link_type = 3
                            AND child_id = i.country_geo_id )
                     , TO_DATE ( '01/01/9999'
                               , 'mm/dd/yyyy' ) );


         UPDATE u_sal.dim_locations_scd
            SET valid_to     =
                   ( SELECT MAX ( action_date) AS action_dt
                       FROM u_dw.GEO_LINKS_ACTIONS
                      WHERE action_type_id = 1
                        AND link_type = 3
                        AND child_id = i.country_geo_id )
          WHERE valid_to = TO_DATE ( '01/01/9999'
                                   , 'mm/dd/yyyy' )
            AND geo_id = i.country_geo_id
            AND valid_from < (SELECT MAX ( action_date) AS action_dt
                       FROM u_dw.GEO_LINKS_ACTIONS
                      WHERE action_type_id = 1
                        AND link_type = 3
                        AND child_id = i.country_geo_id);
      END LOOP;

      COMMIT;

      FOR j IN c_regions LOOP
         INSERT INTO u_sal.dim_locations_scd (  geo_surr_id 
   , geo_id 
   , geo_region_id    
   , geo_region_code
   , geo_region_desc   
   , geo_part_id       
   , geo_part_desc       
   , geo_part_code   
   , level_code      
   , valid_from      
   , valid_to )
              VALUES ( SEQ_GEO_SURR_ID.NEXTVAL
                     , j.region_geo_id
                     , j.region_geo_id
                     , j.src_continent_id
                     , j.region_desc
                     , j.part_id
                     , j.part_desc
                     , j.part_code
                     , 'Regions'
                     , ( SELECT MAX ( action_date )
                           FROM u_dw.GEO_LINKS_ACTIONS
                          WHERE action_type_id = 1
                            AND link_type = 2
                            AND child_id = j.region_geo_id )
                     , TO_DATE ( '01/01/9999'
                               , 'mm/dd/yyyy' ) );

         UPDATE u_sal.dim_locations_scd
            SET valid_to     =
                   ( SELECT MAX ( action_date )
                           FROM u_dw.GEO_LINKS_ACTIONS
                          WHERE action_type_id = 1
                            AND link_type = 2
                            AND child_id = j.region_geo_id  )
          WHERE valid_to = TO_DATE ( '01/01/9999'
                                   , 'mm/dd/yyyy' )
            AND geo_id = j.region_geo_id
            AND valid_from < (SELECT MAX ( action_date )
                           FROM u_dw.GEO_LINKS_ACTIONS
                          WHERE action_type_id = 1
                            AND link_type = 2
                            AND child_id = j.region_geo_id);
      END LOOP;

      COMMIT;
   END load_location;
END pkg_load_dim_location;