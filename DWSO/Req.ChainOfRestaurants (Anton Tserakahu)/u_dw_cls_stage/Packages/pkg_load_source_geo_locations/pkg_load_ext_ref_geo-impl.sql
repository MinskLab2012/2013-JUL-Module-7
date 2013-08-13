CREATE OR REPLACE PACKAGE BODY pkg_load_source_geo_locations
AS
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries_iso3166 ( country_id
                                            , country_desc
                                            , country_code )
         SELECT country_id
              , country_desc
              , country_code
           FROM u_dw_source.t_ext_geo_countries_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha3;

   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha2
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES2_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries2_iso3166 ( country_desc
                                             , country_code )
         SELECT country_desc
              , country_code
           FROM u_dw_source.t_ext_geo_countries2_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha2;


   -- Extract Data from external source = External Table
   -- Load All Geography objects - Structures from ISO 3166
   PROCEDURE load_cls_geo_structure
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_geo_structure_iso3166 ( child_code
                                            , parent_code
                                            , structure_desc
                                            , structure_level )
         SELECT child_code
              , parent_code
              , structure_desc
              , structure_level
           FROM u_dw_source.t_ext_geo_structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Contries from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_CNTR2STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_cntr2structure_iso3166 ( country_id
                                             , county_desc
                                             , structure_code
                                             , structure_desc )
         SELECT country_id
              , county_desc
              , structure_code
              , structure_desc
           FROM u_dw_source.t_ext_cntr2structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure2cntr;


   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups from ISO 3166
   PROCEDURE load_cls_countries_grouping
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_CNTR_GROUPING_ISO3166';

      --Extract data
      INSERT INTO cls_cntr_grouping_iso3166 ( child_code
                                            , parent_code
                                            , group_desc
                                            , group_level )
         SELECT child_code
              , parent_code
              , group_desc
              , group_level
           FROM u_dw_source.t_ext_cntr_grouping_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_countries_grouping;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups Links to Countries from ISO 3166
   PROCEDURE load_cls_countries2groups
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_cntr2grouping_iso3166';

      --Extract data
      INSERT INTO cls_cntr2grouping_iso3166 ( country_id
                                            , county_desc
                                            , group_code
                                            , group_desc )
         SELECT country_id
              , county_desc
              , group_code
              , group_desc
           FROM u_dw_source.t_ext_cntr2grouping_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_countries2groups;



END pkg_load_source_geo_locations;
/