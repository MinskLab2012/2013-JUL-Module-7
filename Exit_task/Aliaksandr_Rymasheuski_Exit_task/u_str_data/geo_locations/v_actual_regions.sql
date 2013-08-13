/* Formatted on 10.08.2013 13:35:44 (QP5 v5.139.911.3011) */
CREATE VIEW actual_regions
AS
   SELECT region_geo_id
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
      AND level_code = 'Regions';

      GRANT SELECT ON actual_regions TO u_sal_cl;