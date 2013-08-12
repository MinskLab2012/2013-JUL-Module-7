CREATE OR REPLACE PACKAGE pkg_load_ext_ref_geography
-- Package Reload Data From External Sources to DataBase - Geography objects
--
AS  
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3;
   
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 2
   PROCEDURE load_cls_languages_alpha2;
      
   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries;
   
   -- Load Geography Continents from ISO 3166 to References
   PROCEDURE load_ref_geo_parts;
   
   -- Load Geography Regions from ISO 3166 to References
   PROCEDURE load_ref_geo_regions;
   
    -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure;
   
   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries;
   
    PROCEDURE load_cls_geo_structure;
    
    PROCEDURE load_cls_geo_structure2cntr;
   

   
END pkg_load_ext_ref_geography;
/