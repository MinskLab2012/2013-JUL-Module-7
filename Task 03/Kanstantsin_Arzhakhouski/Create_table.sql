/* Formatted on 7/31/2013 4:11:36 PM (QP5 v5.139.911.3011) */
CREATE TABLE denormal_export_table
AS
   SELECT --+USE_HASH(src reg part g_sys sub_grp grp grp_sys)
         country_geo_id
        , cntr.country_id
        , cntr.country_code_a3
        , cntr.region_desc country_desc
        , NVL ( g_region_id, -99 ) region_geo_id
        , NVL ( reg.src_continent_id, -99 ) region_id
        , NVL ( reg.region_code, 'n.d.' ) region_code
        , NVL ( reg.region_desc, 'n.d.' ) region_desc
        , NVL ( g_part_id, -99 ) part_geo_id
        , NVL ( part.part_id, -99 ) part_id
        , NVL ( part.part_code, 'n.d.' ) part_code
        , NVL ( part.part_desc, 'n.d.' ) part_desc
        , NVL ( g_system_id, -99 ) geo_system_geo_id
        , NVL ( g_sys.src_geo_system_id, -99 ) geo_system_id
        , NVL ( g_sys.geo_system_code, 'n.d.' ) geo_system_code
        , NVL ( g_sys.geo_system_desc, 'n.d.' ) geo_system_desc
        , NVL ( grp_item, -99 ) sub_group_geo_id
        , NVL ( sub_grp.sub_group_id, -99 ) sub_group_id
        , NVL ( sub_grp.sub_group_code, 'n.d.' ) sub_group_code
        , NVL ( sub_grp.sub_group_desc, 'n.d.' ) sub_group_desc
        , NVL ( grp_group, -99 ) group_geo_id
        , NVL ( grp.GROUP_ID, -99 ) GROUP_ID
        , NVL ( grp.group_code, 'n.d.' ) group_code
        , NVL ( grp.group_desc, 'n.d.' ) group_desc
        , NVL ( grp_sys, -99 ) grp_system_geo_id
        , NVL ( grp_sys.grp_system_id, -99 ) grp_system_id
        , NVL ( grp_sys.grp_system_code, 'n.d.' ) grp_system_code
        , NVL ( grp_sys.grp_system_desc, 'n.d.' ) grp_system_desc
     FROM (  SELECT country_geo_id
                  , SUM ( g_region_id ) AS g_region_id
                  , SUM ( g_part_id ) AS g_part_id
                  , SUM ( g_system_id ) AS g_system_id
                  , SUM ( grp_item ) AS grp_item
                  , SUM ( grp_group ) AS grp_group
                  , SUM ( grp_sys ) AS grp_sys
               FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS country_geo_id
                              , parent_geo_id
                              , DECODE ( link_type_id, 3, parent_geo_id ) AS g_region_id
                              , DECODE ( link_type_id, 2, parent_geo_id ) AS g_part_id
                              , DECODE ( link_type_id, 1, parent_geo_id ) AS g_system_id
                              , DECODE ( link_type_id, 6, parent_geo_id ) AS grp_item
                              , DECODE ( link_type_id, 5, parent_geo_id ) AS grp_group
                              , DECODE ( link_type_id, 4, parent_geo_id ) AS grp_sys
                           FROM u_dw_references.w_geo_object_links
                     CONNECT BY PRIOR parent_geo_id = child_geo_id
                     START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                   FROM u_dw_references.cu_countries))
           GROUP BY country_geo_id) src
          LEFT JOIN u_dw_references.cu_countries cntr
             ON cntr.geo_id = src.country_geo_id
          LEFT JOIN u_dw_references.cu_geo_regions reg
             ON reg.geo_id = src.g_region_id
          LEFT JOIN u_dw_references.cu_geo_parts part
             ON part.geo_id = src.g_part_id
          LEFT JOIN u_dw_references.cu_geo_systems g_sys
             ON g_sys.geo_id = src.g_system_id
          LEFT JOIN u_dw_references.cu_cntr_group_systems grp_sys
             ON grp_sys.geo_id = src.grp_sys
          LEFT JOIN u_dw_references.cu_cntr_groups grp
             ON grp.geo_id = src.grp_group
          LEFT JOIN u_dw_references.cu_cntr_sub_groups sub_grp
             ON sub_grp.geo_id = src.grp_item;