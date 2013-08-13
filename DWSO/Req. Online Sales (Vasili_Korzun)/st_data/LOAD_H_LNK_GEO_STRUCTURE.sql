/* Formatted on 13.08.2013 2:11:08 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PROCEDURE load_h_lnk_geo_structure
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


BEGIN
   load_h_lnk_geo_structure;
END;



select * from (
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
                AND trg.link_type_id = cls.link_type_id)
                where new_pid != old_pid;