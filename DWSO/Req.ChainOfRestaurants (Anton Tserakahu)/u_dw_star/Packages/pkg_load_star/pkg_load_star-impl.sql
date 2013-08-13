/* Formatted on 13.08.2013 15:59:02 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_star
AS
   PROCEDURE load_dim_dishes
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dim_dishes_scd';

      --Extract data
      INSERT INTO dim_dishes_scd ( dish_sur_id
                                 , dish_id
                                 , dish_code
                                 , dish_name
                                 , dish_desc
                                 , dish_weight
                                 , dish_type_id
                                 , dish_type_name
                                 , dish_type_desc
                                 , dish_cuisine_id
                                 , dish_cuisine_name
                                 , dish_cuisine_desc
                                 , start_unit_price_dol
                                 , from_dt
                                 , to_dt
                                 , is_valid
                                 , insert_dt )
         SELECT dish_sur_id
              , dish_id
              , dish_code
              , dish_name
              , dish_desc
              , dish_weight
              , dish_type_id
              , dish_type_name
              , dish_type_desc
              , dish_cuisine_id
              , dish_cuisine_name
              , dish_cuisine_desc
              , start_unit_price_dol
              , from_dt
              , to_dt
              , is_valid
              , SYSDATE
           FROM u_dw_cls_star.cls_dim_dishes_scd;

      --Commit Data
      COMMIT;
   END load_dim_dishes;



   PROCEDURE load_dim_geo
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dim_geo_locations';

      --Extract data

      INSERT INTO dim_geo_locations ( geo_sur_id
                                    , country_geo_id
                                    , country_id
                                    , country_code_a2
                                    , country_code_a3
                                    , country_desc
                                    , region_geo_id
                                    , region_id
                                    , region_code
                                    , region_desc
                                    , part_geo_id
                                    , part_id
                                    , part_code
                                    , part_desc
                                    , geo_system_geo_id
                                    , geo_system_id
                                    , geo_system_code
                                    , geo_system_desc
                                    , from_dt
                                    , to_dt
                                    , is_valid
                                    , insert_dt )
         SELECT geo_sur_id
              , country_geo_id
              , country_id
              , country_code_a2
              , country_code_a3
              , country_desc
              , region_geo_id
              , region_id
              , region_code
              , region_desc
              , part_geo_id
              , part_id
              , part_code
              , part_desc
              , geo_system_geo_id
              , geo_system_id
              , geo_system_code
              , geo_system_desc
              , from_dt
              , to_dt
              , is_valid
              , SYSDATE
           FROM u_dw_cls_star.cls_dim_geo_locations;

      --Commit Data
      COMMIT;
   END load_dim_geo;



   PROCEDURE load_dim_periods
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dim_gen_periods';

      --Extract data

      INSERT INTO dim_gen_periods ( period_id
                                  , period_code
                                  , period_desc
                                  , start_dt
                                  , end_dt
                                  , period_type_id
                                  , period_type_name
                                  , period_type_desc
                                  , insert_dt )
         SELECT period_id
              , period_code
              , period_desc
              , start_dt
              , end_dt
              , period_type_id
              , period_type_name
              , period_type_desc
              , SYSDATE
           FROM u_dw_cls_star.cls_dim_gen_periods;

      --Commit Data
      COMMIT;
   END load_dim_periods;



   PROCEDURE load_dim_restaurants
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dim_restaurants';

      --Extract data

      INSERT INTO dim_restaurants ( restaurant_id
                                  , restaurant_code
                                  , restaurant_name
                                  , restaurant_desc
                                  , restaurant_email
                                  , restaurant_phone_number
                                  , restaurant_address
                                  , restaurant_number_of_seats
                                  , restaurant_number_of_dining_ro
                                  , restaurant_type_id
                                  , restaurant_type_name
                                  , restaurant_type_desc
                                  , restaurant_city_geo_id
                                  , restaurant_city_id
                                  , restaurant_city_desc
                                  , insert_dt )
         SELECT restaurant_id
              , restaurant_code
              , restaurant_name
              , restaurant_desc
              , restaurant_email
              , restaurant_phone_number
              , restaurant_address
              , restaurant_number_of_seats
              , restaurant_number_of_dining_ro
              , restaurant_type_id
              , restaurant_type_name
              , restaurant_type_desc
              , restaurant_city_geo_id
              , restaurant_city_id
              , restaurant_city_desc
              , SYSDATE
           FROM u_dw_cls_star.cls_dim_restaurants;

      --Commit Data
      COMMIT;
   END load_dim_restaurants;



   PROCEDURE load_dim_times
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dim_time_dd';

      --Extract data

      INSERT INTO dim_time_dd
         SELECT *
           FROM u_dw_cls_star.cls_dim_time_dd;

      --Commit Data
      COMMIT;
   END load_dim_times;



   PROCEDURE load_fct_operations_dd
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE fct_operations_dd';

      --Extract data

      INSERT INTO fct_operations_dd ( event_dt
                                    , restaurant_id
                                    , dish_sur_id
                                    , period_id
                                    , geo_id
                                    , fct_unit_amount
                                    , fct_total_sales_dol
                                    , insert_dt )
         SELECT event_dt
              , restaurant_id
              , dish_sur_id
              , period_id
              , geo_id
              , fct_unit_amount
              , fct_total_sales_dol
              , SYSDATE
           FROM u_dw_cls_star.cls_fct_operations_dd oper
          WHERE oper.event_dt > (SELECT NVL(MAX ( event_dt ), to_date('01.01.1990', 'DD.MM.YYYY'))
                                   FROM fct_operations_dd);

      --Commit Data
      COMMIT;
   END load_fct_operations_dd;
END pkg_load_star;
/