/* Formatted on 12.08.2013 20:56:17 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_load_hist_geography
AS
   PROCEDURE load_cls_languages_alpha3;

   PROCEDURE load_cls_languages_alpha2;

   PROCEDURE load_ref_geo_countries;

   PROCEDURE load_cls_geo_structure;

   PROCEDURE load_cls_geo_structure2cntr;

   PROCEDURE load_h_geo_countries;

   PROCEDURE load_h_systems;

   PROCEDURE load_h_geo_parts;

   PROCEDURE load_h_geo_regions;

   PROCEDURE load_h_lnk_geo_structure;

   PROCEDURE load_h_lnk_geo_countries;
END pkg_load_hist_geography;