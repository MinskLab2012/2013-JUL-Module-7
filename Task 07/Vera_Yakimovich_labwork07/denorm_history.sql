 WITH piv AS (SELECT *
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
                                                                   )))           
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
      , TO_CHAR(TRUNC( NVL( ( SELECT max(action_dt) FROM t_actions tac WHERE tac.geo_id = piv.roo ), gol.insert_dt ) ) , 'DD-MON-YY') as VALID_FROM
      , TO_CHAR(TRUNC(sysdate) ,'DD-MON-YY') AS VALID_TO
      , 'Y' AS IS_ACTUAL
    FROM piv
         LEFT JOIN lc_countries lcc
            ON piv.roo = lcc.geo_id AND lcc.localization_id = 1
         LEFT JOIN lc_geo_regions lcr
            ON lcr.geo_id = piv.l_3 AND  lcr.localization_id =1
         LEFT JOIN lc_geo_parts lcp
            ON lcp.geo_id = piv.l_2 AND  lcp.localization_id = 1
         LEFT JOIN t_geo_object_links gol
            ON GOL.CHILD_GEO_ID = lcc.geo_id
         LEFT JOIN t_actions ta
            ON ta.geo_id = LCC.GEO_ID           
UNION ALL
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
       , TO_CHAR( NVL( (SELECT min(action_dt) FROM t_actions tac WHERE TAC.GEO_ID = piv.roo AND tac.v_new_int = ta.v_old_int),
                    (SELECT insert_dt FROM t_geo_object_links WHERE child_geo_id = v_new_int) ) , 'DD-MON-YY') 
                    as VALID_FROM
       , TO_CHAR(TRUNC(action_dt), 'DD-MON-YY') AS VALID_TO
       , 'N' AS IS_ACTUAL
    FROM piv         
         INNER JOIN t_actions ta
            ON ta.geo_id = piv.roo
         LEFT JOIN lc_countries lcc
            ON piv.roo = lcc.geo_id AND lcc.localization_id = 1
         LEFT JOIN t_geo_object_links gol
            ON GOL.CHILD_GEO_ID = lcc.geo_id
         LEFT JOIN lc_geo_regions lcr
            ON lcr.geo_id = ta.v_old_int AND  lcr.localization_id =1
         LEFT JOIN lc_geo_parts lcp
            ON lcp.geo_id = piv.l_2 AND  lcp.localization_id = 1
ORDER BY country_geo_id, valid_from;

