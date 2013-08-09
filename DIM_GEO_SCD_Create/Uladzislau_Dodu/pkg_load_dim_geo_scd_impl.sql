create or replace  package body load_dim_geo_scd
as
procedure load_level_code_1
as
   CURSOR cur_c1
   IS
      SELECT /*+ USE_HASH(lc, reg, par) PARALLEL(lc,4) */
            root
           , country_id
           , country_desc
           , NVL ( country_code_a3, -99 ) AS country_code_a3
           --region
           , NVL ( l_3, -99 ) AS region_geo_id
           , NVL ( region_code, 'n.d.' ) AS region_code
           , NVL ( region_desc, 'n.d.' ) AS region_desc
           -- part
           , NVL ( l_2, -99 ) AS part_geo_id
           , NVL ( part_id, -99 ) AS part_id
           , NVL ( part_code, 'n.d.' ) AS part_code
           , NVL ( part_desc, 'n.d.' ) AS part_desc
           -- geo_systems
           , NVL ( l_1, -99 ) AS geo_system_geo_id
           , NVL ( geo_system_code, 'n.d.' ) AS geo_system_code
           , NVL ( geo_system_desc, 'n.d.' ) AS geo_system_desc
        FROM (SELECT *
                FROM (    SELECT b.parent_geo_id AS geo_id
                               , CONNECT_BY_ROOT b.child_geo_id AS root
                               , b.link_type_id
                               , a.action_dt
                            FROM (   (SELECT *
                                        FROM u_dw_references.actions
                                       WHERE ( geo_id, action_dt ) IN (  SELECT geo_id
                                                                              , MAX ( action_dt )
                                                                           FROM u_dw_references.actions
                                                                       GROUP BY geo_id)) a
                                  JOIN
                                     u_dw_references.t_geo_object_links b
                                  ON ( a.geo_id = b.child_geo_id
                                  AND a.value_new = b.parent_geo_id ))
                      START WITH b.child_geo_id IN (SELECT DISTINCT geo_id
                                                      FROM u_dw_references.lc_countries)
                      CONNECT BY PRIOR b.parent_geo_id = b.child_geo_id) PIVOT (MAX ( geo_id )
                                                                         FOR link_type_id
                                                                         IN (1 AS l_1, 2 AS l_2, 3 AS l_3))
                     LEFT JOIN u_dw_references.lc_countries lc
                        ON ( root = lc.geo_id )
                     LEFT JOIN u_dw_references.lc_geo_regions reg
                        ON ( l_3 = reg.geo_id )
                     LEFT JOIN u_dw_references.lc_geo_parts par
                        ON ( l_2 = par.geo_id )
                     LEFT JOIN u_dw_references.lc_geo_systems sys
                        ON ( l_1 = sys.geo_id ))
      MINUS
      SELECT *
        FROM cntr2scd;

   TYPE tab IS TABLE OF cur_c1%ROWTYPE;

   tabl           tab;
BEGIN
   OPEN cur_c1;

   FETCH cur_c1
   BULK COLLECT INTO tabl;

   FORALL i IN INDICES OF tabl
      INSERT INTO cntr2scd ( geo_id
                           , country_id
                           , country_desc
                           , country_code_a3
                           , region_geo_id
                           , region_code
                           , region_desc
                           , part_geo_id
                           , part_id
                           , part_code
                           , part_desc
                           , geo_system_geo_id
                           , geo_system_code
                           , geo_system_desc )
           VALUES ( tabl ( i ).root
                  , tabl ( i ).country_id
                  , tabl ( i ).country_desc
                  , tabl ( i ).country_code_a3
                  , tabl ( i ).region_geo_id
                  , tabl ( i ).region_code
                  , tabl ( i ).region_desc
                  , tabl ( i ).part_geo_id
                  , tabl ( i ).part_id
                  , tabl ( i ).part_code
                  , tabl ( i ).part_desc
                  , tabl ( i ).geo_system_geo_id
                  , tabl ( i ).geo_system_code
                  , tabl ( i ).geo_system_desc );

   COMMIT;

   FORALL i IN INDICES OF tabl
      UPDATE dim_geo_scd
         SET valid_from   =
                ( SELECT action_dt
                    FROM (SELECT *
                            FROM (    SELECT b.parent_geo_id AS geo_id
                                           , CONNECT_BY_ROOT b.child_geo_id AS root
                                           , b.link_type_id
                                           , a.action_dt
                                        FROM (   (SELECT *
                                                    FROM u_dw_references.actions
                                                   WHERE ( geo_id, action_dt ) IN (  SELECT geo_id
                                                                                          , MAX ( action_dt )
                                                                                       FROM u_dw_references.actions
                                                                                   GROUP BY geo_id)) a
                                              JOIN
                                                 u_dw_references.t_geo_object_links b
                                              ON ( a.geo_id = b.child_geo_id
                                              AND a.value_new = b.parent_geo_id ))
                                  START WITH b.child_geo_id IN (SELECT DISTINCT geo_id
                                                                  FROM u_dw_references.lc_countries)
                                  CONNECT BY PRIOR b.parent_geo_id = b.child_geo_id) PIVOT (MAX ( geo_id )
                                                                                     FOR link_type_id
                                                                                     IN (1 AS l_1, 2 AS l_2, 3 AS l_3)))
                   WHERE root = tabl ( i ).root
                     AND l_1 = tabl ( i ).geo_system_geo_id
                     AND l_2 = tabl ( i ).part_geo_id
                     AND l_3 = tabl ( i ).region_geo_id )
           , level_code   = '1'
       WHERE geo_id = tabl ( i ).root
         AND country_id = tabl ( i ).country_id
         AND country_desc = tabl ( i ).country_desc
         AND country_code_a3 = tabl ( i ).country_code_a3
         AND region_geo_id = tabl ( i ).region_geo_id
         AND region_code = tabl ( i ).region_code
         AND region_desc = tabl ( i ).region_desc
         AND part_geo_id = tabl ( i ).part_geo_id
         AND part_id = tabl ( i ).part_id
         AND part_code = tabl ( i ).part_code
         AND part_desc = tabl ( i ).part_desc
         AND geo_system_geo_id = tabl ( i ).geo_system_geo_id
         AND geo_system_code = tabl ( i ).geo_system_code
         AND geo_system_desc = tabl ( i ).geo_system_desc;

   COMMIT;

   MERGE INTO dim_geo_scd gt
        USING (SELECT geo_sur_id
                    , NVL ( LEAD ( valid_from ) OVER (PARTITION BY geo_id ORDER BY valid_to), '31-DEC-2999' ) ll
                 FROM dim_geo_scd
                 where level_code = 1) l
           ON ( gt.geo_sur_id = l.geo_sur_id )
   WHEN MATCHED THEN
      UPDATE SET gt.valid_to  = l.ll
              WHERE gt.geo_sur_id = l.geo_sur_id;

   COMMIT;

   CLOSE cur_c1;
END load_level_code_1;

/* Formatted on 8/9/2013 12:06:11 AM (QP5 v5.139.911.3011) */

procedure load_level_code_2
as
cursor cur_c1
  is SELECT /*+ USE_HASH(lc, reg, par) PARALLEL(lc,4) */
  root,
        NVL(country_id,-99) country_id
       , NVL(country_desc,-99) country_desc
       , NVL(country_code_a3, -99) country_code_a3
       --region
       , NVL ( root, -99 ) AS region_geo_id
       , NVL ( region_code, 'n.d.' ) AS region_code
       , NVL ( region_desc, 'n.d.' ) AS region_desc
       -- part
       , NVL ( l_2, -99 ) AS part_geo_id
       , NVL ( part_id, -99 ) AS part_id
       , NVL ( part_code, 'n.d.' ) AS part_code
       , NVL ( part_desc, 'n.d.' ) AS part_desc
       -- geo_systems
       , NVL ( l_1, -99 ) AS geo_system_geo_id
       , NVL ( geo_system_code, 'n.d.' ) AS geo_system_code
       , NVL ( geo_system_desc, 'n.d.' ) AS geo_system_desc
       , action_dt
    FROM (SELECT *
            FROM (    SELECT b.parent_geo_id AS geo_id
                           , CONNECT_BY_ROOT b.child_geo_id AS root
                           , b.link_type_id
                           , a.action_dt
                        FROM (   (SELECT *
                                    FROM u_dw_references.actions
                                   WHERE ( geo_id, action_dt ) IN (  SELECT geo_id
                                                                          , MAX ( action_dt )
                                                                       FROM u_dw_references.actions
                                                                   GROUP BY geo_id)) a
                              JOIN
                                 u_dw_references.t_geo_object_links b
                              ON ( a.geo_id = b.child_geo_id
                              AND a.value_new = b.parent_geo_id ))
                  START WITH b.child_geo_id IN (SELECT DISTINCT geo_id
                                                  FROM u_dw_references.lc_geo_regions)
                  CONNECT BY PRIOR b.parent_geo_id = b.child_geo_id) PIVOT (MAX ( geo_id )
                                                                     FOR link_type_id
                                                                     IN (1 AS l_1, 2 AS l_2, 3 AS l_3))
                 LEFT JOIN u_dw_references.lc_countries lc
                    ON ( root = lc.geo_id )
                 LEFT JOIN u_dw_references.lc_geo_regions reg
                    ON ( root = reg.geo_id )
                 LEFT JOIN u_dw_references.lc_geo_parts par
                    ON ( l_2 = par.geo_id )
                 LEFT JOIN u_dw_references.lc_geo_systems sys
                    ON ( l_1 = sys.geo_id ))
                    minus
                    select * from REG2SCD;
                    TYPE tab IS TABLE OF cur_c1%ROWTYPE;

   tabl           tab;
BEGIN
   OPEN cur_c1;

   FETCH cur_c1
   BULK COLLECT INTO tabl;

   FORALL i IN INDICES OF tabl
      INSERT INTO reg2scd ( geo_id
                           , country_id
                           , country_desc
                           , country_code_a3
                           , region_geo_id
                           , region_code
                           , region_desc
                           , part_geo_id
                           , part_id
                           , part_code
                           , part_desc
                           , geo_system_geo_id
                           , geo_system_code
                           , geo_system_desc
                           , valid_from )
           VALUES ( tabl ( i ).root
                  , tabl ( i ).country_id
                  , tabl ( i ).country_desc
                  , tabl ( i ).country_code_a3
                  , tabl ( i ).region_geo_id
                  , tabl ( i ).region_code
                  , tabl ( i ).region_desc
                  , tabl ( i ).part_geo_id
                  , tabl ( i ).part_id
                  , tabl ( i ).part_code
                  , tabl ( i ).part_desc
                  , tabl ( i ).geo_system_geo_id
                  , tabl ( i ).geo_system_code
                  , tabl ( i ).geo_system_desc
                  , tabl( i ).action_dt );
  commit;                
                  FORALL i IN INDICES OF tabl
        update dim_geo_scd
        set level_code = '2'
        WHERE geo_id = tabl ( i ).root
         AND country_id = tabl ( i ).country_id
         AND country_desc = tabl ( i ).country_desc
         AND country_code_a3 = tabl ( i ).country_code_a3
         AND region_geo_id = tabl ( i ).region_geo_id
         AND region_code = tabl ( i ).region_code
         AND region_desc = tabl ( i ).region_desc
         AND part_geo_id = tabl ( i ).part_geo_id
         AND part_id = tabl ( i ).part_id
         AND part_code = tabl ( i ).part_code
         AND part_desc = tabl ( i ).part_desc
         AND geo_system_geo_id = tabl ( i ).geo_system_geo_id
         AND geo_system_code = tabl ( i ).geo_system_code
         AND geo_system_desc = tabl ( i ).geo_system_desc;
   COMMIT;
   
      MERGE INTO dim_geo_scd gt
        USING (SELECT geo_sur_id
                    , NVL ( LEAD ( valid_from ) OVER (PARTITION BY geo_id ORDER BY valid_to), '31-DEC-2999' ) ll
                 FROM dim_geo_scd
                 where level_code = 2) l
           ON ( gt.geo_sur_id = l.geo_sur_id )
   WHEN MATCHED THEN
      UPDATE SET gt.valid_to  = l.ll
     WHERE gt.geo_sur_id = l.geo_sur_id;
   COMMIT;
   end load_level_code_2;
   
   procedure load_level_code_3
   as
cursor cur_c1 is  SELECT /*+ USE_HASH(lc, reg, par) PARALLEL(lc,4) */
        root
       , NVl(country_id,-99) country_id
       , NVL(country_desc, -99) country_desc
       , NVL(country_code_a3,-99) country_code_a3
       --region
       , NVL ( l_3, -99 ) AS region_geo_id
       , NVL ( region_code, 'n.d.' ) AS region_code
       , NVL ( region_desc, 'n.d.' ) AS region_desc
       -- part
       , NVL ( l_2, -99 ) AS part_geo_id
       , NVL ( part_id, -99 ) AS part_id
       , NVL ( part_code, 'n.d.' ) AS part_code
       , NVL ( part_desc, 'n.d.' ) AS part_desc
       -- geo_systems
       , NVL ( l_1, -99 ) AS geo_system_geo_id
       , NVL ( geo_system_code, 'n.d.' ) AS geo_system_code
       , NVL ( geo_system_desc, 'n.d.' ) AS geo_system_desc
       , action_dt
    FROM (SELECT *
            FROM (    SELECT b.parent_geo_id AS geo_id
                           , CONNECT_BY_ROOT b.child_geo_id AS root
                           , b.link_type_id
                           , a.action_dt
                        FROM (   (SELECT *
                                    FROM u_dw_references.actions
                                   WHERE ( geo_id, action_dt ) IN (  SELECT geo_id
                                                                          , MAX ( action_dt )
                                                                       FROM u_dw_references.actions
                                                                   GROUP BY geo_id)) a
                              JOIN
                                 u_dw_references.t_geo_object_links b
                              ON ( a.geo_id = b.child_geo_id
                              AND a.value_new = b.parent_geo_id ))
                  START WITH b.child_geo_id IN (SELECT DISTINCT geo_id
                                                  FROM u_dw_references.lc_geo_parts)
                  CONNECT BY PRIOR b.parent_geo_id = b.child_geo_id) PIVOT (MAX ( geo_id )
                                                                     FOR link_type_id
                                                                     IN (1 AS l_1, 2 AS l_2, 3 AS l_3))
                 LEFT JOIN u_dw_references.lc_countries lc
                    ON ( root = lc.geo_id )
                 LEFT JOIN u_dw_references.lc_geo_regions reg
                    ON ( l_3 = reg.geo_id )
                 LEFT JOIN u_dw_references.lc_geo_parts par
                    ON ( root = par.geo_id )
                 LEFT JOIN u_dw_references.lc_geo_systems sys
                    ON ( l_1 = sys.geo_id ))
minus select * from prt2scd;
TYPE tab IS TABLE OF cur_c1%ROWTYPE;

   tabl           tab;
BEGIN
   OPEN cur_c1;

   FETCH cur_c1
   BULK COLLECT INTO tabl;

   FORALL i IN INDICES OF tabl
      INSERT INTO reg2scd ( geo_id
                           , country_id
                           , country_desc
                           , country_code_a3
                           , region_geo_id
                           , region_code
                           , region_desc
                           , part_geo_id
                           , part_id
                           , part_code
                           , part_desc
                           , geo_system_geo_id
                           , geo_system_code
                           , geo_system_desc
                           , valid_from )
           VALUES ( tabl ( i ).root
                  , tabl ( i ).country_id
                  , tabl ( i ).country_desc
                  , tabl ( i ).country_code_a3
                  , tabl ( i ).region_geo_id
                  , tabl ( i ).region_code
                  , tabl ( i ).region_desc
                  , tabl ( i ).part_geo_id
                  , tabl ( i ).part_id
                  , tabl ( i ).part_code
                  , tabl ( i ).part_desc
                  , tabl ( i ).geo_system_geo_id
                  , tabl ( i ).geo_system_code
                  , tabl ( i ).geo_system_desc
                  , tabl( i ).action_dt );
  commit;                
                  FORALL i IN INDICES OF tabl
        update dim_geo_scd
        set level_code = '3'
        WHERE geo_id = tabl ( i ).root
         AND country_id = tabl ( i ).country_id
         AND country_desc = tabl ( i ).country_desc
         AND country_code_a3 = tabl ( i ).country_code_a3
         AND region_geo_id = tabl ( i ).region_geo_id
         AND region_code = tabl ( i ).region_code
         AND region_desc = tabl ( i ).region_desc
         AND part_geo_id = tabl ( i ).part_geo_id
         AND part_id = tabl ( i ).part_id
         AND part_code = tabl ( i ).part_code
         AND part_desc = tabl ( i ).part_desc
         AND geo_system_geo_id = tabl ( i ).geo_system_geo_id
         AND geo_system_code = tabl ( i ).geo_system_code
         AND geo_system_desc = tabl ( i ).geo_system_desc;
   COMMIT;
   
      MERGE INTO dim_geo_scd gt
        USING (SELECT geo_sur_id
                    , NVL ( LEAD ( valid_from ) OVER (PARTITION BY geo_id ORDER BY valid_to), '31-DEC-2999' ) ll
                 FROM dim_geo_scd
                 where level_code = 3) l
           ON ( gt.geo_sur_id = l.geo_sur_id )
   WHEN MATCHED THEN
      UPDATE SET gt.valid_to  = l.ll
     WHERE gt.geo_sur_id = l.geo_sur_id;
   COMMIT;
   end load_level_code_3;
   end;


   