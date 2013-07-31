
-- prepared dimension table

WITH country_ids AS (SELECT geo_id
                       FROM lc_countries)
SELECT --countries
      lc_countries.geo_id
     , country_id
     , country_code_a2
     , country_code_a3
     , country_desc
     --regions
     , NVL ( lc_geo_regions.geo_id, -99 ) AS region_geo_id
     , NVL ( region_id, -99 ) AS region_id
     , NVL ( region_code, 'n.d.' ) AS region_code
     , NVL ( region_desc, 'n.d.' ) AS region_desc
     --continents
     , NVL ( lc_geo_parts.geo_id, -99 ) AS part_geo_id
     , NVL ( part_id, -99 ) AS part_id
     , NVL ( part_code, 'n.d.' ) AS part_code
     , NVL ( part_desc, 'n.d.' ) AS part_desc
     -- geo_systems
     , NVL ( lc_geo_systems.geo_id, -99 ) AS geo_system_geo_id
     , NVL ( geo_system_id, -99 ) AS geo_system_id
     , NVL ( geo_system_code, 'n.d.' ) AS geo_system_code
     , NVL ( geo_system_desc, 'n.d.' ) AS geo_system_desc
     -- sub_groups
     , NVL ( lc_cntr_sub_groups.geo_id, -99 ) AS sub_group_geo_id
     , NVL ( sub_group_id, -99 ) AS sub_group_id
     , NVL ( sub_group_code, 'n.d.' ) AS sub_group_code
     , NVL ( sub_group_desc, 'n.d.' ) AS sub_group_desc
     -- groups
     , NVL ( lc_cntr_groups.geo_id, -99 ) AS group_geo_id
     , NVL ( GROUP_ID, -99 ) AS GROUP_ID
     , NVL ( group_code, 'n.d.' ) AS group_code
     , NVL ( group_desc, 'n.d.' ) AS group_desc
     -- group systems
     , NVL ( lc_cntr_group_systems.geo_id, -99 ) AS grp_system_geo_id
     , NVL ( grp_system_id, -99 ) AS grp_system_id
     , NVL ( grp_system_code, 'n.d.' ) AS grp_system_code
     , NVL ( grp_system_desc, 'n.d.' ) AS grp_system_desc
  FROM (SELECT *
          FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS country
                         , parent_geo_id
                         , link_type_id
                      FROM t_geo_object_links
                CONNECT BY child_geo_id = PRIOR parent_geo_id
                START WITH child_geo_id IN (SELECT *
                                              FROM country_ids)) PIVOT (SUM ( parent_geo_id )
                                                                 FOR link_type_id
                                                                 IN  (1 AS geo_system
                                                                   , 2 AS continent
                                                                   , 3 AS region
                                                                   , 4 AS group_system
                                                                   , 5 AS country_group
                                                                   , 6 AS country_subgroup)))
       LEFT JOIN lc_countries
          ON country = lc_countries.geo_id
       LEFT JOIN lc_geo_regions
          ON region = lc_geo_regions.geo_id
       LEFT JOIN lc_geo_parts
          ON continent = lc_geo_parts.geo_id
       LEFT JOIN lc_geo_systems
          ON geo_system = lc_geo_systems.geo_id
       LEFT JOIN lc_cntr_sub_groups
          ON country_subgroup = lc_cntr_sub_groups.geo_id
       LEFT JOIN lc_cntr_groups
          ON country_group = lc_cntr_groups.geo_id
       LEFT JOIN lc_cntr_group_systems
          ON group_system = lc_cntr_group_systems.geo_id;


-- physical and logical locations hierarchy with level and count of siblings

  SELECT geo_path
       , link_type_id
       , DECODE ( lvl,  0, 'root',  1, 'branch',  2, 'branch',  3, 'leaf' ) AS lvl
       , DECODE ( lvl
                , 3, NULL
                , (    SELECT COUNT ( * )
                         FROM t_geo_object_links
                   CONNECT BY parent_geo_id = PRIOR child_geo_id
                   START WITH parent_geo_id = hier.geo_id ) )
            AS siblings_cnt
    FROM (    SELECT CONNECT_BY_ROOT parent_geo_id
                     || SYS_CONNECT_BY_PATH ( child_geo_id
                                            , '->' )
                        AS geo_path
                   , child_geo_id AS geo_id
                   , link_type_id
                   , LEVEL AS lvl
                FROM t_geo_object_links
          CONNECT BY PRIOR child_geo_id = parent_geo_id
          START WITH parent_geo_id IN (
                                       SELECT geo_id -- physical hierarchy
                                         FROM t_geo_systems
                                       UNION ALL
                                       SELECT geo_id --logical hierarchy
                                         FROM lc_cntr_group_systems)
          UNION ALL
          ( SELECT TO_CHAR ( geo_id ) AS geo_path
                 , geo_id AS geo_id
                 , 0 AS link_type_id
                 , 0 AS lvl
              FROM t_geo_systems )
              union all 
              SELECT TO_CHAR ( geo_id ) AS geo_path
                 , geo_id AS geo_id
                 , 0 AS link_type_id
                 , 0 AS lvl
              FROM lc_cntr_group_systems) hier
ORDER BY geo_path;
