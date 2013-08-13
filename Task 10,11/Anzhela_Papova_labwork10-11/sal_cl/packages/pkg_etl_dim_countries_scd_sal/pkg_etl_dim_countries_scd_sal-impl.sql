/* Formatted on 12.08.2013 18:12:37 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_countries_scd_sal
AS
   -- Procedure load countries in Dimension entity SCD type 2
   PROCEDURE load_dim_countries_scd
   AS
   BEGIN
      --Update data about validity
      UPDATE sal.dim_countries_scd trg
         SET trg.valid_to =
                TRUNC ( SYSDATE
                      , 'dd' )
           , trg.is_active = 'N'
       WHERE trg.is_active = 'Y'
         AND trg.country_geo_id IN (SELECT country_geo_id
                                      FROM tmp_countries);

      --Insert data
      INSERT INTO sal.dim_countries_scd trg ( country_surr_id
                                            , country_geo_id
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
                                            , valid_from
                                            , valid_to
                                            , is_active
                                            , insert_dt )
         SELECT cntr_surr_seq.NEXTVAL
              , country_geo_id
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
              , TRUNC ( SYSDATE
                      , 'dd' )
              , TO_DATE ( '31/12/9999'
                        , 'dd/mm/yyyy' )
              , 'Y'
              , SYSDATE
           FROM tmp_countries;

      --Commit Results
      COMMIT;
   END load_dim_countries_scd;
END pkg_etl_dim_countries_scd_sal;
/