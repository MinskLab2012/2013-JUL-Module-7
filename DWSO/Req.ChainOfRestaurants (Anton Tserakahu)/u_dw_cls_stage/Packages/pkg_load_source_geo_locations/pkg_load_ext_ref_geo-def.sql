CREATE OR REPLACE PACKAGE pkg_load_source_geo_locations
-- Package Reload Data From External Sources to DataBase - Geography objects
--
AS  
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3;
   
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 2
   PROCEDURE load_cls_languages_alpha2;
   
   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure;
      
   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups from ISO 3166
   PROCEDURE load_cls_countries_grouping;

     -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups Links to Countries from ISO 3166
   PROCEDURE load_cls_countries2groups;
   
END pkg_load_source_geo_locations;
/