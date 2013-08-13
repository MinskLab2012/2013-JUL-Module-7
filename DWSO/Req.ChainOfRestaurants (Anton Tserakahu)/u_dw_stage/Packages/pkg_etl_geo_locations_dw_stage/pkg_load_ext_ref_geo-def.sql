
CREATE OR REPLACE PACKAGE pkg_etl_geo_locations_dw_stage
-- Package Reload Data From External Sources to DataBase - Geography objects
AS
   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_systems;

   -- Load Geography Continents from ISO 3166 to References
   PROCEDURE load_ref_geo_parts;

   -- Load Geography Regions from ISO 3166 to References
   PROCEDURE load_ref_geo_regions;

   -- Load Countries Grouping System from ISO 3166 to References
   PROCEDURE load_ref_cntr_group_systems;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_groups;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_sub_groups;

   -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure;

   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries;

   -- Load Countries links to Grouping Systems from ISO 3166 to References
   PROCEDURE load_lnk_cntr_grouping;

   -- Load Countries links to Groups from ISO 3166 to References
   PROCEDURE load_lnk_cntr2groups;

   -- Load Cities
   PROCEDURE load_cities;

   -- Load Actions
   PROCEDURE load_geo_actions;
   
   
   
   
   
   
   
END pkg_etl_geo_locations_dw_stage;
/