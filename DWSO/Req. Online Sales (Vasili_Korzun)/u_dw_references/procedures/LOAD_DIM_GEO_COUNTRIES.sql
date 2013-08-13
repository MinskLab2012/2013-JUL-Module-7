/* Formatted on 13.08.2013 14:44:18 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PROCEDURE load_dim_geo_countries
AS
BEGIN
   INSERT INTO sal_star.dim_geo_locations_scd (GEO_SURR_ID,
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
                                               GEO_LEVEL_CODE,
                                               valid_from,
                                               insert_dt)
      SELECT SAL_STAR.SEQ_DIM_GEO_LOCATIONS.NEXTVAL,
             geo_id,
             country_id,
             country_code_a2,
             country_code_a3,
             country_desc,
             region_id,
             region_code,
             region_desc,
             part_id,
             part_desc,
             geo_system_id,
             geo_system_code,
             geo_system_desc,
             level_code,
             action_dt,
             SYSDATE
        FROM (SELECT geo_id,
                     country_id,
                     country_code_a2,
                     country_code_a3,
                     country_desc,
                     region_id,
                     region_code,
                     region_desc,
                     part_id,
                     part_desc,
                     geo_system_id,
                     geo_system_code,
                     geo_system_desc,
                     level_code,
                     action_dt
                FROM (
                SELECT * FROM v_actual_countries
                 --     UNION
                    --SELECT * FROM v_actual_regions
                 --     UNION
                   --  SELECT * FROM v_actual_geo_parts
                   )                   
              MINUS
              SELECT GEO_ID,
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
                     GEO_LEVEL_CODE,
                     valid_from
                FROM sal_star.dim_geo_locations_scd);

   COMMIT;

   MERGE INTO sal_star.dim_geo_locations_scd dgl
        USING (SELECT geo_surr_id,
                      LEAD (valid_from, 1, '31-DEC-9999')
                         OVER (PARTITION BY geo_id ORDER BY valid_to ASC)
                         AS valid_to
                 FROM sal_star.dim_geo_locations_scd) UP
           ON (dgl.geo_surr_id = UP.geo_surr_id)
   WHEN MATCHED
   THEN
      UPDATE SET dgl.valid_to = UP.valid_to;

   COMMIT;
END load_dim_geo_countries;

BEGIN
   load_dim_geo_countries;
END;

