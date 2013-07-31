SELECT lcc.geo_id AS country_geo_id
       , lcc.country_id
       , lcc.country_code_a3
       , lcc.country_desc AS country_desc
       , NVL ( lcr.geo_id, -99 ) AS region_geo_id
       , NVL ( lcr.region_id, -99 ) AS region_id
       , NVL ( lcr.region_code, 'n.d.' ) AS region_code
       , NVL ( lcr.region_desc, 'n.d.' ) AS region_desc
       , NVL ( lcp.geo_id, -99 ) AS part_geo_id
       , NVL ( lcp.part_id, -99 ) AS part_id
       , NVL ( lcp.part_code, 'n.d.' ) AS part_code
       , NVL ( lcp.part_desc, 'n.d.' ) AS part_desc
       , NVL ( lcs.geo_id, -99 ) AS geo_system_geo_id
       , NVL ( lcs.geo_id, -99 ) AS geo_system_id
       , NVL ( lcs.geo_system_code, 'n.d.' ) AS geo_system_code
       , NVL ( lcs.geo_system_desc, 'n.d.' ) AS geo_system_desc
       , NVL ( lcsg.geo_id, -99 ) AS sub_group_geo_id
       , NVL ( lcsg.sub_group_id, -99 ) AS sub_group_id
       , NVL ( lcsg.sub_group_code, 'n.d.' ) AS sub_group_code
       , NVL ( lcsg.sub_group_desc, 'n.d.' ) AS sub_group_desc
       , NVL ( lcg.geo_id, -99 ) AS group_geo_id
       , NVL ( lcg.GROUP_ID, -99 ) AS GROUP_ID
       , NVL ( lcg.group_code, 'n.d.' ) AS group_code
       , NVL ( lcg.group_desc, 'n.d.' ) AS group_desc
       , NVL ( lcgs.geo_id, -99 ) AS grp_system_geo_id
       , NVL ( lcgs.grp_system_id, -99 ) AS grp_system_id
       , NVL ( lcgs.grp_system_code, 'n.d.' ) AS grp_system_code
       , NVL ( lcgs.grp_system_desc, 'n.d.' ) AS grp_system_desc
    FROM (SELECT *
            FROM (    SELECT parent_geo_id AS geo_id
                           , CONNECT_BY_ROOT child_geo_id AS roo
                           , link_type_id
                        FROM t_geo_object_links gol
                  START WITH child_geo_id IN (SELECT geo_id
                                                FROM lc_countries)
                  CONNECT BY PRIOR parent_geo_id = child_geo_id) PIVOT (SUM ( geo_id )
                                                                 FOR link_type_id
                                                                 IN  (1 AS l_1
                                                                   , 2 AS l_2
                                                                   , 3 AS l_3
                                                                   , 4 AS l_4
                                                                   , 5 AS l_5
                                                                   , 6 AS l_6))) piv
         LEFT JOIN lc_countries lcc
            ON piv.roo = lcc.geo_id
         LEFT JOIN lc_geo_regions lcr
            ON lcr.geo_id = piv.l_3
         LEFT JOIN lc_geo_parts lcp
            ON lcp.geo_id = piv.l_2
         LEFT JOIN lc_geo_systems lcs
            ON piv.l_1 = lcs.geo_id
         LEFT JOIN lc_cntr_sub_groups lcsg
            ON piv.l_4 = lcsg.geo_id
         LEFT JOIN lc_cntr_groups lcg
            ON piv.l_5 = lcg.geo_id
         LEFT JOIN lc_cntr_group_systems lcgs
            ON piv.l_6 = lcgs.geo_id
ORDER BY roo;