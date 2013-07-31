/* Formatted on 7/31/2013 4:05:16 PM (QP5 v5.139.911.3011) */
CREATE TABLE denormalized_geo
AS
   SELECT root
        , country_id
        , country_code_a3
        , region_desc AS country_desc
        --region
        , NVL ( l_3, -99 ) AS region_geo_id
        , NVL ( region_code, 'n.d.' ) AS region_code
        , NVL ( region_desc, 'n.d.' ) AS region_desc
        -- part
        , NVL ( l_2, -99 ) AS part_geo_id
        , NVL ( part_id, -99 ) AS part_id
        , NVL ( part_code, 'n.d.' ) AS part_code
        , NVL ( part_desc, 'n.d.' ) AS part_desc
        -- geo_systems
        , NVL ( l_1, -99 ) AS geo_system_geo_id
        , NVL ( geo_system_code, 'n.d.' ) AS geo_system_code
        , NVL ( geo_system_desc, 'n.d.' ) AS geo_system_desc
        -- group_items
        , NVL ( l_6, -99 ) AS sub_group_geo_id
        , NVL ( sub_group_id, -99 ) AS sub_group_id
        , NVL ( sub_group_code, 'n.d.' ) AS sub_group_code
        , NVL ( sub_group_desc, 'n.d.' ) AS sub_group_desc
        -- groups
        , NVL ( l_5, -99 ) AS group_geo_id
        , NVL ( GROUP_ID, -99 ) AS GROUP_ID
        , NVL ( group_code, 'n.d.' ) AS group_code
        , NVL ( group_desc, 'n.d.' ) AS group_desc
        -- group system
        , NVL ( l_4, -99 ) AS grp_system_geo_id
        , NVL ( grp_system_id, -99 ) AS grp_system_id
        , NVL ( grp_system_code, 'n.d.' ) AS grp_system_code
        , NVL ( grp_system_desc, 'n.d.' ) AS grp_system_desc
     FROM ( ( SELECT *
                FROM (    SELECT parent_geo_id AS geo_id
                               , CONNECT_BY_ROOT child_geo_id AS root
                               , link_type_id
                            FROM u_dw_references.t_geo_object_links
                      START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                    FROM u_dw_references.lc_countries)
                      CONNECT BY PRIOR parent_geo_id = child_geo_id) PIVOT (MAX ( geo_id )
                                                                     FOR link_type_id
                                                                     IN  (1 AS l_1
                                                                       , 2 AS l_2
                                                                       , 3 AS l_3
                                                                       , 4 AS l_4
                                                                       , 5 AS l_5
                                                                       , 6 AS l_6))
                     LEFT JOIN u_dw_references.lc_countries lc
                        ON ( root = lc.geo_id )
                     LEFT JOIN u_dw_references.lc_geo_regions reg
                        ON ( l_3 = reg.geo_id )
                     LEFT JOIN u_dw_references.lc_geo_parts par
                        ON ( l_2 = par.geo_id )
                     LEFT JOIN u_dw_references.lc_geo_systems sys
                        ON ( l_1 = sys.geo_id )
                     LEFT JOIN (SELECT *
                                  FROM u_dw_references.cu_cntr_group_systems
                                UNION
                                SELECT geo_id * 2
                                     , grp_system_id
                                     , grp_system_code
                                     , grp_system_desc
                                     , localization_id
                                  FROM u_dw_references.cu_cntr_group_systems) gr_sys
                        ON ( l_4 = gr_sys.geo_id )
                     LEFT JOIN u_dw_references.cu_cntr_groups cu
                        ON ( l_5 = cu.geo_id )
                     LEFT JOIN u_dw_references.cu_cntr_sub_groups sub
                        ON ( l_6 = sub.geo_id ) ));

CREATE TABLE path_table
AS
       SELECT SYS_CONNECT_BY_PATH ( child_geo_id
                                  , '\' )
                 geo_path
            , child_geo_id
            , LEVEL AS "level"
            , CONNECT_BY_ROOT child_geo_id AS root
            , CASE
                 WHEN CONNECT_BY_ISLEAF = 1 THEN 'LEAF'
                 WHEN LEVEL = 1 THEN 'ROOT'
                 ELSE 'BRANCH'
              END
                 AS status
            , DECODE ( CONNECT_BY_ISLEAF
                     , 1, NULL
                     , (    SELECT COUNT ( child_geo_id )
                              FROM u_dw_references.t_geo_object_links
                        START WITH parent_geo_id = mb.child_geo_id
                        CONNECT BY PRIOR child_geo_id = parent_geo_id ) )
                 child_count
         FROM (SELECT *
                 FROM u_dw_references.t_geo_object_links
               UNION
               SELECT NULL
                    , geo_id
                    , NULL
                 FROM u_dw_references.lc_cntr_group_systems) mb
   START WITH parent_geo_id IS NULL
   CONNECT BY parent_geo_id = PRIOR child_geo_id;