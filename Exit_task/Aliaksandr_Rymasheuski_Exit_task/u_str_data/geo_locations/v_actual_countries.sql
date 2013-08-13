/* Formatted on 10.08.2013 13:31:02 (QP5 v5.139.911.3011) */
CREATE VIEW actual_countries
AS
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
     FROM u_str_data.dim_geo_locations_scd
    WHERE valid_to = TO_DATE ( '12/12/9999'
                             , 'mm/dd/yyyy' )
      AND level_code = 'Countries';



      GRANT SELECT ON actual_countries TO u_sal_cl;