/* Formatted on 10.08.2013 14:30:00 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_act_countries_dw_cl
AS
   -- Package load Actual Data about  countries from DW Layer
   PROCEDURE load_act_countries
   AS
   BEGIN
      --Delete old values
      EXECUTE IMMEDIATE 'TRUNCATE TABLE t_act_countries DROP STORAGE';

      --Insert Source data
      INSERT INTO t_act_countries ( country_geo_id
 , country_id  
 , country_code_a2 
 , country_code_a3 
 , country_desc 
 , region_geo_id 
 , region_id      
 , region_code    
 , region_desc    
 , part_geo_id  
 , part_id      
 , part_code      
 , part_desc  
 , geo_system_geo_id 
 , geo_system_id  
 , geo_system_code 
 , geo_system_desc 
 , sub_group_geo_id 
 , sub_group_id  
 , sub_group_code 
 , sub_group_desc 
 , group_geo_id   
 , GROUP_ID       
 , group_code     
 , group_desc     
 , grp_system_geo_id 
 , grp_system_id  
 , grp_system_code 
 , grp_system_desc 
 , level_code  )
         SELECT /*+ parallel(cntr 8) parallel (reg 8) parallel (part 8) parallel (g_sys 8) parallel (grp_sys 8) parallel (grp 8) parallel (sub_grp 8)*/
              country_geo_id
     , cntr.country_id
     , cntr.country_code_a2
     , cntr.country_code_a3
     , cntr.region_desc AS country_desc
     --region
     , NVL ( g_region_id, -99 ) AS region_geo_id
     , NVL ( reg.src_continent_id, -99 ) AS region_id
     , NVL ( reg.region_code, 'n.d.' ) AS region_code
     , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
     -- part
     , NVL ( g_part_id, -99 ) AS part_geo_id
     , NVL ( part.part_id, -99 ) AS part_id
     , NVL ( part.part_code, 'n.d.' ) AS part_code
     , NVL ( part.part_desc, 'n.d.' ) AS part_desc
     -- geo_systems
     , NVL ( g_system_id, -99 ) AS geo_system_geo_id
     , NVL ( g_sys.src_geo_system_id, -99 ) AS geo_system_id
     , NVL ( g_sys.geo_system_code, 'n.d.' ) AS geo_system_code
     , NVL ( g_sys.geo_system_desc, 'n.d.' ) AS geo_system_desc
     -- group_items
     , NVL ( grp_sub_gr, -99 ) AS sub_group_geo_id
     , NVL ( sub_grp.sub_group_id, -99 ) AS sub_group_id
     , NVL ( sub_grp.sub_group_code, 'n.d.' ) AS sub_group_code
     , NVL ( sub_grp.sub_group_desc, 'n.d.' ) AS sub_group_desc
     -- groups
     , NVL ( grp_group, -99 ) AS group_geo_id
     , NVL ( grp.GROUP_ID, -99 ) AS GROUP_ID
     , NVL ( grp.group_code, 'n.d.' ) AS group_code
     , NVL ( grp.group_desc, 'n.d.' ) AS group_desc
     -- group system
     , NVL ( grp_sys, -99 ) AS grp_system_geo_id
     , NVL ( grp_sys.grp_system_id, -99 ) AS grp_system_id
     , NVL ( grp_sys.grp_system_code, 'n.d.' ) AS grp_system_code
     , NVL ( grp_sys.grp_system_desc, 'n.d.' ) AS grp_system_desc
     , 'Country' as level_code
  FROM (    SELECT CONNECT_BY_ROOT child_geo_id AS country_geo_id
                 , parent_geo_id
                 , link_type_id
              FROM dw.t_geo_object_links
        START WITH child_geo_id IN (SELECT geo_id
                                      FROM dw.cu_countries)
        CONNECT BY PRIOR parent_geo_id = child_geo_id) PIVOT (SUM ( parent_geo_id )
                                                       FOR link_type_id
                                                       IN  (1 AS g_system_id
                                                         , 2 AS g_part_id
                                                         , 3 AS g_region_id
                                                         , 4 AS grp_sys
                                                         , 5 AS grp_group
                                                         , 6 AS grp_sub_gr)) src
     , dw.cu_countries cntr
     , dw.cu_geo_regions reg
     , dw.cu_geo_parts part
     , dw.cu_geo_systems g_sys
     , dw.cu_cntr_group_systems grp_sys
     , dw.cu_cntr_groups grp
     , dw.cu_cntr_sub_groups sub_grp
 WHERE cntr.geo_id(+) = src.country_geo_id
   AND reg.geo_id(+) = src.g_region_id
   AND part.geo_id(+) = src.g_part_id
   AND g_sys.geo_id(+) = src.g_system_id
   AND grp_sys.geo_id(+) = src.grp_sys
   AND grp.geo_id(+) = src.grp_group
   AND sub_grp.geo_id(+) = src.grp_sub_gr;

      --Commit Results
      COMMIT;
   END load_act_countries;
END  pkg_etl_act_countries_dw_cl;
/