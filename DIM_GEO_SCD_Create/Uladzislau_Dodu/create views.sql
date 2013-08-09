/* Formatted on 8/9/2013 12:06:30 AM (QP5 v5.139.911.3011) */
CREATE VIEW cntr2scd
AS
   SELECT geo_id
        , country_id
        , country_desc
        , country_code_a3
        --region
        , region_geo_id
        , region_code
        , region_desc
        -- part
        , part_geo_id
        , part_id
        , part_code
        , part_desc
        -- geo_systems
        , geo_system_geo_id
        , geo_system_code
        , geo_system_desc
     FROM dim_geo_scd
    WHERE level_code = 1
      AND is_valid = 1;

drop view reg2scd

CREATE VIEW reg2scd
AS
   SELECT geo_id,
   country_id
        , country_desc
        , country_code_a3
        --region
        , region_geo_id
        , region_code
        , region_desc
        -- part
        , part_geo_id
        , part_id
        , part_code
        , part_desc
        -- geo_systems
        , geo_system_geo_id
        , geo_system_code
        , geo_system_desc
        ,valid_from
     FROM dim_geo_scd
    WHERE level_code = 2
      AND is_valid = 1




CREATE VIEW prt2scd
AS
   SELECT geo_id, country_id
        , country_desc
        , country_code_a3
        --region
        , region_geo_id
        , region_code
        , region_desc
        -- part
        , part_geo_id
        , part_id
        , part_code
        , part_desc
        -- geo_systems
        , geo_system_geo_id
        , geo_system_code
        , geo_system_desc
        , valid_from
     FROM dim_geo_scd
    WHERE level_code = 3
      AND is_valid = 1;
