/* Formatted on 7/31/2013 3:40:18 PM (QP5 v5.139.911.3011) */
    SELECT LPAD ( '  '
                , LEVEL * 2 - 1
                , '  ' )
           || child_geo_id
              PATH
         , SYS_CONNECT_BY_PATH ( child_geo_id
                               , '\' )
              full_path
         , LEVEL
         , CASE
              WHEN CONNECT_BY_ISLEAF = 1 THEN 'LEAF'
              WHEN LEVEL = 1 THEN 'ROOT'
              ELSE 'BRANCH'
           END
              status
         , DECODE ( CONNECT_BY_ISLEAF
                  , 1, NULL
                  , (    SELECT COUNT ( child_geo_id )
                           FROM u_dw_references.t_geo_object_links
                     START WITH parent_geo_id = mb.child_geo_id
                     CONNECT BY PRIOR child_geo_id = parent_geo_id ) )
              amount
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
              FROM u_dw_references.lc_geo_systems) mb
START WITH parent_geo_id IS NULL
CONNECT BY parent_geo_id = PRIOR child_geo_id;