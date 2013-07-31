SELECT 
       --country
       table_hier.country_geo_id as country_geo_id
     , cntr.country_id
     , CNTR.COUNTRY_CODE_A2
     , cntr.country_code_a3
     , cntr.region_desc AS country_desc
     --region
     , NVL ( table_hier.region_geo_id, -99 ) AS region_geo_id
     , NVL ( reg.src_continent_id, -99 ) AS region_id
     , NVL ( reg.region_code, 'n.d.' ) AS region_code
     , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
     -- part
     , NVL ( table_hier.part_geo_id, -99 ) AS part_geo_id
     , NVL ( part.part_id, -99 ) AS part_id
     , NVL ( part.part_code, 'n.d.' ) AS part_code
     , NVL ( part.part_desc, 'n.d.' ) AS part_desc
     -- geo_systems
     , NVL ( table_hier.system_geo_id, -99 ) AS geo_system_geo_id
     , NVL ( g_sys.src_geo_system_id, -99 ) AS geo_system_id
     , NVL ( g_sys.geo_system_code, 'n.d.' ) AS geo_system_code
     , NVL ( g_sys.geo_system_desc, 'n.d.' ) AS geo_system_desc
     -- sub_groups
     , NVL ( table_hier.sub_group_geo_id, -99 ) AS sub_group_geo_id
     , NVL ( sub_grp.sub_group_id, -99 ) AS sub_group_id
     , NVL ( sub_grp.sub_group_code, 'n.d.' ) AS sub_group_code
     , NVL ( sub_grp.sub_group_desc, 'n.d.' ) AS sub_group_desc
     -- groups
     , NVL ( table_hier.group_geo_id, -99 ) AS group_geo_id
     , NVL ( grp.GROUP_ID, -99 ) AS GROUP_ID
     , NVL ( grp.group_code, 'n.d.' ) AS group_code
     , NVL ( grp.group_desc, 'n.d.' ) AS group_desc
     -- group system
     , NVL ( table_hier.group_system_geo_id, -99 ) AS group_system_geo_id
     , NVL ( grp_sys.grp_system_id, -99 ) AS group_system_id
     , NVL ( grp_sys.grp_system_code, 'n.d.' ) AS group_system_code
     , NVL ( grp_sys.grp_system_desc, 'n.d.' ) AS group_system_desc
  --
  FROM (  SELECT country_geo_id
               , SUM ( region_geo_id ) region_geo_id
               , SUM ( part_geo_id ) part_geo_id
               , SUM ( system_geo_id ) system_geo_id
               , SUM ( sub_group_geo_id ) sub_group_geo_id
               , SUM ( group_geo_id ) group_geo_id
               , SUM ( group_system_geo_id ) group_system_geo_id
            FROM (    SELECT DISTINCT
                             CONNECT_BY_ROOT ( links.child_geo_id ) country_geo_id
                           , links.parent_geo_id
                           , links.link_type_id
                           , CASE WHEN ( links.link_type_id = 3 ) THEN links.parent_geo_id ELSE NULL END AS region_geo_id
                           , CASE WHEN ( links.link_type_id = 2 ) THEN links.parent_geo_id ELSE NULL END AS part_geo_id
                           , CASE WHEN ( links.link_type_id = 1 ) THEN links.parent_geo_id ELSE NULL END AS system_geo_id
                           , CASE WHEN ( links.link_type_id = 6 ) THEN links.parent_geo_id ELSE NULL END AS sub_group_geo_id
                           , CASE WHEN ( links.link_type_id = 5 ) THEN links.parent_geo_id ELSE NULL END AS group_geo_id
                           , CASE WHEN ( links.link_type_id = 4 ) THEN links.parent_geo_id ELSE NULL END
                                AS group_system_geo_id
                           , LEVEL
                        FROM u_dw_references.w_geo_object_links links
                  CONNECT BY PRIOR links.parent_geo_id = links.child_geo_id
                  START WITH links.child_geo_id IN (SELECT DISTINCT geo_id
                                                      FROM u_dw_references.cu_countries)
                    ORDER BY country_geo_id)
        GROUP BY country_geo_id) table_hier
       LEFT JOIN u_dw_references.cu_countries cntr
          ON cntr.geo_id = table_hier.country_geo_id
       LEFT JOIN u_dw_references.cu_geo_regions reg
          ON reg.geo_id = table_hier.region_geo_id
       LEFT JOIN u_dw_references.cu_geo_parts part
          ON part.geo_id = table_hier.part_geo_id
       LEFT JOIN u_dw_references.cu_geo_systems g_sys
          ON g_sys.geo_id = table_hier.system_geo_id
       LEFT JOIN u_dw_references.cu_cntr_group_systems grp_sys
          ON grp_sys.geo_id = table_hier.group_system_geo_id
       LEFT JOIN u_dw_references.cu_cntr_groups grp
          ON grp.geo_id = table_hier.group_geo_id
       LEFT JOIN u_dw_references.cu_cntr_sub_groups sub_grp
          ON sub_grp.geo_id = table_hier.sub_group_geo_id