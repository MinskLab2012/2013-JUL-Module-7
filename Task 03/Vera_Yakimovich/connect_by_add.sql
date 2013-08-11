           SELECT LPAD ( '  '
                       , 2 * ( LEVEL - 1 ) )
                  || child_geo_id
                     AS geo_id
                , SYS_CONNECT_BY_PATH ( child_geo_id
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
                     FROM (SELECT *
                             FROM t_geo_object_links
                           UNION ALL
                           SELECT NULL
                                , geo_id
                                , NULL
                                , null
                             FROM lc_geo_parts) gol
                          ) gol
       START WITH parent_geo_id IS NULL
       CONNECT BY PRIOR child_geo_id = parent_geo_id
ORDER SIBLINGS BY child_geo_id;
