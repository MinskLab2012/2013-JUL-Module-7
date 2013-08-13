CREATE OR REPLACE PACKAGE BODY pkg_load_geo_links_actions
AS
   PROCEDURE load_geo_links_actions
   AS
      CURSOR c1
      IS
         SELECT child_geo_id
              , parent_geo_id
              , link_type_id
           FROM u_dw_references.t_geo_object_links
         MINUS
         SELECT child_geo_id
              , new_value
              , link_type_id
           FROM u_dw.t_geo_links_actions
          WHERE ( child_geo_id, link_type_id, action_dt ) IN (  SELECT child_geo_id, link_type_id
                                                       , MAX ( action_dt )
                                                    FROM u_dw.t_geo_links_actions
                                                   WHERE action_type_id = 1
                                                GROUP BY child_geo_id,link_type_id);
   BEGIN
      FOR i IN c1 LOOP
         INSERT INTO u_dw.t_geo_links_actions
              VALUES ( i.child_geo_id
                     , i.link_type_id
                     , i.parent_geo_id
                     , 1
                     , SYSDATE );
      END LOOP;

      COMMIT;
   END load_geo_links_actions;
END pkg_load_geo_links_actions;