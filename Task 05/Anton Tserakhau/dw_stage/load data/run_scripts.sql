BEGIN
   --Dishes
   pkg_etl_dishes_dw_stage.load_t_dish_types;
   pkg_etl_dishes_dw_stage.load_t_dish_cuisines;
   pkg_etl_dishes_dw_stage.load_t_dishes;
   --Periods
   pkg_etl_periods_dw_stage.load_t_period_types;
   pkg_etl_periods_dw_stage.load_t_periods;
   --Restaurants
   pkg_etl_restaurants_dw_stage.load_t_restaurant_types;
   pkg_etl_restaurants_dw_stage.load_t_restaurants;
END;





