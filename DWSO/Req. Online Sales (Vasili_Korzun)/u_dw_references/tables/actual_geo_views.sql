/* Formatted on 13.08.2013 14:49:47 (QP5 v5.139.911.3011) */
CREATE OR REPLACE VIEW v_actual_countries
AS
   SELECT *
     FROM (SELECT                                                  --countries
                 lc_countries.geo_id,
                  country_id,
                  country_code_a2,
                  country_code_a3,
                  country_desc--regions
                  ,
                  NVL (lc_geo_regions.geo_id, -99) AS region_geo_id,
                  NVL (region_id, -99) AS region_id,
                  NVL (region_code, 'n.d.') AS region_code,
                  NVL (region_desc, 'n.d.') AS region_desc--continents
                  ,
                  NVL (lc_geo_parts.geo_id, -99) AS part_geo_id,
                  NVL (part_id, -99) AS part_id,
                  NVL (part_code, 'n.d.') AS part_code,
                  NVL (part_desc, 'n.d.') AS part_desc-- geo_systems
                  ,
                  NVL (lc_geo_systems.geo_id, -99) AS geo_system_geo_id,
                  NVL (geo_system_id, -99) AS geo_system_id,
                  NVL (geo_system_code, 'n.d.') AS geo_system_code,
                  NVL (geo_system_desc, 'n.d.') AS geo_system_desc,
                  'country' AS level_code,
                  action_dt,
                  DECODE (
                     MAX (action_dt) OVER (PARTITION BY lc_countries.geo_id),
                     action_dt, 1,
                     0)
                     AS is_actual
             FROM (SELECT *
                     FROM (    SELECT CONNECT_BY_ROOT (child_geo_id) AS country,
                                      parent_geo_id,
                                      link_type_id
                                 FROM t_geo_object_links
                           CONNECT BY child_geo_id = PRIOR parent_geo_id
                           START WITH child_geo_id IN
                                         (    SELECT geo_id FROM lc_countries)) PIVOT (SUM (
                                                                                          parent_geo_id)
                                                                                FOR link_type_id
                                                                                IN  (1 AS geo_system,
                                                                                    2 AS continent,
                                                                                    3 AS region)))
                  LEFT JOIN lc_countries
                     ON country = lc_countries.geo_id
                  LEFT JOIN lc_geo_regions
                     ON region = lc_geo_regions.geo_id
                  LEFT JOIN lc_geo_parts
                     ON continent = lc_geo_parts.geo_id
                  LEFT JOIN lc_geo_systems
                     ON geo_system = lc_geo_systems.geo_id
                  left JOIN t_geo_actions
                     ON lc_countries.geo_id = t_geo_actions.geo_id)
    WHERE is_actual = 1;



CREATE OR REPLACE VIEW v_actual_regions
AS
   SELECT *
     FROM (SELECT region AS geo_id,
                   AS country_id,
                  NULL AS country_code_a2,
                  NULL AS country_code_a3,
                  NULL AS country_desc--regions
                  ,
                  NVL (lc_geo_regions.geo_id, -99) AS region_geo_id,
                  NVL (region_id, -99) AS region_id,
                  NVL (region_code, 'n.d.') AS region_code,
                  NVL (region_desc, 'n.d.') AS region_desc--continents
                  ,
                  NVL (lc_geo_parts.geo_id, -99) AS part_geo_id,
                  NVL (part_id, -99) AS part_id,
                  NVL (part_code, 'n.d.') AS part_code,
                  NVL (part_desc, 'n.d.') AS part_desc-- geo_systems
                  ,
                  NVL (lc_geo_systems.geo_id, -99) AS geo_system_geo_id,
                  NVL (geo_system_id, -99) AS geo_system_id,
                  NVL (geo_system_code, 'n.d.') AS geo_system_code,
                  NVL (geo_system_desc, 'n.d.') AS geo_system_desc,
                  'region' AS level_code,
                  action_dt,
                  DECODE (MAX (action_dt) OVER (PARTITION BY region),
                          action_dt, 1,
                          0)
                     AS is_actual
             FROM (SELECT *
                     FROM (    SELECT CONNECT_BY_ROOT (child_geo_id) AS region,
                                      parent_geo_id,
                                      link_type_id
                                 FROM t_geo_object_links
                           CONNECT BY child_geo_id = PRIOR parent_geo_id
                           START WITH child_geo_id IN
                                         (SELECT geo_id
                                            FROM lc_geo_regions)) PIVOT (SUM (
                                                                            parent_geo_id)
                                                                  FOR link_type_id
                                                                  IN  (1 AS geo_system,
                                                                      2 AS continent)))
                  LEFT JOIN lc_geo_regions
                     ON region = lc_geo_regions.geo_id
                  LEFT JOIN lc_geo_parts
                     ON continent = lc_geo_parts.geo_id
                  LEFT JOIN lc_geo_systems
                     ON geo_system = lc_geo_systems.geo_id
                  left JOIN t_geo_actions
                     ON region = t_geo_actions.geo_id)
    WHERE is_actual = 1;

CREATE OR REPLACE VIEW v_actual_geo_parts
AS
   SELECT *
     FROM (SELECT continent AS geo_id,
                  NULL AS country_id,
                  NULL AS country_code_a2,
                  NULL AS country_code_a3,
                  NULL AS country_desc--regions
                  ,
                  NULL AS region_geo_id,
                  NULL AS region_id,
                  NULL AS region_code,
                  NULL AS region_desc--continents
                  ,
                  NVL (lc_geo_parts.geo_id, -99) AS part_geo_id,
                  NVL (part_id, -99) AS part_id,
                  NVL (part_code, 'n.d.') AS part_code,
                  NVL (part_desc, 'n.d.') AS part_desc-- geo_systems
                  ,
                  NVL (lc_geo_systems.geo_id, -99) AS geo_system_geo_id,
                  NVL (geo_system_id, -99) AS geo_system_id,
                  NVL (geo_system_code, 'n.d.') AS geo_system_code,
                  NVL (geo_system_desc, 'n.d.') AS geo_system_desc,
                  'geo_part' AS level_code,
                  action_dt,
                  DECODE (MAX (action_dt) OVER (PARTITION BY continent),
                          action_dt, 1,
                          0)
                     AS is_actual
             FROM (SELECT *
                     FROM (    SELECT CONNECT_BY_ROOT (child_geo_id) AS continent,
                                      parent_geo_id,
                                      link_type_id
                                 FROM t_geo_object_links
                           CONNECT BY child_geo_id = PRIOR parent_geo_id
                           START WITH child_geo_id IN
                                         (    SELECT geo_id FROM lc_geo_parts)) PIVOT (SUM (
                                                                                          parent_geo_id)
                                                                                FOR link_type_id
                                                                                IN  (1 AS geo_system)))
                  LEFT JOIN lc_geo_parts
                     ON continent = lc_geo_parts.geo_id
                  LEFT JOIN lc_geo_systems
                     ON geo_system = lc_geo_systems.geo_id
                 left JOIN t_geo_actions
                     ON continent = t_geo_actions.geo_id)
    WHERE is_actual = 1;



CREATE OR REPLACE VIEW v_actual_geo_systems
AS
   SELECT *
     FROM (SELECT NVL (lc_geo_systems.geo_id, -99) AS geo_id,
                  NULL AS country_id,
                  NULL AS country_code_a2,
                  NULL AS country_code_a3,
                  NULL AS country_desc--regions
                  ,
                  NULL AS region_geo_id,
                  NULL AS region_id,
                  NULL AS region_code,
                  NULL AS region_desc--continents
                  ,
                  NULL AS part_geo_id,
                  NULL AS part_id,
                  NULL AS part_code,
                  NULL AS part_desc-- geo_systems
                  ,
                  NVL (lc_geo_systems.geo_id, -99) AS geo_system_geo_id,
                  NVL (geo_system_id, -99) AS geo_system_id,
                  NVL (geo_system_code, 'n.d.') AS geo_system_code,
                  NVL (geo_system_desc, 'n.d.') AS geo_system_desc,
                  'geo_system' AS level_code
                        ,          action_dt
                      ,             DECODE (                     MAX (action_dt)                        OVER (PARTITION BY lc_geo_systems.geo_id),                     action_dt, 1,                     0)                     AS is_actual
             FROM    lc_geo_systems
              left  JOIN                     t_geo_actions                  ON lc_geo_systems.geo_id = t_geo_actions.geo_id)
    WHERE is_actual = 1;


/*
select * from v_actual_countries
union
select * from v_actual_regions
union
select * from v_actual_geo_parts;
union 
select * from v_actual_geo_systems;



SELECT
geo_id,
       country_id
       ,country_code_a2
       ,country_code_a3
       ,country_desc
       ,region_id
       , region_code
       ,  region_desc
       ,  part_id
       , part_desc
       ,  geo_system_id
       ,  geo_system_code
       ,geo_system_desc
       ,  level_code
 
       FROM v_actual_countries
       MINUS
       SELECT
                                             GEO_ID,
                                      GEO_COUNTRY_ID,
                                      GEO_COUNTRY_CODE2,
                                      GEO_COUNTRY_CODE3,
                                      GEO_COUNTRY_DESC,
                                      GEO_REGION_ID,
                                      GEO_REGION_CODE,
                                      GEO_REGION_DESC,
                                      GEO_CONTINENT_ID,
                                      GEO_CONTINENT_DESC,
                                      GEO_SYSTEM_ID,
                                      GEO_SYSTEM_CODE,
                                      GEO_SYSTEM_DESC,
                                      GEO_LEVEL_CODE FROM sal_star.dim_geo_locations_scd;
                                      */