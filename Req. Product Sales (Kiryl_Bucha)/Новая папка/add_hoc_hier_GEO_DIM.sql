SELECT --+USE_HASH(src reg part g_sys sub_grp grp grp_sys)
       --country
       country_geo_id
     , cntr.country_id
     , cntr.country_code_a3
     , cntr.region_desc AS country_desc
     --region
     , NVL ( g_region_id, -99 ) AS region_geo_id
     , NVL ( reg.src_continent_id, -99 ) AS region_id
     , NVL ( reg.region_code, 'n.d.' ) AS region_code
     , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
     -- part
     , NVL ( g_part_id, -99 ) AS part_geo_id
     , NVL ( part.part_id, -99 ) AS part_id
     , NVL ( part.part_code, 'n.d.' ) AS part_code
     , NVL ( part.part_desc, 'n.d.' ) AS part_desc
     -- geo_systems
     , NVL ( g_system_id, -99 ) AS geo_system_geo_id
     , NVL ( g_sys.src_geo_system_id, -99 ) AS geo_system_id
     , NVL ( g_sys.geo_system_code, 'n.d.' ) AS geo_system_code
     , NVL ( g_sys.geo_system_desc, 'n.d.' ) AS geo_system_desc
     -- group_items
     , NVL ( grp_item, -99 ) AS sub_group_geo_id
     , NVL ( sub_grp.sub_group_id, -99 ) AS sub_group_id
     , NVL ( sub_grp.sub_group_code, 'n.d.' ) AS sub_group_code
     , NVL ( sub_grp.sub_group_desc, 'n.d.' ) AS sub_group_desc
     -- groups
     , NVL ( grp_group, -99 ) AS group_geo_id
     , NVL ( grp.GROUP_ID, -99 ) AS GROUP_ID
     , NVL ( grp.group_code, 'n.d.' ) AS group_code
     , NVL ( grp.group_desc, 'n.d.' ) AS group_desc
     -- group system
     , NVL ( grp_sys, -99 ) AS grp_system_geo_id
     , NVL ( grp_sys.grp_system_id, -99 ) AS grp_system_id
     , NVL ( grp_sys.grp_system_code, 'n.d.' ) AS grp_system_code
     , NVL ( grp_sys.grp_system_desc, 'n.d.' ) AS grp_system_desc
  --
  FROM (  SELECT country_geo_id
               , SUM ( g_region_id ) AS g_region_id
               , SUM ( g_part_id ) AS g_part_id
               , SUM ( g_system_id ) AS g_system_id
               , SUM ( grp_item ) AS grp_item
               , SUM ( grp_group ) AS grp_group
               , SUM ( grp_sys ) AS grp_sys
            FROM (    SELECT CONNECT_BY_ROOT ( c.child_geo_id ) AS country_geo_id
                           , parent_geo_id
                           , DECODE ( LEVEL, 1, parent_geo_id ) AS g_region_id
                           , DECODE ( LEVEL, 2, parent_geo_id ) AS g_part_id
                           , DECODE ( LEVEL, 3, parent_geo_id ) AS g_system_id
                           , NULL AS grp_item
                           , NULL AS grp_group
                           , NULL AS grp_sys
                        FROM (SELECT parent_geo_id
                                   , child_geo_id
                                FROM u_dw_references.w_geo_object_links
                               WHERE link_type_id IN (1, 2, 3)) c
                  CONNECT BY PRIOR parent_geo_id = child_geo_id
                  START WITH child_geo_id IN (    SELECT DISTINCT geo_id FROM u_dw_references.cu_countries)
                  UNION ALL
                      SELECT CONNECT_BY_ROOT ( c.child_geo_id ) AS country_geo_id
                           , parent_geo_id
                           , NULL AS g_region_id
                           , NULL AS g_part_id
                           , NULL AS g_system_id
                           , DECODE ( LEVEL, 1, parent_geo_id ) AS grp_item
                           , DECODE ( LEVEL, 2, parent_geo_id ) AS grp_group
                           , DECODE ( LEVEL, 3, parent_geo_id ) AS grp_sys
                        FROM (SELECT parent_geo_id
                                   , child_geo_id
                                FROM u_dw_references.w_geo_object_links
                               WHERE link_type_id IN (4, 5, 6)) c
                  CONNECT BY PRIOR parent_geo_id = child_geo_id
                  START WITH child_geo_id IN (    SELECT DISTINCT geo_id FROM u_dw_references.cu_countries))
        GROUP BY country_geo_id) src
     , u_dw_references.cu_countries cntr
     , u_dw_references.cu_geo_regions reg
     , u_dw_references.cu_geo_parts part
     , u_dw_references.cu_geo_systems g_sys
     , u_dw_references.cu_cntr_group_systems grp_sys
     , u_dw_references.cu_cntr_groups grp
     , u_dw_references.cu_cntr_sub_groups sub_grp
 WHERE cntr.geo_id(+) = src.country_geo_id
   AND reg.geo_id(+) = src.g_region_id
   AND part.geo_id(+) = src.g_part_id
   AND g_sys.geo_id(+) = src.g_system_id
   AND grp_sys.geo_id(+) = src.grp_sys
   AND grp.geo_id(+) = src.grp_group
   AND sub_grp.geo_id(+) = src.grp_item