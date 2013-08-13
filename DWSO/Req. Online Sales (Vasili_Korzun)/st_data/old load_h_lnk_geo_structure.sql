    -- old load_h_lnk_geo_structure

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
                           AND c_obj.geo_type_id = cls.type_id
                    MINUS
                    SELECT parent_geo_id, child_geo_id, link_type_id
                      FROM u_dw_references.w_geo_object_links trg) cls
                LEFT JOIN
                   u_dw_references.w_geo_object_links trg
                ON trg.child_geo_id = cls.child_geo_id
                   AND trg.link_type_id = cls.link_type_id;
   BEGIN
      --Merge Source data
      --This merge only used to insert data, thus i exclude trg.parent_geo_id = cls.parent_geo_id  condition from ON merge clause
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT p_obj.geo_id parent_geo_id,
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
              ON (   -- trg.parent_geo_id = cls.parent_geo_id              AND
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

      -- After I have inserted new rows into links I select rows that should be updated:
      -- Cursor should be opened AFTER new rows are inserted to collect only rows-to-update.

      FOR pc IN cur_gs
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