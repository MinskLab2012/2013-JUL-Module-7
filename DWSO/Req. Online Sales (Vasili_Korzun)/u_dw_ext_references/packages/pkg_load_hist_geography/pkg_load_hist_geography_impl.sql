/* Formatted on 12.08.2013 20:56:21 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_hist_geography
AS
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries_iso3166 (country_id, country_desc, country_code)
         SELECT country_id, country_desc, country_code
           FROM t_ext_geo_countries_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha3;

   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha2
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES2_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries2_iso3166 (country_desc, country_code)
         SELECT country_desc, country_code
           FROM t_ext_geo_countries2_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha2;

   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_countries trg
            WHERE trg.country_id NOT IN
                     (SELECT DISTINCT country_id
                        FROM cls_geo_countries_iso3166);

      --Merge Source data
      MERGE INTO u_dw_references.w_countries trg
           USING (  SELECT DISTINCT country_id
                      FROM cls_geo_countries_iso3166
                  ORDER BY country_id) cls
              ON (trg.country_id = cls.country_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (country_id)
             VALUES (cls.country_id);

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_countries trg
           USING (  SELECT MAX (geo_id) AS geo_id,
                           MAX (country_id) AS country_id,
                           country_desc,
                           MAX (country_code_alpha3) AS country_code_alpha3,
                           MAX (country_code_alpha2) AS country_code_alpha2,
                           1 AS localization_id
                      FROM (SELECT trg.geo_id,
                                   trg.country_id,
                                   trg.country_desc,
                                   trg.country_code_alpha3,
                                   lkp.country_code_alpha2,
                                   trg.look_country_desc AS target_desc,
                                   lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id,
                                           trg.country_id,
                                           src.country_desc,
                                           UPPER (src.country_desc) || '%'
                                              look_country_desc,
                                           src.country_code
                                              AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg,
                                           cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg,
                                   (SELECT NULL AS geo_id,
                                           NULL AS country_id,
                                           NULL AS country_desc,
                                           src2.country_desc
                                              AS look_country_desc,
                                           NULL AS country_code_alpha3,
                                           src2.country_code
                                              AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE lkp.look_country_desc(+) LIKE
                                      trg.look_country_desc
                            UNION ALL
                            SELECT trg.geo_id,
                                   trg.country_id,
                                   trg.country_desc,
                                   trg.country_code_alpha3,
                                   lkp.country_code_alpha2,
                                   trg.look_country_desc AS target_desc,
                                   lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id,
                                           trg.country_id,
                                           src.country_desc,
                                           UPPER (src.country_desc)
                                              look_country_desc,
                                           src.country_code
                                              AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg,
                                           cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg,
                                   (SELECT NULL AS geo_id,
                                           NULL AS country_id,
                                           NULL AS country_desc,
                                           SUBSTR (
                                              src2.country_desc,
                                              1,
                                              DECODE (
                                                 INSTR (src2.country_desc, ','),
                                                 0, 201,
                                                 INSTR (src2.country_desc, ','))
                                              - 1)
                                           || '%'
                                              AS look_country_desc,
                                           NULL AS country_code_alpha3,
                                           src2.country_code
                                              AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE trg.look_country_desc(+) LIKE
                                      lkp.look_country_desc)
                     WHERE country_id IS NOT NULL
                  GROUP BY country_desc
                  ORDER BY country_id) cls
              ON (trg.country_id = cls.country_id
                  AND trg.localization_id = cls.localization_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (geo_id,
                            country_id,
                            country_code_a2,
                            country_code_a3,
                            country_desc,
                            localization_id)
             VALUES (cls.geo_id,
                     cls.country_id,
                     cls.country_code_alpha2,
                     cls.country_code_alpha3,
                     cls.country_desc,
                     cls.localization_id)
      WHEN MATCHED
      THEN
         UPDATE SET
            trg.country_desc = cls.country_desc,
            trg.country_code_a2 = cls.country_code_alpha2,
            trg.country_code_a3 = cls.country_code_alpha3;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_countries;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Structures from ISO 3166
   PROCEDURE load_cls_geo_structure
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_geo_structure_iso3166 (child_code,
                                             parent_code,
                                             structure_desc,
                                             structure_level)
         SELECT child_code,
                parent_code,
                structure_desc,
                structure_level
           FROM t_ext_geo_structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Contries from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_CNTR2STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_cntr2structure_iso3166 (country_id,
                                              county_desc,
                                              structure_code,
                                              structure_desc)
         SELECT country_id,
                county_desc,
                structure_code,
                structure_desc
           FROM t_ext_cntr2structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure2cntr;

   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_h_geo_countries
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_countries trg
            WHERE trg.country_id NOT IN
                     (SELECT DISTINCT country_id
                        FROM cls_geo_countries_iso3166);

      --Merge Source data
      MERGE INTO u_dw_references.w_countries trg
           USING (  SELECT DISTINCT country_id
                      FROM cls_geo_countries_iso3166
                  ORDER BY country_id) cls
              ON (trg.country_id = cls.country_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (country_id)
             VALUES (cls.country_id);

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_countries trg
           USING (  SELECT MAX (geo_id) AS geo_id,
                           MAX (country_id) AS country_id,
                           country_desc,
                           MAX (country_code_alpha3) AS country_code_alpha3,
                           MAX (country_code_alpha2) AS country_code_alpha2,
                           1 AS localization_id
                      FROM (SELECT trg.geo_id,
                                   trg.country_id,
                                   trg.country_desc,
                                   trg.country_code_alpha3,
                                   lkp.country_code_alpha2,
                                   trg.look_country_desc AS target_desc,
                                   lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id,
                                           trg.country_id,
                                           src.country_desc,
                                           UPPER (src.country_desc) || '%'
                                              look_country_desc,
                                           src.country_code
                                              AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg,
                                           cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg,
                                   (SELECT NULL AS geo_id,
                                           NULL AS country_id,
                                           NULL AS country_desc,
                                           src2.country_desc
                                              AS look_country_desc,
                                           NULL AS country_code_alpha3,
                                           src2.country_code
                                              AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE lkp.look_country_desc(+) LIKE
                                      trg.look_country_desc
                            UNION ALL
                            SELECT trg.geo_id,
                                   trg.country_id,
                                   trg.country_desc,
                                   trg.country_code_alpha3,
                                   lkp.country_code_alpha2,
                                   trg.look_country_desc AS target_desc,
                                   lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id,
                                           trg.country_id,
                                           src.country_desc,
                                           UPPER (src.country_desc)
                                              look_country_desc,
                                           src.country_code
                                              AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg,
                                           cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg,
                                   (SELECT NULL AS geo_id,
                                           NULL AS country_id,
                                           NULL AS country_desc,
                                           SUBSTR (
                                              src2.country_desc,
                                              1,
                                              DECODE (
                                                 INSTR (src2.country_desc, ','),
                                                 0, 201,
                                                 INSTR (src2.country_desc, ','))
                                              - 1)
                                           || '%'
                                              AS look_country_desc,
                                           NULL AS country_code_alpha3,
                                           src2.country_code
                                              AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE trg.look_country_desc(+) LIKE
                                      lkp.look_country_desc)
                     WHERE country_id IS NOT NULL
                  GROUP BY country_desc
                  ORDER BY country_id) cls
              ON (trg.country_id = cls.country_id
                  AND trg.localization_id = cls.localization_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (geo_id,
                            country_id,
                            country_code_a2,
                            country_code_a3,
                            country_desc,
                            localization_id)
             VALUES (cls.geo_id,
                     cls.country_id,
                     cls.country_code_alpha2,
                     cls.country_code_alpha3,
                     cls.country_desc,
                     cls.localization_id)
      WHEN MATCHED
      THEN
         UPDATE SET
            trg.country_desc = cls.country_desc,
            trg.country_code_a2 = cls.country_code_alpha2,
            trg.country_code_a3 = cls.country_code_alpha3;

      --Commit Resulst
      COMMIT;
   END load_h_geo_countries;


   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_h_systems
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_systems trg
            WHERE trg.geo_system_id NOT IN
                     (SELECT DISTINCT child_code
                        FROM cls_geo_structure_iso3166
                       WHERE UPPER (structure_level) = 'WORLD');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_systems trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER (structure_level) = 'WORLD') cls
              ON (trg.geo_system_id = cls.child_code)
      WHEN NOT MATCHED
      THEN
         INSERT            (geo_system_id)
             VALUES (cls.child_code);

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_systems trg
           USING (SELECT geo_id,
                         geo_system_id,
                         CASE
                            WHEN (geo_system_id = 1) THEN 'WORLD'
                            ELSE NULL
                         END
                            geo_system_code,
                         CASE
                            WHEN (geo_system_id = 1)
                            THEN
                               'The UN World structure'
                            ELSE
                               NULL
                         END
                            geo_system_desc,
                         1 AS localization_id
                    FROM u_dw_references.w_geo_systems src,
                         cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.geo_system_id) cls
              ON (trg.geo_system_id = cls.geo_system_id
                  AND trg.localization_id = cls.localization_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (geo_id,
                            geo_system_id,
                            geo_system_code,
                            geo_system_desc,
                            localization_id)
             VALUES (cls.geo_id,
                     cls.geo_system_id,
                     cls.geo_system_code,
                     cls.geo_system_desc,
                     cls.localization_id)
      WHEN MATCHED
      THEN
         UPDATE SET
            trg.geo_system_desc = cls.geo_system_desc,
            trg.geo_system_code = cls.geo_system_code;

      --Commit Resulst
      COMMIT;
   END load_h_systems;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_h_geo_parts
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_parts trg
            WHERE trg.part_id NOT IN
                     (SELECT DISTINCT child_code
                        FROM cls_geo_structure_iso3166
                       WHERE UPPER (structure_level) = 'CONTINENTS');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_parts trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER (structure_level) = 'CONTINENTS') cls
              ON (trg.part_id = cls.child_code)
      WHEN NOT MATCHED
      THEN
         INSERT            (part_id)
             VALUES (cls.child_code);

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_parts trg
           USING (SELECT geo_id,
                         src.part_id,
                         NULL part_code,
                         structure_desc AS part_desc,
                         1 AS localization_id
                    FROM u_dw_references.w_geo_parts src,
                         cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.part_id
                         AND UPPER (cls.structure_level) = 'CONTINENTS') cls
              ON (trg.part_id = cls.part_id
                  AND trg.localization_id = cls.localization_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (geo_id,
                            part_id,
                            part_code,
                            part_desc,
                            localization_id)
             VALUES (cls.geo_id,
                     cls.part_id,
                     cls.part_code,
                     cls.part_desc,
                     cls.localization_id)
      WHEN MATCHED
      THEN
         UPDATE SET
            trg.part_desc = cls.part_desc, trg.part_code = cls.part_code;

      --Commit Resulst
      COMMIT;
   END load_h_geo_parts;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_h_geo_regions
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_regions trg
            WHERE trg.region_id NOT IN
                     (SELECT DISTINCT child_code
                        FROM cls_geo_structure_iso3166
                       WHERE UPPER (structure_level) = 'REGIONS');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_regions trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER (structure_level) = 'REGIONS') cls
              ON (trg.region_id = cls.child_code)
      WHEN NOT MATCHED
      THEN
         INSERT            (region_id)
             VALUES (cls.child_code);

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_regions trg
           USING (SELECT geo_id,
                         src.region_id,
                         NULL region_code,
                         structure_desc AS region_desc,
                         1 AS localization_id
                    FROM u_dw_references.w_geo_regions src,
                         cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.region_id
                         AND UPPER (cls.structure_level) = 'REGIONS') cls
              ON (trg.region_id = cls.region_id
                  AND trg.localization_id = cls.localization_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (geo_id,
                            region_id,
                            region_code,
                            region_desc,
                            localization_id)
             VALUES (cls.geo_id,
                     cls.region_id,
                     cls.region_code,
                     cls.region_desc,
                     cls.localization_id)
      WHEN MATCHED
      THEN
         UPDATE SET
            trg.region_desc = cls.region_desc,
            trg.region_code = cls.region_code;

      --Commit Resulst
      COMMIT;
   END load_h_geo_regions;





/*
t_geo_actions contains information only about UPDATED rows. I know that it's much better to store not only information about updated, but for inserted rows too. 
It was our last ETL labs lecture when I heard about how to load actions table it.
Tracking history of inserted and updated rows could help me to avoid UNION operation to get full dimension history (Task 9, dimension_generation.sql). 
On the other hand, I don't really need this full dimension history, because I need only actual data to track and load into DIM table. T_GEO_OBJECT_LINKS table contains this actual information, 
so I leave procedures load_h_lnk_geo_countries and load_h_lnk_geo_structure unchanged with actions table filled with updated rows.
*/


PROCEDURE load_h_lnk_geo_countries
AS
   CURSOR cur_c
   IS
      SELECT cls.parent_geo_id AS new_pid,
             trg.parent_geo_id AS old_pid,
             cls.child_geo_id,
             cls.link_type_id
        FROM    (SELECT reg.geo_id AS parent_geo_id,
                        cntr.geo_id AS child_geo_id     --   , cls.county_desc
                                                      --  , cls.structure_desc
                        ,
                        3 AS link_type_id
                   FROM cls_cntr2structure_iso3166 cls,
                        u_dw_references.w_countries cntr,
                        u_dw_references.w_geo_regions reg
                  WHERE cls.country_id = cntr.country_id
                        AND cls.structure_code = reg.region_id) cls
             LEFT JOIN
                u_dw_references.w_geo_object_links trg
             ON trg.child_geo_id = cls.child_geo_id
                AND trg.link_type_id = cls.link_type_id;
BEGIN
   FOR pc IN cur_c
   LOOP
      IF pc.old_pid IS NULL
      THEN
         INSERT INTO u_dw_references.t_geo_actions (action_id,
                                                    action_dt,
                                                    geo_id,
                                                    action_type_id,
                                                    int_value_old,
                                                    int_value_new)
              VALUES (u_dw_references.t_geo_actions_seq.NEXTVAL,
                      SYSDATE,
                      pc.child_geo_id,
                      1,
                      NULL,
                      pc.new_pid);

         INSERT INTO U_DW_REFERENCES.w_GEO_OBJECT_LINKS (
                                                         parent_geo_id,
                                                         child_geo_id,
                                                         link_type_id)
              VALUES (pc.new_pid, pc.child_geo_id, pc.link_type_id);
      ELSIF pc.old_pid != pc.new_pid
      THEN
         UPDATE u_dw_references.w_geo_object_links trg
            SET trg.parent_geo_id = pc.new_pid
          WHERE     trg.child_geo_id = pc.child_geo_id
                AND trg.link_type_id = pc.link_type_id
                AND trg.parent_geo_id = pc.old_pid;

         INSERT INTO u_dw_references.t_geo_actions (action_id,
                                                    action_dt,
                                                    geo_id,
                                                    action_type_id,
                                                    int_value_old,
                                                    int_value_new)
              VALUES (u_dw_references.t_geo_actions_seq.NEXTVAL,
                      SYSDATE,
                      pc.child_geo_id,
                      1,
                      pc.old_pid,
                      pc.new_pid);
      END IF;
end loop;
      COMMIT;
   END load_h_lnk_geo_countries;



   PROCEDURE load_h_lnk_geo_structure
   AS
    CURSOR cur_gs
   IS
      SELECT cls.parent_geo_id AS new_pid,
             trg.parent_geo_id AS old_pid,
             cls.child_geo_id,
             cls.link_type_id
        FROM    (SELECT p_obj.geo_id parent_geo_id,
                        c_obj.geo_id child_geo_id,
                        CASE
                           WHEN p_obj.geo_type_id = 2
                                AND c_obj.geo_type_id = 10
                           THEN
                              1
                           WHEN p_obj.geo_type_id = 10
                                AND c_obj.geo_type_id = 11
                           THEN
                              2
                           ELSE
                              NULL
                        END
                           AS link_type_id
                   FROM (SELECT child_code,
                                parent_code,
                                structure_desc,
                                CASE
                                   WHEN UPPER (structure_level) = 'WORLD'
                                   THEN
                                      2
                                   WHEN UPPER (structure_level) =
                                           'CONTINENTS'
                                   THEN
                                      10
                                   WHEN UPPER (structure_level) = 'REGIONS'
                                   THEN
                                      11
                                   ELSE
                                      NULL
                                END
                                   AS type_id
                           FROM cls_geo_structure_iso3166) cls,
                        u_dw_references.w_geo_objects p_obj,
                        u_dw_references.w_geo_objects c_obj
                  WHERE     cls.parent_code IS NOT NULL
                        AND p_obj.geo_code_id = cls.parent_code
                        AND p_obj.geo_type_id < cls.type_id
                        AND c_obj.geo_code_id = cls.child_code
                        AND c_obj.geo_type_id = cls.type_id) cls
             LEFT JOIN
                u_dw_references.w_geo_object_links trg
             ON trg.child_geo_id = cls.child_geo_id
                AND trg.link_type_id = cls.link_type_id;
BEGIN
   FOR pc IN cur_gs
   LOOP
      IF pc.old_pid IS NULL
      THEN
         INSERT INTO u_dw_references.t_geo_actions (action_id,
                                                    action_dt,
                                                    geo_id,
                                                    action_type_id,
                                                    int_value_old,
                                                    int_value_new)
              VALUES (u_dw_references.t_geo_actions_seq.NEXTVAL,
                      SYSDATE,
                      pc.child_geo_id,
                      1,
                      NULL,
                      pc.new_pid);

         INSERT INTO U_DW_REFERENCES.w_GEO_OBJECT_LINKS (
                                                         parent_geo_id,
                                                         child_geo_id,
                                                         link_type_id)
              VALUES (pc.new_pid, pc.child_geo_id, pc.link_type_id);
      ELSIF pc.old_pid != pc.new_pid
      THEN

         UPDATE u_dw_references.w_geo_object_links trg
            SET trg.parent_geo_id = pc.new_pid
          WHERE     trg.child_geo_id = pc.child_geo_id
                AND trg.link_type_id = pc.link_type_id
                AND trg.parent_geo_id = pc.old_pid;
                
         INSERT INTO u_dw_references.t_geo_actions (action_id,
                                                    action_dt,
                                                    geo_id,
                                                    action_type_id,
                                                    int_value_old,
                                                    int_value_new)
              VALUES (u_dw_references.t_geo_actions_seq.NEXTVAL,
                      SYSDATE,
                      pc.child_geo_id,
                      1,
                      pc.old_pid,
                      pc.new_pid);
      END IF;
   END LOOP;

   COMMIT;
   END load_h_lnk_geo_structure;
END pkg_load_hist_geography;

/*
   --some queries to generate actions
   BEGIN
   pkg_load_hist_geography.load_h_lnk_geo_structure;
   pkg_load_hist_geography.load_h_lnk_geo_countries;
END;

              update CLS_GEO_STRUCTURE_ISO3166
set parent_code = 142 where structure_desc = 'Northern Europe';
commit;
              
              
              update CLS_GEO_STRUCTURE_ISO3166
set parent_code = 150 where structure_desc = 'Northern Europe';
commit;

--initial
update cls_cntr2structure_iso3166
set structure_code = 14
where county_desc = 'Kenya';
commit;

-- africa to europe
update cls_cntr2structure_iso3166
set structure_code = 155
where county_desc = 'Kenya';
commit;


--initial
update cls_cntr2structure_iso3166
set structure_code = 11
where county_desc = 'Mali';
commit;

-- africa to europe
update cls_cntr2structure_iso3166
set structure_code = 155
where county_desc = 'Mali';
commit;

*/




         SELECT cls.parent_geo_id AS new_pid,
                trg.parent_geo_id AS old_pid,
                cls.child_geo_id,
                cls.link_type_id
           FROM    (SELECT p_obj.geo_id parent_geo_id,
                           c_obj.geo_id child_geo_id,
                           CASE
                              WHEN p_obj.geo_type_id = 2
                                   AND c_obj.geo_type_id = 10
                              THEN
                                 1
                              WHEN p_obj.geo_type_id = 10
                                   AND c_obj.geo_type_id = 11
                              THEN
                                 2
                              ELSE
                                 NULL
                           END
                              AS link_type_id
                      FROM (SELECT child_code,
                                   parent_code,
                                   structure_desc,
                                   CASE
                                      WHEN UPPER (structure_level) = 'WORLD'
                                      THEN
                                         2
                                      WHEN UPPER (structure_level) =
                                              'CONTINENTS'
                                      THEN
                                         10
                                      WHEN UPPER (structure_level) =
                                              'REGIONS'
                                      THEN
                                         11
                                      ELSE
                                         NULL
                                   END
                                      AS type_id
                              FROM cls_geo_structure_iso3166) cls,
                           u_dw_references.w_geo_objects p_obj,
                           u_dw_references.w_geo_objects c_obj
                     WHERE     cls.parent_code IS NOT NULL
                           AND p_obj.geo_code_id = cls.parent_code
                           AND p_obj.geo_type_id < cls.type_id
                           AND c_obj.geo_code_id = cls.child_code
                           AND c_obj.geo_type_id = cls.type_id) cls
                LEFT JOIN
                   u_dw_references.w_geo_object_links trg
                ON trg.child_geo_id = cls.child_geo_id
                   AND trg.link_type_id = cls.link_type_id