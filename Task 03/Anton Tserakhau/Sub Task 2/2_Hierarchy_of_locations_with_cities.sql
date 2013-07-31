
    SELECT LPAD ( ' '
                , LEVEL * 2
                , ' ' )
           || SYS_CONNECT_BY_PATH ( links.child_geo_id
                                  , '/' )
              path_with_id
         , LPAD ( ' '
                , LEVEL * 2
                , ' ' )
           || SYS_CONNECT_BY_PATH ( links.description
                                  , '/' )
              path_with_names
         , links.geo_id
         , links.description
         , LEVEL
         , CASE
              WHEN LEVEL = 1 THEN 'ROOT'
              WHEN CONNECT_BY_ISLEAF = 1 THEN 'LEAF'
              ELSE 'BREANCH'
           END
              lvl
         , (    SELECT COUNT ( * )
                  FROM t_geo_object_links
            CONNECT BY parent_geo_id = PRIOR child_geo_id
            START WITH parent_geo_id = links.geo_id )
              AS count_of_childs
      FROM (SELECT *
              FROM    ( ( SELECT *
                            FROM w_geo_object_links )
                       UNION
                       ( SELECT DISTINCT NULL AS parent_geo_id
                                       , geo_id AS child_geo_id
                                       , NULL AS link_type_id
                           FROM cu_geo_systems )) idents
                   LEFT JOIN
                      ( ( SELECT DISTINCT geo_id
                                        , region_desc AS description
                            FROM cu_countries )
                       UNION
                       ( SELECT DISTINCT geo_id
                                       , region_desc
                           FROM cu_geo_regions )
                       UNION
                       ( SELECT DISTINCT geo_id
                                       , part_desc
                           FROM cu_geo_parts )
                       UNION
                       ( SELECT DISTINCT geo_id
                                       , geo_system_code
                           FROM cu_geo_systems )
                       UNION
                       ( SELECT DISTINCT geo_id
                                       , city_desc
                           FROM lc_cities )) names
                   ON idents.child_geo_id = names.geo_id) links
CONNECT BY PRIOR links.child_geo_id = links.parent_geo_id
START WITH links.parent_geo_id IS NULL;