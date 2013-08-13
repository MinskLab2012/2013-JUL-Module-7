
--==============================================================
-- Table: t_cities
--==============================================================

ALTER TABLE u_dw_stage.t_cities
   ADD CONSTRAINT fk_t_geo_cities_geo_obj  FOREIGN KEY (geo_id)
      REFERENCES u_dw_stage.t_geo_objects (geo_id)
      ON DELETE CASCADE;

--==============================================================
-- Table: t_dishes
--==============================================================

ALTER TABLE u_dw_stage.t_dishes
   ADD CONSTRAINT fk_t_dishes_types  FOREIGN KEY (dish_type_id)
      REFERENCES u_dw_stage.t_dish_types (dish_type_id)
      ON DELETE CASCADE;

ALTER TABLE u_dw_stage.t_dishes
   ADD CONSTRAINT fk_t_dishes_cuisines  FOREIGN KEY (dish_cuisine_id)
      REFERENCES u_dw_stage.t_dish_cuisines (dish_cuisine_id)
      ON DELETE CASCADE;


--==============================================================
-- Table: t_restaurants
--==============================================================

ALTER TABLE u_dw_stage.t_restaurants
   ADD CONSTRAINT fk_t_restaurants_types  FOREIGN KEY (restaurant_type_id)
      REFERENCES u_dw_stage.t_restaurant_types (restaurant_type_id)
      ON DELETE CASCADE;

ALTER TABLE u_dw_stage.t_restaurants
   ADD CONSTRAINT fk_t_restaurants_geo  FOREIGN KEY (restaurant_geo_id)
      REFERENCES u_dw_stage.t_geo_objects (geo_id)
      ON DELETE CASCADE;


--==============================================================
-- Table: t_periods
--==============================================================

ALTER TABLE u_dw_stage.t_periods
   ADD CONSTRAINT fk_t_periods_types  FOREIGN KEY (period_type_id)
      REFERENCES u_dw_stage.t_type_periods (period_type_id)
      ON DELETE CASCADE;

--==============================================================
-- Table: t_operations
--==============================================================

ALTER TABLE u_dw_stage.t_operations
   ADD CONSTRAINT fk_t_operations_dishes  FOREIGN KEY (dish_id)
      REFERENCES u_dw_stage.t_dishes (dish_id)
      ON DELETE CASCADE;

ALTER TABLE u_dw_stage.t_operations
   ADD CONSTRAINT fk_t_operations_restaurants FOREIGN KEY (restaurant_id)
      REFERENCES u_dw_stage.t_restaurants (restaurant_id)
      ON DELETE CASCADE;