 SELECT LPAD ( '  '
                       , LEVEL * 2 - 1
                       , '  ' )
                  || child_geo_id
                     AS geo_id
                , SYS_CONNECT_BY_PATH ( child_geo_id
                                      , '-' )
                     AS PATH
                , link_type_id
                , CASE
                     WHEN LEVEL = 1 THEN 'ROOT'
                     WHEN CONNECT_BY_ISLEAF = 1 THEN 'LEAF'
                     ELSE 'BRANCH'
                  END
                     AS "LEVEL"
                , CASE
                     WHEN CONNECT_BY_ISLEAF = 1 THEN
                        NULL
                     ELSE
                        (    SELECT COUNT ( child_geo_id )
                               FROM u_dw_references.t_geo_object_links
                         START WITH parent_geo_id = t1.child_geo_id
                         CONNECT BY PRIOR child_geo_id = parent_geo_id )
                  END
                     count_of_childs
             FROM (SELECT *
                     FROM u_dw_references.t_geo_object_links
                   UNION
                   SELECT NULL
                        , geo_id
                        , NULL
                     FROM u_dw_references.lc_cntr_group_systems
                   UNION
                   SELECT NULL
                        , geo_id
                        , NULL
                     FROM u_dw_references.lc_geo_systems) t1
       START WITH parent_geo_id IS NULL
       CONNECT BY PRIOR child_geo_id = parent_geo_id
ORDER SIBLINGS BY child_geo_id;