           SELECT lcc.geo_id AS country_geo_id
       , lcc.country_id
       , lcc.country_code_a3
       , lcc.country_desc AS country_desc
       , NVL ( lcr.geo_id, -99 ) AS region_geo_id
       , NVL ( lcr.region_id, -99 ) AS region_id
       , NVL ( lcr.region_desc, 'n.d.' ) AS region_desc
       , NVL ( lcp.geo_id, -99 ) AS part_geo_id
       , NVL ( lcp.part_id, -99 ) AS part_id
       , NVL ( lcp.part_desc, 'n.d.' ) AS part_desc
    FROM (SELECT *
            FROM (    SELECT parent_geo_id AS geo_id
                           , CONNECT_BY_ROOT child_geo_id AS roo
                           , link_type_id
                        FROM t_geo_object_links gol
                  START WITH child_geo_id IN (SELECT geo_id
                                                FROM lc_countries)
                  CONNECT BY PRIOR parent_geo_id = child_geo_id) PIVOT (SUM ( geo_id )
                                                                 FOR link_type_id
                                                                 IN  (2 AS l_2
                                                                   , 3 AS l_3
                                                                   ))) piv
         LEFT JOIN lc_countries lcc
            ON piv.roo = lcc.geo_id AND lcc.localization_id = 1
         LEFT JOIN lc_geo_regions lcr
            ON lcr.geo_id = piv.l_3 AND  lcr.localization_id = 1
         LEFT JOIN lc_geo_parts lcp
            ON lcp.geo_id = piv.l_2 AND  lcp.localization_id = 1
ORDER BY roo;
