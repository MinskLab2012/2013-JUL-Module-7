/* Formatted on 12.08.2013 13:31:51 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_tmp_countries_sal_cl
AS
   -- Procedure load difference between actual data in the table t_act_countries and data on SAL Layer from dim_countries_scd
   PROCEDURE load_tmp_countries
   AS
   BEGIN
      --Delete old values
      EXECUTE IMMEDIATE 'TRUNCATE TABLE tmp_countries DROP STORAGE';

      --Insert data
      INSERT INTO tmp_countries ( country_geo_id
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
                                , level_code )
         SELECT country_geo_id
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
              , level_code
           FROM sal_dw_cl.t_act_countries
         MINUS
         SELECT country_geo_id
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
              , level_code
           FROM sal.dim_countries_scd;

      --Commit Results
      COMMIT;
   END load_tmp_countries;
END pkg_etl_tmp_countries_sal_cl;
/