BEGIN
   --GEO
   pkg_load_source_geo_locations.load_cls_languages_alpha3;
   pkg_load_source_geo_locations.load_cls_languages_alpha2;
   pkg_load_source_geo_locations.load_cls_geo_structure;
   pkg_load_source_geo_locations.load_cls_geo_structure2cntr;
   pkg_load_source_geo_locations.load_cls_countries_grouping;
   pkg_load_source_geo_locations.load_cls_countries2groups;

   --Restaurants
   pkg_load_source_restaurants.load_cls_restaurants;

   --Dishes
   pkg_load_source_dishes.load_cls_dishes;

   --Periods
   pkg_load_source_periods.load_cls_periods;

   --Operations
   pkg_load_source_operations.load_cls_operations;

END;





