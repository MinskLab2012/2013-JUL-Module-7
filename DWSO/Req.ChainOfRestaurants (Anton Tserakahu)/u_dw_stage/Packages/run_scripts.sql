BEGIN
   --GEO
   --Transport Countries
   pkg_etl_geo_locations_dw_stage.load_ref_geo_countries;
   --Transport References
   pkg_etl_geo_locations_dw_stage.load_ref_geo_systems;
   pkg_etl_geo_locations_dw_stage.load_ref_geo_parts;
   pkg_etl_geo_locations_dw_stage.load_ref_geo_regions;
   pkg_etl_geo_locations_dw_stage.load_ref_cntr_group_systems;
   pkg_etl_geo_locations_dw_stage.load_ref_cntr_groups;
   pkg_etl_geo_locations_dw_stage.load_ref_cntr_sub_groups;   
   --Transport Links
   pkg_etl_geo_locations_dw_stage.load_lnk_geo_structure;
   pkg_etl_geo_locations_dw_stage.load_lnk_geo_countries;
   pkg_etl_geo_locations_dw_stage.load_lnk_cntr_grouping;
   pkg_etl_geo_locations_dw_stage.load_lnk_cntr2groups;
   pkg_etl_geo_locations_dw_stage.load_cities;
   pkg_etl_geo_locations_dw_stage.load_geo_actions;

   --Restaurants
   pkg_etl_restaurants_dw_stage.load_t_restaurant_types;
   pkg_etl_restaurants_dw_stage.load_t_restaurants;

   --Dishes
   pkg_etl_dishes_dw_stage.load_t_dish_types;
   pkg_etl_dishes_dw_stage.load_t_dish_cuisines;
   pkg_etl_dishes_dw_stage.load_t_dishes;
   pkg_etl_dishes_dw_stage.load_actions;

   --Periods
   pkg_etl_periods_dw_stage.load_t_period_types;
   pkg_etl_periods_dw_stage.load_t_periods;

   --Operations
   --pkg_etl_operations_dw_stage.load_t_operations;

END;





