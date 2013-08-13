/* Formatted on 13.08.2013 1:33:17 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_geo_locations_dw_stage
AS


   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_stage.w_countries trg
            WHERE trg.country_id NOT IN (SELECT DISTINCT country_id
                                           FROM u_dw_cls_stage.cls_geo_countries_iso3166);

      --Merge Source data
      MERGE INTO u_dw_stage.w_countries trg
           USING (  SELECT DISTINCT country_id
                      FROM u_dw_cls_stage.cls_geo_countries_iso3166
                  ORDER BY country_id) cls
              ON ( trg.country_id = cls.country_id )
      WHEN NOT MATCHED THEN
         INSERT            ( country_id )
             VALUES ( cls.country_id );

      --Merge Source Localizable Data
      MERGE INTO u_dw_stage.vl_countries trg
           USING (  SELECT MAX ( geo_id ) AS geo_id
                         , MAX ( country_id ) AS country_id
                         , country_desc
                         , MAX ( country_code_alpha3 ) AS country_code_alpha3
                         , MAX ( country_code_alpha2 ) AS country_code_alpha2
                         , 1 AS localization_id
                      FROM (SELECT trg.geo_id
                                 , trg.country_id
                                 , trg.country_desc
                                 , trg.country_code_alpha3
                                 , lkp.country_code_alpha2
                                 , trg.look_country_desc AS target_desc
                                 , lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id
                                         , trg.country_id
                                         , src.country_desc
                                         , UPPER ( src.country_desc ) || '%' look_country_desc
                                         , src.country_code AS country_code_alpha3
                                      FROM u_dw_stage.w_countries trg
                                         , u_dw_cls_stage.cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg
                                 , (SELECT NULL AS geo_id
                                         , NULL AS country_id
                                         , NULL AS country_desc
                                         , src2.country_desc AS look_country_desc
                                         , NULL AS country_code_alpha3
                                         , src2.country_code AS country_code_alpha2
                                      FROM u_dw_cls_stage.cls_geo_countries2_iso3166 src2) lkp
                             WHERE lkp.look_country_desc(+) LIKE trg.look_country_desc
                            UNION ALL
                            SELECT trg.geo_id
                                 , trg.country_id
                                 , trg.country_desc
                                 , trg.country_code_alpha3
                                 , lkp.country_code_alpha2
                                 , trg.look_country_desc AS target_desc
                                 , lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id
                                         , trg.country_id
                                         , src.country_desc
                                         , UPPER ( src.country_desc ) look_country_desc
                                         , src.country_code AS country_code_alpha3
                                      FROM u_dw_stage.w_countries trg
                                         , u_dw_cls_stage.cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg
                                 , (SELECT NULL AS geo_id
                                         , NULL AS country_id
                                         , NULL AS country_desc
                                         , SUBSTR ( src2.country_desc
                                                  , 1
                                                  , DECODE ( INSTR ( src2.country_desc
                                                                   , ',' )
                                                           , 0, 201
                                                           , INSTR ( src2.country_desc
                                                                   , ',' ) )
                                                    - 1 )
                                           || '%'
                                              AS look_country_desc
                                         , NULL AS country_code_alpha3
                                         , src2.country_code AS country_code_alpha2
                                      FROM u_dw_cls_stage.cls_geo_countries2_iso3166 src2) lkp
                             WHERE trg.look_country_desc(+) LIKE lkp.look_country_desc)
                     WHERE country_id IS NOT NULL
                  GROUP BY country_desc
                  ORDER BY country_id) cls
              ON ( trg.country_id = cls.country_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , country_id
                           , country_code_a2
                           , country_code_a3
                           , country_desc )
             VALUES ( cls.geo_id
                    , cls.country_id
                    , cls.country_code_alpha2
                    , cls.country_code_alpha3
                    , cls.country_desc )
      WHEN MATCHED THEN
         UPDATE SET trg.country_desc = cls.country_desc
                  , trg.country_code_a2 = cls.country_code_alpha2
                  , trg.country_code_a3 = cls.country_code_alpha3;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_countries;


   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_systems
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_stage.w_geo_systems trg
            WHERE trg.geo_system_id NOT IN (SELECT DISTINCT child_code
                                              FROM u_dw_cls_stage.cls_geo_structure_iso3166
                                             WHERE UPPER ( structure_level ) = 'WORLD');

      --Merge Source data
      MERGE INTO u_dw_stage.w_geo_systems trg
           USING (SELECT DISTINCT child_code
                    FROM u_dw_cls_stage.cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'WORLD') cls
              ON ( trg.geo_system_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_system_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_stage.vl_geo_systems trg
           USING (SELECT geo_id
                       , geo_system_id
                       , CASE WHEN ( geo_system_id = 1 ) THEN 'WORLD' ELSE NULL END geo_system_code
                       , CASE WHEN ( geo_system_id = 1 ) THEN 'The UN World structure' ELSE NULL END geo_system_desc
                    FROM u_dw_stage.w_geo_systems src
                       , u_dw_cls_stage.cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.geo_system_id) cls
              ON ( trg.geo_system_id = cls.geo_system_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , geo_system_id
                           , geo_system_code
                           , geo_system_desc )
             VALUES ( cls.geo_id
                    , cls.geo_system_id
                    , cls.geo_system_code
                    , cls.geo_system_desc )
      WHEN MATCHED THEN
         UPDATE SET trg.geo_system_desc = cls.geo_system_desc
                  , trg.geo_system_code = cls.geo_system_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_systems;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_parts
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_stage.w_geo_parts trg
            WHERE trg.part_id NOT IN (SELECT DISTINCT child_code
                                        FROM u_dw_cls_stage.cls_geo_structure_iso3166
                                       WHERE UPPER ( structure_level ) = 'CONTINENTS');

      --Merge Source data
      MERGE INTO u_dw_stage.w_geo_parts trg
           USING (SELECT DISTINCT child_code
                    FROM u_dw_cls_stage.cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'CONTINENTS') cls
              ON ( trg.part_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( part_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_stage.vl_geo_parts trg
           USING (SELECT geo_id
                       , src.part_id
                       , NULL part_code
                       , structure_desc AS part_desc
                    FROM u_dw_stage.w_geo_parts src
                       , u_dw_cls_stage.cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.part_id
                     AND UPPER ( cls.structure_level ) = 'CONTINENTS') cls
              ON ( trg.part_id = cls.part_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , part_id
                           , part_code
                           , part_desc )
             VALUES ( cls.geo_id
                    , cls.part_id
                    , cls.part_code
                    , cls.part_desc )
      WHEN MATCHED THEN
         UPDATE SET trg.part_desc = cls.part_desc
                  , trg.part_code = cls.part_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_parts;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_regions
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_stage.w_geo_regions trg
            WHERE trg.region_id NOT IN (SELECT DISTINCT child_code
                                          FROM u_dw_cls_stage.cls_geo_structure_iso3166
                                         WHERE UPPER ( structure_level ) = 'REGIONS');

      --Merge Source data
      MERGE INTO u_dw_stage.w_geo_regions trg
           USING (SELECT DISTINCT child_code
                    FROM u_dw_cls_stage.cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'REGIONS') cls
              ON ( trg.region_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( region_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_stage.vl_geo_regions trg
           USING (SELECT geo_id
                       , src.region_id
                       , NULL region_code
                       , structure_desc AS region_desc
                    FROM u_dw_stage.w_geo_regions src
                       , u_dw_cls_stage.cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.region_id
                     AND UPPER ( cls.structure_level ) = 'REGIONS') cls
              ON ( trg.region_id = cls.region_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , region_id
                           , region_code
                           , region_desc )
             VALUES ( cls.geo_id
                    , cls.region_id
                    , cls.region_code
                    , cls.region_desc )
      WHEN MATCHED THEN
         UPDATE SET trg.region_desc = cls.region_desc
                  , trg.region_code = cls.region_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_regions;

   -- Load Countries Grouping System from ISO 3166 to References
   PROCEDURE load_ref_cntr_group_systems
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_stage.w_cntr_group_systems trg
            WHERE trg.grp_system_id NOT IN (SELECT DISTINCT child_code
                                              FROM u_dw_cls_stage.cls_cntr_grouping_iso3166
                                             WHERE UPPER ( group_level ) = 'ALL');

      --Merge Source data
      MERGE INTO u_dw_stage.w_cntr_group_systems trg
           USING (SELECT DISTINCT child_code
                    FROM u_dw_cls_stage.cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'ALL') cls
              ON ( trg.grp_system_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( grp_system_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_stage.vl_cntr_group_systems trg
           USING (SELECT geo_id
                       , grp_system_id
                       , CASE WHEN ( grp_system_id = 1 ) THEN 'MAIN' ELSE NULL END grp_system_code
                       , cls.group_desc grp_system_desc
                    FROM u_dw_stage.w_cntr_group_systems src
                       , u_dw_cls_stage.cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.grp_system_id) cls
              ON ( trg.grp_system_id = cls.grp_system_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , grp_system_id
                           , grp_system_code
                           , grp_system_desc )
             VALUES ( cls.geo_id
                    , cls.grp_system_id
                    , cls.grp_system_code
                    , cls.grp_system_desc )
      WHEN MATCHED THEN
         UPDATE SET trg.grp_system_desc = cls.grp_system_desc
                  , trg.grp_system_code = cls.grp_system_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_group_systems;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_groups
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_stage.w_cntr_groups trg
            WHERE trg.GROUP_ID NOT IN (SELECT DISTINCT child_code
                                         FROM u_dw_cls_stage.cls_cntr_grouping_iso3166
                                        WHERE UPPER ( group_level ) = 'GROUPS');

      --Merge Source data
      MERGE INTO u_dw_stage.w_cntr_groups trg
           USING (SELECT DISTINCT child_code
                    FROM u_dw_cls_stage.cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'GROUPS') cls
              ON ( trg.GROUP_ID = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( GROUP_ID )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_stage.vl_cntr_groups trg
           USING (SELECT geo_id
                       , src.GROUP_ID
                       , NULL group_code
                       , group_desc AS group_desc
                    FROM u_dw_stage.w_cntr_groups src
                       , u_dw_cls_stage.cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.GROUP_ID
                     AND UPPER ( group_level ) = 'GROUPS') cls
              ON ( trg.GROUP_ID = cls.GROUP_ID )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , GROUP_ID
                           , group_code
                           , group_desc )
             VALUES ( cls.geo_id
                    , cls.GROUP_ID
                    , cls.group_code
                    , cls.group_desc )
      WHEN MATCHED THEN
         UPDATE SET trg.group_desc = cls.group_desc
                  , trg.group_code = cls.group_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_groups;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_sub_groups
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_stage.w_cntr_sub_groups trg
            WHERE trg.sub_group_id NOT IN (SELECT DISTINCT child_code
                                             FROM u_dw_cls_stage.cls_cntr_grouping_iso3166
                                            WHERE UPPER ( group_level ) = 'GROUP ITEMS');

      --Merge Source data
      MERGE INTO u_dw_stage.w_cntr_sub_groups trg
           USING (SELECT DISTINCT child_code
                    FROM u_dw_cls_stage.cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'GROUP ITEMS') cls
              ON ( trg.sub_group_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( sub_group_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_stage.vl_cntr_sub_groups trg
           USING (SELECT geo_id
                       , src.sub_group_id
                       , NULL sub_group_code
                       , group_desc AS sub_group_desc
                    FROM u_dw_stage.w_cntr_sub_groups src
                       , u_dw_cls_stage.cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.sub_group_id
                     AND UPPER ( group_level ) = 'GROUP ITEMS') cls
              ON ( trg.sub_group_id = cls.sub_group_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , sub_group_id
                           , sub_group_code
                           , sub_group_desc )
             VALUES ( cls.geo_id
                    , cls.sub_group_id
                    , cls.sub_group_code
                    , cls.sub_group_desc )
      WHEN MATCHED THEN
         UPDATE SET trg.sub_group_desc = cls.sub_group_desc
                  , trg.sub_group_code = cls.sub_group_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_sub_groups;

   -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_stage.w_geo_object_links trg
           USING (SELECT p_obj.geo_id parent_geo_id
                       , c_obj.geo_id child_geo_id
                       , CASE
                            WHEN p_obj.geo_type_id = 2
                             AND c_obj.geo_type_id = 10 THEN
                               1
                            WHEN p_obj.geo_type_id = 10
                             AND c_obj.geo_type_id = 11 THEN
                               2
                            ELSE
                               NULL
                         END
                            AS link_type_id
                    FROM (SELECT child_code
                               , parent_code
                               , structure_desc
                               , CASE
                                    WHEN UPPER ( structure_level ) = 'WORLD' THEN 2
                                    WHEN UPPER ( structure_level ) = 'CONTINENTS' THEN 10
                                    WHEN UPPER ( structure_level ) = 'REGIONS' THEN 11
                                    ELSE NULL
                                 END
                                    AS type_id
                            FROM u_dw_cls_stage.cls_geo_structure_iso3166) cls
                       , u_dw_stage.w_geo_objects p_obj
                       , u_dw_stage.w_geo_objects c_obj
                   WHERE cls.parent_code IS NOT NULL
                     AND p_obj.geo_code_id = cls.parent_code
                     AND p_obj.geo_type_id < cls.type_id
                     AND c_obj.geo_code_id = cls.child_code
                     AND c_obj.geo_type_id = cls.type_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_geo_structure;

   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_stage.w_geo_object_links trg
           USING (SELECT reg.geo_id AS parent_geo_id
                       , cntr.geo_id AS child_geo_id
                       , cls.county_desc
                       , cls.structure_desc
                       , 3 AS link_type_id
                    FROM u_dw_cls_stage.cls_cntr2structure_iso3166 cls
                       , u_dw_stage.w_countries cntr
                       , u_dw_stage.w_geo_regions reg
                   WHERE cls.country_id = cntr.country_id
                     AND cls.structure_code = reg.region_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_geo_countries;

   -- Load Countries links to Grouping Systems from ISO 3166 to References
   PROCEDURE load_lnk_cntr_grouping
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_stage.w_geo_object_links trg
           USING (SELECT p_obj.geo_id parent_geo_id
                       , c_obj.geo_id child_geo_id
                       , CASE
                            WHEN p_obj.geo_type_id = 50
                             AND c_obj.geo_type_id = 51 THEN
                               4
                            WHEN p_obj.geo_type_id = 51
                             AND c_obj.geo_type_id = 52 THEN
                               5
                            ELSE
                               NULL
                         END
                            AS link_type_id
                    FROM (SELECT child_code
                               , parent_code
                               , group_desc
                               , CASE
                                    WHEN UPPER ( group_level ) = 'ALL' THEN 50
                                    WHEN UPPER ( group_level ) = 'GROUPS' THEN 51
                                    WHEN UPPER ( group_level ) = 'GROUP ITEMS' THEN 52
                                    ELSE NULL
                                 END
                                    AS type_id
                            FROM u_dw_cls_stage.cls_cntr_grouping_iso3166) cls
                       , u_dw_stage.w_geo_objects p_obj
                       , u_dw_stage.w_geo_objects c_obj
                   WHERE cls.parent_code IS NOT NULL
                     AND p_obj.geo_code_id = cls.parent_code
                     AND p_obj.geo_type_id < cls.type_id
                     AND p_obj.geo_type_id > 49 --constant deviding by type
                     AND c_obj.geo_code_id = cls.child_code
                     AND c_obj.geo_type_id = cls.type_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_cntr_grouping;

   -- Load Countries links to Groups from ISO 3166 to References
   PROCEDURE load_lnk_cntr2groups
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_stage.w_geo_object_links trg
           USING (SELECT spb.geo_id AS parent_geo_id
                       , cntr.geo_id AS child_geo_id
                       , 6 AS link_type_id
                       , cls.county_desc
                    FROM u_dw_cls_stage.cls_cntr2grouping_iso3166 cls
                       , u_dw_stage.w_cntr_sub_groups spb
                       , u_dw_stage.w_countries cntr
                   WHERE cntr.country_id = cls.country_id
                     AND spb.sub_group_id = cls.group_code) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_cntr2groups;

   -- Load Cities to References
   PROCEDURE load_cities
   AS
   BEGIN
      MERGE INTO t_geo_types trg
     USING (SELECT 55 AS geo_type_id
                 , 'CITY' AS geo_type_code
                 , 'List all cities' AS geo_type_desc
              FROM DUAL) src
        ON ( trg.geo_type_id = src.geo_type_id
        AND trg.geo_type_code = src.geo_type_code
        AND trg.geo_type_desc = src.geo_type_desc )
	WHEN NOT MATCHED THEN
	   INSERT            ( geo_type_id
	                     , geo_type_code
	                     , geo_type_desc )
	       VALUES ( src.geo_type_id
	              , src.geo_type_code
	              , src.geo_type_desc );
	
	COMMIT;
	
	
	MERGE INTO t_geo_objects tgr
	     USING (SELECT ROWNUM
	                   + ( SELECT MAX ( geo_id )
	                         FROM t_geo_objects )
	                      AS geo_id
	                 , ROWNUM AS city_id
	                 , restaurant_city AS city
	              FROM    (SELECT DISTINCT restaurant_city
	                                     , restaurant_country_iso_code
	                                     , restaurant_country_name
	                         FROM u_dw_cls_stage.cls_restaurants) city
	                   LEFT JOIN
	                      lc_countries cntr
	                   ON ( city.restaurant_country_iso_code = cntr.country_code_a2 )
	                  AND ( city.restaurant_country_name = cntr.country_desc )) src
	        ON ( tgr.geo_code_id = src.city_id
	        AND tgr.geo_type_id = 55 )
	WHEN NOT MATCHED THEN
	   INSERT            ( geo_id
	                     , geo_type_id
	                     , geo_code_id )
	       VALUES ( src.geo_id
	              , 55
	              , src.city_id );
	
	COMMIT;
	
	MERGE INTO t_cities trg
	     USING (SELECT t_geo_objects.geo_id AS geo_id
	                 , ROWNUM AS city_id
	                 , restaurant_city AS city
	              FROM (SELECT DISTINCT restaurant_city
	                                  , restaurant_country_iso_code
	                                  , restaurant_country_name
	                      FROM u_dw_cls_stage.cls_restaurants) city
	                   LEFT JOIN lc_countries cntr
	                      ON ( city.restaurant_country_iso_code = cntr.country_code_a2 )
	                     AND ( city.restaurant_country_name = cntr.country_desc )
	                   LEFT JOIN t_geo_objects
	                      ON t_geo_objects.geo_code_id = ROWNUM
	                     AND t_geo_objects.geo_type_id = 55) src
	        ON ( src.city_id = trg.city_id )
	WHEN NOT MATCHED THEN
	   INSERT            ( geo_id
	                     , city_id
	                     , city_desc )
	       VALUES ( src.geo_id
	              , src.city_id
	              , src.city );
	
	COMMIT;
	
	
	
	MERGE INTO t_geo_object_links tgr
	     USING (SELECT DISTINCT cntr.geo_id AS parent_geo_id
	                          , t_cities.geo_id AS child_geo_id
	                          , 7 AS link_type_id
	              FROM u_dw_cls_stage.cls_restaurants city
	                   LEFT JOIN lc_countries cntr
	                      ON ( city.restaurant_country_iso_code = cntr.country_code_a2 )
	                   LEFT JOIN t_cities
	                      ON t_cities.city_desc = city.restaurant_city
	             WHERE cntr.country_desc NOT IN
	                      ( 'United States Virgin Islands'
	                     , 'China, Hong Kong Special Administrative Region'
	                     , 'China, Macao Special Administrative Region' )) src
	        ON ( src.child_geo_id = tgr.child_geo_id
	        AND tgr.link_type_id = src.link_type_id )
	WHEN NOT MATCHED THEN
	   INSERT            ( parent_geo_id
	                     , child_geo_id
	                     , link_type_id )
	       VALUES ( src.parent_geo_id
	              , src.child_geo_id
	              , src.link_type_id );
	
	
	
	COMMIT;
   END load_cities;



   -- Load Actions
   PROCEDURE load_geo_actions
   AS
   BEGIN
      MERGE INTO u_dw_stage.t_geo_actions trg
           USING (SELECT tbl.child_geo_id
                       , tbl.parent_geo_id AS parent_geo_id_new
                       , lnk.parent_geo_id AS parent_geo_id_old
                       , tbl.link_type_id
                    FROM    ( ( SELECT p_obj.geo_id parent_geo_id
                                     , c_obj.geo_id child_geo_id
                                     , CASE
                                          WHEN p_obj.geo_type_id = 2
                                           AND c_obj.geo_type_id = 10 THEN
                                             1
                                          WHEN p_obj.geo_type_id = 10
                                           AND c_obj.geo_type_id = 11 THEN
                                             2
                                          ELSE
                                             NULL
                                       END
                                          AS link_type_id
                                  FROM (SELECT child_code
                                             , parent_code
                                             , structure_desc
                                             , CASE
                                                  WHEN UPPER ( structure_level ) = 'WORLD' THEN 2
                                                  WHEN UPPER ( structure_level ) = 'CONTINENTS' THEN 10
                                                  WHEN UPPER ( structure_level ) = 'REGIONS' THEN 11
                                                  ELSE NULL
                                               END
                                                  AS type_id
                                          FROM u_dw_cls_stage.cls_geo_structure_iso3166) cls
                                     , u_dw_stage.w_geo_objects p_obj
                                     , u_dw_stage.w_geo_objects c_obj
                                 WHERE cls.parent_code IS NOT NULL
                                   AND p_obj.geo_code_id = cls.parent_code
                                   AND p_obj.geo_type_id < cls.type_id
                                   AND c_obj.geo_code_id = cls.child_code
                                   AND c_obj.geo_type_id = cls.type_id )
                             UNION ALL
                             ( SELECT reg.geo_id AS parent_geo_id
                                    , cntr.geo_id AS child_geo_id
                                    , 3 AS link_type_id
                                 FROM u_dw_cls_stage.cls_cntr2structure_iso3166 cls
                                    , u_dw_stage.w_countries cntr
                                    , u_dw_stage.w_geo_regions reg
                                WHERE cls.country_id = cntr.country_id
                                  AND cls.structure_code = reg.region_id )) tbl
                         LEFT JOIN
                            (SELECT t_geo_actions.parent_geo_id_new AS parent_geo_id
                                  , act_data.child_geo_id
                                  , act_data.link_type_id
                               FROM    (  SELECT MAX ( action_dt ) AS action_dt
                                               , child_geo_id
                                               , link_type_id
                                            FROM u_dw_stage.t_geo_actions
                                        GROUP BY child_geo_id
                                               , link_type_id) act_data
                                    LEFT JOIN
                                       u_dw_stage.t_geo_actions
                                    ON u_dw_stage.t_geo_actions.action_dt = act_data.action_dt
                                   AND u_dw_stage.t_geo_actions.child_geo_id = act_data.child_geo_id
                                   AND u_dw_stage.t_geo_actions.link_type_id = act_data.link_type_id) lnk
                         ON ( tbl.child_geo_id = lnk.child_geo_id
                         AND tbl.link_type_id = lnk.link_type_id )) cls
              ON ( trg.parent_geo_id_new = cls.parent_geo_id_new
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( action_id
                           , child_geo_id
                           , link_type_id
                           , parent_geo_id_old
                           , parent_geo_id_new
                           , action_dt )
             VALUES ( seq_t_actions.NEXTVAL
                    , cls.child_geo_id
                    , cls.link_type_id
                    , cls.parent_geo_id_old
                    , cls.parent_geo_id_new
                    , SYSDATE );

      --Commit Resulst
      COMMIT;
   END load_geo_actions;
END pkg_etl_geo_locations_dw_stage;
/