
CREATE VIEW view_dim_geo_country
AS
     SELECT --country
           ROWNUM AS surr_id
          , table_hier.country_geo_id AS country_geo_id
          , cntr.country_id
          , cntr.country_code_a2
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
          --TA
          , table_hier.from_dt
          , table_hier.to_dt
          , table_hier.status
       FROM (  SELECT country_geo_links.country_geo_id
                    , country_geo_links.region_geo_id
                    , SUM ( region_geo_links.part_geo_id ) AS part_geo_id
                    , SUM ( region_geo_links.system_geo_id ) AS system_geo_id
                    , country_geo_links.from_dt
                    , country_geo_links.to_dt
                    , country_geo_links.status
                 FROM    (    SELECT DISTINCT
                                     CONNECT_BY_ROOT ( links.child_geo_id ) country_geo_id
                                   , CASE WHEN ( links.link_type_id = 3 ) THEN links.parent_geo_id ELSE NULL END
                                        AS region_geo_id
                                   , links.from_dt
                                   , links.to_dt
                                   , CASE WHEN ( links.to_dt IS NULL ) THEN 'Actual data' ELSE 'Old data' END AS status
                                FROM (SELECT t_act_old.parent_geo_id_new AS parent_geo_id
                                           , t_act_old.child_geo_id
                                           , t_act_old.link_type_id
                                           , t_act_old.action_dt AS from_dt
                                           , t_act_new.action_dt AS to_dt
                                        FROM    t_actions t_act_old
                                             LEFT JOIN
                                                t_actions t_act_new
                                             ON ( t_act_old.parent_geo_id_new = t_act_new.parent_geo_id_old
                                             AND t_act_old.child_geo_id = t_act_new.child_geo_id
                                             AND t_act_old.link_type_id = t_act_new.link_type_id )) links
                          CONNECT BY PRIOR links.parent_geo_id = links.child_geo_id
                          START WITH links.child_geo_id IN (SELECT DISTINCT geo_id
                                                              FROM u_dw_references.cu_countries)
                            ORDER BY country_geo_id) country_geo_links
                      LEFT JOIN
                         (    SELECT DISTINCT
                                     CONNECT_BY_ROOT ( links.child_geo_id ) region_geo_id
                                   , CASE WHEN ( links.link_type_id = 2 ) THEN links.parent_geo_id ELSE NULL END AS part_geo_id
                                   , CASE WHEN ( links.link_type_id = 1 ) THEN links.parent_geo_id ELSE NULL END
                                        AS system_geo_id
                                FROM u_dw_references.t_geo_object_links links
                          CONNECT BY PRIOR links.parent_geo_id = links.child_geo_id
                          START WITH links.child_geo_id IN (SELECT DISTINCT geo_id
                                                              FROM u_dw_references.cu_geo_regions)
                            ORDER BY region_geo_id) region_geo_links
                      ON country_geo_links.region_geo_id = region_geo_links.region_geo_id
                WHERE country_geo_links.region_geo_id IS NOT NULL
             GROUP BY country_geo_links.country_geo_id
                    , country_geo_links.region_geo_id
                    , country_geo_links.from_dt
                    , country_geo_links.to_dt
                    , country_geo_links.status) table_hier
            LEFT JOIN u_dw_references.cu_countries cntr
               ON cntr.geo_id = table_hier.country_geo_id
            LEFT JOIN u_dw_references.cu_geo_regions reg
               ON reg.geo_id = table_hier.region_geo_id
            LEFT JOIN u_dw_references.cu_geo_parts part
               ON part.geo_id = table_hier.part_geo_id
            LEFT JOIN u_dw_references.cu_geo_systems g_sys
               ON g_sys.geo_id = table_hier.system_geo_id
   ORDER BY 1;