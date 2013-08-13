CREATE OR REPLACE PACKAGE BODY pkg_etl_geo_act_dw_ext_ref
AS

   -- Load All Dish Types
   PROCEDURE load_geo_actions
   AS
   BEGIN
      
	MERGE INTO u_dw_references.t_actions trg
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
                                       FROM u_dw_ext_references.cls_geo_structure_iso3166) cls
                                  , u_dw_references.w_geo_objects p_obj
                                  , u_dw_references.w_geo_objects c_obj
                              WHERE cls.parent_code IS NOT NULL
                                AND p_obj.geo_code_id = cls.parent_code
                                AND p_obj.geo_type_id < cls.type_id
                                AND c_obj.geo_code_id = cls.child_code
                                AND c_obj.geo_type_id = cls.type_id )
                          UNION ALL
                          ( SELECT reg.geo_id AS parent_geo_id
                                 , cntr.geo_id AS child_geo_id
                                 , 3 AS link_type_id
                              FROM cls_cntr2structure_iso3166 cls
                                 , u_dw_references.w_countries cntr
                                 , u_dw_references.w_geo_regions reg
                             WHERE cls.country_id = cntr.country_id
                               AND cls.structure_code = reg.region_id )) tbl
                      LEFT JOIN (SELECT t_actions.parent_geo_id_new as PARENT_GEO_ID
     , act_data.child_geo_id
     , act_data.link_type_id
  FROM    (  SELECT MAX ( action_dt ) AS action_dt
                  , child_geo_id
                  , link_type_id
               FROM u_dw_references.t_actions
           GROUP BY child_geo_id
                  , link_type_id) act_data
       LEFT JOIN
          u_dw_references.t_actions
       ON u_dw_references.t_actions.action_dt = act_data.action_dt
      AND u_dw_references.t_actions.child_geo_id = act_data.child_geo_id
      AND u_dw_references.t_actions.link_type_id = act_data.link_type_id) lnk
                      ON ( tbl.child_geo_id = lnk.child_geo_id
                      AND tbl.link_type_id = lnk.link_type_id )) cls
           ON ( trg.parent_geo_id_new = cls.parent_geo_id_new
           AND trg.child_geo_id = cls.child_geo_id 
           and trg.link_type_id=cls.link_type_id)
   WHEN NOT MATCHED THEN
      INSERT            ( action_id
                        , child_geo_id
                        ,link_type_id
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



END pkg_etl_geo_act_dw_ext_ref;
/