   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_h_lnk_geo_countries
   AS
      CURSOR cur_c
      IS
         SELECT cls.parent_geo_id AS new_pid,
                trg.parent_geo_id AS old_pid,
                cls.child_geo_id,
                cls.link_type_id
           FROM    (SELECT reg.geo_id AS parent_geo_id,
                           cntr.geo_id AS child_geo_id--   , cls.county_desc
                                                      --  , cls.structure_desc
                           ,
                           3 AS link_type_id
                      FROM cls_cntr2structure_iso3166 cls,
                           u_dw_references.w_countries cntr,
                           u_dw_references.w_geo_regions reg
                     WHERE cls.country_id = cntr.country_id
                           AND cls.structure_code = reg.region_id
                    MINUS
                    SELECT parent_geo_id, child_geo_id, link_type_id
                      FROM u_dw_references.w_geo_object_links) cls
                LEFT JOIN
                   u_dw_references.w_geo_object_links trg
                ON trg.child_geo_id = cls.child_geo_id
                   AND trg.link_type_id = cls.link_type_id;
   BEGIN
      --Merge Source data
      --This merge only used to insert data, thus i exclude trg.parent_geo_id = cls.parent_geo_id  condition from ON merge clause
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT reg.geo_id AS parent_geo_id,
                         cntr.geo_id AS child_geo_id,
                         cls.county_desc,
                         cls.structure_desc,
                         3 AS link_type_id
                    FROM cls_cntr2structure_iso3166 cls,
                         u_dw_references.w_countries cntr,
                         u_dw_references.w_geo_regions reg
                   WHERE cls.country_id = cntr.country_id
                         AND cls.structure_code = reg.region_id) cls
              ON (    --trg.parent_geo_id = cls.parent_geo_id              AND
                  trg.child_geo_id = cls.child_geo_id
                  AND trg.link_type_id = cls.link_type_id)
      WHEN NOT MATCHED
      THEN
         INSERT            (parent_geo_id,
                            child_geo_id,
                            link_type_id,
                            insert_dt)
             VALUES (cls.parent_geo_id,
                     cls.child_geo_id,
                     cls.link_type_id,
                     SYSDATE);

      COMMIT;

      -- After I have inserted new rows into links I select rows that should be updated
      -- probably I should've defined explicit cursor and other stuff, but I like high-level languages style (for SMTH in COLLECTION).
      -- Nevertheless, main idea is that cursor should be opened AFTER new rows are inserted.
      FOR pc IN cur_c
      LOOP
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
      END LOOP;

      COMMIT;
   END load_h_lnk_geo_countries;