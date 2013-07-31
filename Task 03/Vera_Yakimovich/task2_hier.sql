           SELECT LPAD ( '  '
                       , 2 * ( LEVEL - 1 ) )
                  || child_geo_desc
                     AS geo_id
                , SYS_CONNECT_BY_PATH ( child_geo_desc
                                      , '->' )
                     AS PATH
                , CASE
                     WHEN CONNECT_BY_ROOT child_geo_id = child_geo_id THEN 'root'
                     WHEN CONNECT_BY_ISLEAF = 1 THEN 'leaf'
                     ELSE 'branch'
                  END
                     AS roo
                , DECODE ( CONNECT_BY_ISLEAF
                         , 1, NULL
                         , (    SELECT COUNT ( child_geo_id )
                                  FROM t_geo_object_links
                            START WITH parent_geo_id = gol.child_geo_id
                            CONNECT BY PRIOR child_geo_id = parent_geo_id ) )
                     AS co
             FROM (SELECT gol.child_geo_id
                        , gol.parent_geo_id
                        , link_type_id
                        , CASE
                             WHEN geo_type_id = 10 THEN lcp.part_desc
                             WHEN geo_type_id = 11 THEN lcr.region_desc
                             WHEN geo_type_id = 12 THEN lcc.country_desc
                          END
                             AS child_geo_desc
                     FROM (SELECT *
                             FROM t_geo_object_links
                           UNION ALL
                           SELECT NULL
                                , geo_id
                                , NULL
                             FROM lc_geo_parts) gol
                          LEFT JOIN t_geo_objects gob
                             ON gol.child_geo_id = gob.geo_id
                          LEFT JOIN lc_countries lcc
                             ON gol.child_geo_id = lcc.geo_id
                            AND lcc.localization_id = (:loc_param)
                          LEFT JOIN lc_geo_regions lcr
                             ON lcr.geo_id = gol.child_geo_id
                            AND lcr.localization_id = (:loc_param)
                          LEFT JOIN lc_geo_parts lcp
                             ON lcp.geo_id = gol.child_geo_id
                            AND lcp.localization_id = (:loc_param)) gol
       START WITH parent_geo_id IS NULL
       CONNECT BY PRIOR child_geo_id = parent_geo_id
ORDER SIBLINGS BY child_geo_id;