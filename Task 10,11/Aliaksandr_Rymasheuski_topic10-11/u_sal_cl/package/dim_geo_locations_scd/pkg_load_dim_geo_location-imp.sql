/* Formatted on 10.08.2013 13:36:36 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_geo_location
AS
   PROCEDURE load_location
   AS
      CURSOR chg_countries
      IS
         --select new actual data from stage
         SELECT geo.country_geo_id
              , cnt.country_id
              , cnt.country_code_a2
              , cnt.country_code_a3
              , cnt.region_desc AS country_name
              , NVL ( geo.region_geo_id, -99 ) AS region_geo_id
              , NVL ( reg.src_continent_id, -99 ) AS src_continent_id
              , NVL ( reg.region_code, 'n.d.' ) AS region_code
              , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
              , NVL ( geo.contenet_geo_id, -99 ) AS contenet_geo_id
              , NVL ( prt.part_id, -99 ) AS part_id
              , NVL ( prt.part_code, 'n.d.' ) AS part_code
              , NVL ( prt.part_desc, 'n.d.' ) AS part_desc
           FROM (  SELECT country_geo_id
                        , SUM ( contenet ) AS contenet_geo_id
                        , SUM ( region ) AS region_geo_id
                     FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS country_geo_id
                                    , parent_geo_id
                                    , link_type_id
                                    , DECODE ( link_type_id, 2, parent_geo_id ) AS contenet
                                    , DECODE ( link_type_id, 3, parent_geo_id ) AS region
                                 FROM u_dw_references.w_geo_object_links
                           CONNECT BY PRIOR parent_geo_id = child_geo_id
                           START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                         FROM u_dw_references.cu_countries))
                 GROUP BY country_geo_id) geo
                LEFT JOIN u_dw_references.cu_countries cnt
                   ON ( geo.country_geo_id = cnt.geo_id )
                LEFT JOIN u_dw_references.cu_geo_regions reg
                   ON ( geo.region_geo_id = reg.geo_id )
                LEFT JOIN u_dw_references.cu_geo_parts prt
                   ON ( geo.contenet_geo_id = prt.geo_id )
         MINUS
         --select actual data from dim_countries
         SELECT *
           FROM u_str_data.actual_countries;

      CURSOR chg_regions
      IS
         --regions actual data from stage
         SELECT geo.region_geo_id
              , NVL ( reg.src_continent_id, -99 ) AS src_continent_id
              , NVL ( reg.region_code, 'n.d.' ) AS region_code
              , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
              , NVL ( geo.contenet_geo_id, -99 ) AS contenet_geo_id
              , NVL ( prt.part_id, -99 ) AS part_id
              , NVL ( prt.part_code, 'n.d.' ) AS part_code
              , NVL ( prt.part_desc, 'n.d.' ) AS part_desc
           FROM (  SELECT region_geo_id
                        , SUM ( contenet ) AS contenet_geo_id
                     FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS region_geo_id
                                    , parent_geo_id
                                    , link_type_id
                                    , DECODE ( link_type_id, 2, parent_geo_id ) AS contenet
                                 FROM u_dw_references.w_geo_object_links
                           CONNECT BY PRIOR parent_geo_id = child_geo_id
                           START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                         FROM u_dw_references.cu_geo_regions))
                 GROUP BY region_geo_id) geo
                LEFT JOIN u_dw_references.cu_geo_regions reg
                   ON ( geo.region_geo_id = reg.geo_id )
                LEFT JOIN u_dw_references.cu_geo_parts prt
                   ON ( geo.contenet_geo_id = prt.geo_id )
         MINUS
         --regions actual data from dim_geo
         SELECT *
           FROM u_str_data.actual_regions;
   BEGIN
      FOR i IN chg_countries LOOP
         INSERT INTO u_str_data.dim_geo_locations_scd
              VALUES ( u_str_data.sq_geo_surr_id.NEXTVAL
                     , i.country_geo_id
                     , i.country_geo_id
                     , i.country_id
                     , i.country_code_a2
                     , i.country_code_a3
                     , i.country_name
                     , i.region_geo_id
                     , i.src_continent_id
                     , i.region_code
                     , i.region_desc
                     , i.contenet_geo_id
                     , i.part_id
                     , i.part_code
                     , i.part_desc
                     , 'Countries'
                     , ( SELECT MAX ( action_dt ) AS action_dt
                           FROM u_dw.t_geo_links_actions
                          WHERE action_type_id = 1
                            AND link_type_id = 3
                            AND child_geo_id = i.country_geo_id )
                     , TO_DATE ( '12/12/9999'
                               , 'mm/dd/yyyy' ) );


         UPDATE u_str_data.dim_geo_locations_scd
            SET valid_to     =
                   ( SELECT MAX ( action_dt ) AS action_dt
                       FROM u_dw.t_geo_links_actions
                      WHERE action_type_id = 1
                        AND link_type_id = 3
                        AND child_geo_id = i.country_geo_id )
          WHERE valid_to = TO_DATE ( '12/12/9999'
                                   , 'mm/dd/yyyy' )
            AND geo_id = i.country_geo_id
            AND valid_from < (SELECT MAX ( action_dt ) AS action_dt
                                FROM u_dw.t_geo_links_actions
                               WHERE action_type_id = 1
                                 AND link_type_id = 3
                                 AND child_geo_id = i.country_geo_id);
      END LOOP;

      COMMIT;

      FOR j IN chg_regions LOOP
         INSERT INTO u_str_data.dim_geo_locations_scd ( geo_surr_id
                                                      , geo_id
                                                      , region_geo_id
                                                      , region_id
                                                      , region_code
                                                      , region_desc
                                                      , part_geo_id
                                                      , part_id
                                                      , part_code
                                                      , part_desc
                                                      , level_code
                                                      , valid_from
                                                      , valid_to )
              VALUES ( u_str_data.sq_geo_surr_id.NEXTVAL
                     , j.region_geo_id
                     , j.region_geo_id
                     , j.src_continent_id
                     , j.region_code
                     , j.region_desc
                     , j.contenet_geo_id
                     , j.part_id
                     , j.part_code
                     , j.part_desc
                     , 'Regions'
                     , ( SELECT MAX ( action_dt ) AS action_dt
                           FROM u_dw.t_geo_links_actions
                          WHERE action_type_id = 1
                            AND link_type_id = 2
                            AND child_geo_id = j.region_geo_id )
                     , TO_DATE ( '12/12/9999'
                               , 'mm/dd/yyyy' ) );

         UPDATE u_str_data.dim_geo_locations_scd
            SET valid_to     =
                   ( SELECT MAX ( action_dt ) AS action_dt
                       FROM u_dw.t_geo_links_actions
                      WHERE action_type_id = 1
                        AND link_type_id = 2
                        AND child_geo_id = j.region_geo_id )
          WHERE valid_to = TO_DATE ( '12/12/9999'
                                   , 'mm/dd/yyyy' )
            AND geo_id = j.region_geo_id
            AND valid_from < (SELECT MAX ( action_dt ) AS action_dt
                                FROM u_dw.t_geo_links_actions
                               WHERE action_type_id = 1
                                 AND link_type_id = 2
                                 AND child_geo_id = j.region_geo_id);
      END LOOP;

      COMMIT;
   END load_location;
END pkg_load_dim_geo_location;