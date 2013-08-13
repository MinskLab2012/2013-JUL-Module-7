/* Formatted on 13.08.2013 15:28:03 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_cls_star
AS
   PROCEDURE load_cls_dim_dishes
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_dishes_scd';

      --Extract data
      INSERT INTO cls_dim_dishes_scd ( dish_sur_id
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
         SELECT ROWNUM AS dish_sur_id
              , dishes.dish_id
              , dishes.dish_code
              , dishes.dish_name
              , dishes.dish_desc
              , dishes.dish_weight
              , dishes.dish_type_id
              , typ.dish_type_name
              , typ.dish_type_desc
              , dishes.dish_cuisine_id
              , cuisines.dish_cuisine_name
              , cuisines.dish_cuisine_desc
              , history.price AS start_unit_price_dol
              , history.from_dt
              , history.to_dt
              , history.is_actual
              , SYSDATE
           FROM u_dw_stage.t_dishes dishes
                LEFT JOIN u_dw_stage.t_dish_cuisines cuisines
                   ON cuisines.dish_cuisine_id = dishes.dish_cuisine_id
                LEFT JOIN u_dw_stage.t_dish_types typ
                   ON typ.dish_type_id = dishes.dish_type_id
                LEFT JOIN (SELECT t_act_old.price_new AS price
                                , t_act_old.dish_id
                                , t_act_old.action_dt AS from_dt
                                , t_act_new.action_dt AS to_dt
                                , CASE WHEN ( t_act_new.action_dt IS NULL ) THEN 'Actual data' ELSE 'Old data' END
                                     AS is_actual
                             FROM    u_dw_stage.t_dish_actions t_act_old
                                  LEFT JOIN
                                     u_dw_stage.t_dish_actions t_act_new
                                  ON ( t_act_old.price_new = t_act_new.price_old
                                  AND t_act_old.dish_id = t_act_new.dish_id )) history
                   ON history.dish_id = dishes.dish_id;

      --Commit Data
      COMMIT;
   END load_cls_dim_dishes;



   PROCEDURE load_cls_dim_geo
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_geo_locations';

      --Extract data

      INSERT INTO cls_dim_geo_locations ( geo_sur_id
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
         SELECT --country
               ROWNUM AS surr_id
              , table_hier.country_geo_id AS country_geo_id
              , cntr.country_id
              , cntr.country_code_a2
              , cntr.country_code_a3
              , cntr.country_desc AS country_desc
              --region
              , NVL ( table_hier.region_geo_id, -99 ) AS region_geo_id
              , NVL ( reg.region_id, -99 ) AS region_id
              , NVL ( reg.region_code, 'n.d.' ) AS region_code
              , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
              -- part
              , NVL ( table_hier.part_geo_id, -99 ) AS part_geo_id
              , NVL ( part.part_id, -99 ) AS part_id
              , NVL ( part.part_code, 'n.d.' ) AS part_code
              , NVL ( part.part_desc, 'n.d.' ) AS part_desc
              -- geo_systems
              , NVL ( table_hier.system_geo_id, -99 ) AS geo_system_geo_id
              , NVL ( g_sys.geo_system_id, -99 ) AS geo_system_id
              , NVL ( g_sys.geo_system_code, 'n.d.' ) AS geo_system_code
              , NVL ( g_sys.geo_system_desc, 'n.d.' ) AS geo_system_desc
              --TA
              , table_hier.from_dt
              , table_hier.to_dt
              , table_hier.status
              , SYSDATE
           FROM (  SELECT country_geo_links.country_geo_id
                        , country_geo_links.region_geo_id
                        , SUM ( region_geo_links.part_geo_id ) AS part_geo_id
                        , SUM ( region_geo_links.system_geo_id ) AS system_geo_id
                        , country_geo_links.from_dt
                        , country_geo_links.to_dt
                        , country_geo_links.status
                     FROM    (    SELECT DISTINCT
                                         CONNECT_BY_ROOT ( links.child_geo_id ) country_geo_id
                                       , CASE WHEN ( links.link_type_id = 3 ) THEN links.parent_geo_id ELSE NULL END
                                            AS region_geo_id
                                       , links.from_dt
                                       , links.to_dt
                                       , CASE WHEN ( links.to_dt IS NULL ) THEN 'Actual data' ELSE 'Old data' END AS status
                                    FROM (SELECT t_act_old.parent_geo_id_new AS parent_geo_id
                                               , t_act_old.child_geo_id
                                               , t_act_old.link_type_id
                                               , t_act_old.action_dt AS from_dt
                                               , t_act_new.action_dt AS to_dt
                                            FROM    u_dw_stage.t_geo_actions t_act_old
                                                 LEFT JOIN
                                                    u_dw_stage.t_geo_actions t_act_new
                                                 ON ( t_act_old.parent_geo_id_new = t_act_new.parent_geo_id_old
                                                 AND t_act_old.child_geo_id = t_act_new.child_geo_id
                                                 AND t_act_old.link_type_id = t_act_new.link_type_id )) links
                              CONNECT BY PRIOR links.parent_geo_id = links.child_geo_id
                              START WITH links.child_geo_id IN (SELECT DISTINCT geo_id
                                                                  FROM u_dw_stage.w_countries)
                                ORDER BY country_geo_id) country_geo_links
                          LEFT JOIN
                             (    SELECT DISTINCT
                                         CONNECT_BY_ROOT ( links.child_geo_id ) region_geo_id
                                       , CASE WHEN ( links.link_type_id = 2 ) THEN links.parent_geo_id ELSE NULL END
                                            AS part_geo_id
                                       , CASE WHEN ( links.link_type_id = 1 ) THEN links.parent_geo_id ELSE NULL END
                                            AS system_geo_id
                                    FROM u_dw_stage.t_geo_object_links links
                              CONNECT BY PRIOR links.parent_geo_id = links.child_geo_id
                              START WITH links.child_geo_id IN (SELECT DISTINCT geo_id
                                                                  FROM u_dw_stage.w_geo_regions)
                                ORDER BY region_geo_id) region_geo_links
                          ON country_geo_links.region_geo_id = region_geo_links.region_geo_id
                    WHERE country_geo_links.region_geo_id IS NOT NULL
                 GROUP BY country_geo_links.country_geo_id
                        , country_geo_links.region_geo_id
                        , country_geo_links.from_dt
                        , country_geo_links.to_dt
                        , country_geo_links.status) table_hier
                LEFT JOIN u_dw_stage.vl_countries cntr
                   ON cntr.geo_id = table_hier.country_geo_id
                LEFT JOIN u_dw_stage.vl_geo_regions reg
                   ON reg.geo_id = table_hier.region_geo_id
                LEFT JOIN u_dw_stage.vl_geo_parts part
                   ON part.geo_id = table_hier.part_geo_id
                LEFT JOIN u_dw_stage.vl_geo_systems g_sys
                   ON g_sys.geo_id = table_hier.system_geo_id;

      --Commit Data
      COMMIT;
   END load_cls_dim_geo;



   PROCEDURE load_cls_dim_periods
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_gen_periods';

      --Extract data

      INSERT INTO cls_dim_gen_periods ( period_id
                                      , period_code
                                      , period_desc
                                      , start_dt
                                      , end_dt
                                      , period_type_id
                                      , period_type_name
                                      , period_type_desc
                                      , insert_dt )
         SELECT per.period_id
              , per.period_code
              , per.period_desc
              , per.start_dt
              , per.end_dt
              , per.period_type_id
              , t_per.period_type_name
              , t_per.period_type_desc
              , SYSDATE
           FROM    u_dw_stage.t_periods per
                LEFT JOIN
                   u_dw_stage.t_type_periods t_per
                ON per.period_type_id = t_per.period_type_id;

      --Commit Data
      COMMIT;
   END load_cls_dim_periods;



   PROCEDURE load_cls_dim_restaurants
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_restaurants';

      --Extract data

      INSERT INTO cls_dim_restaurants ( restaurant_id
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
         SELECT rest.restaurant_id
              , rest.restaurant_code
              , rest.restaurant_name
              , rest.restaurant_desc
              , rest.restaurant_email
              , rest.restaurant_phone_number
              , rest.restaurant_address
              , rest.restaurant_numb_of_seats
              , rest.restaurant_numb_of_dining_room
              , rest.restaurant_type_id
              , typ.restaurant_type_name
              , typ.restaurant_type_desc
              , city.geo_id
              , city.city_id
              , city.city_desc
              , SYSDATE
           FROM u_dw_stage.t_restaurants rest
                LEFT JOIN u_dw_stage.t_restaurant_types typ
                   ON rest.restaurant_type_id = typ.restaurant_type_id
                LEFT JOIN u_dw_stage.t_cities city
                   ON city.geo_id = rest.restaurant_geo_id;

      --Commit Data
      COMMIT;
   END load_cls_dim_restaurants;



   PROCEDURE load_cls_dim_times
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_time_dd';

      --Extract data

      INSERT INTO cls_dim_time_dd
         SELECT TRUNC ( sd + rn ) time_id
              , TO_CHAR ( sd + rn
                        , 'fmDay' )
                   day_name
              , TO_CHAR ( sd + rn
                        , 'D' )
                   day_number_in_week
              , TO_CHAR ( sd + rn
                        , 'DD' )
                   day_number_in_month
              , TO_CHAR ( sd + rn
                        , 'DDD' )
                   day_number_in_year
              , TO_CHAR ( sd + rn
                        , 'W' )
                   calendar_week_number
              , ( CASE
                    WHEN TO_CHAR ( sd + rn
                                 , 'D' ) IN (1, 2, 3, 4, 5, 6) THEN
                       NEXT_DAY ( sd + rn
                                , 'Saturday' )
                    ELSE
                       ( sd + rn )
                 END )
                   week_ending_date
              , TO_CHAR ( sd + rn
                        , 'MM' )
                   calendar_month_number
              , TO_CHAR ( LAST_DAY ( sd + rn )
                        , 'DD' )
                   days_in_cal_month
              , LAST_DAY ( sd + rn ) end_of_cal_month
              , TO_CHAR ( sd + rn
                        , 'FMMonth' )
                   calendar_month_name
              , (  ( CASE
                       WHEN TO_CHAR ( sd + rn
                                    , 'Q' ) = 1 THEN
                          TO_DATE ( '03/31/'
                                    || TO_CHAR ( sd + rn
                                               , 'YYYY' )
                                  , 'MM/DD/YYYY' )
                       WHEN TO_CHAR ( sd + rn
                                    , 'Q' ) = 2 THEN
                          TO_DATE ( '06/30/'
                                    || TO_CHAR ( sd + rn
                                               , 'YYYY' )
                                  , 'MM/DD/YYYY' )
                       WHEN TO_CHAR ( sd + rn
                                    , 'Q' ) = 3 THEN
                          TO_DATE ( '09/30/'
                                    || TO_CHAR ( sd + rn
                                               , 'YYYY' )
                                  , 'MM/DD/YYYY' )
                       WHEN TO_CHAR ( sd + rn
                                    , 'Q' ) = 4 THEN
                          TO_DATE ( '12/31/'
                                    || TO_CHAR ( sd + rn
                                               , 'YYYY' )
                                  , 'MM/DD/YYYY' )
                    END )
                 - TRUNC ( sd + rn
                         , 'Q' )
                 + 1 )
                   days_in_cal_quarter
              , TRUNC ( sd + rn
                      , 'Q' )
                   beg_of_cal_quarter
              , ( CASE
                    WHEN TO_CHAR ( sd + rn
                                 , 'Q' ) = 1 THEN
                       TO_DATE ( '03/31/'
                                 || TO_CHAR ( sd + rn
                                            , 'YYYY' )
                               , 'MM/DD/YYYY' )
                    WHEN TO_CHAR ( sd + rn
                                 , 'Q' ) = 2 THEN
                       TO_DATE ( '06/30/'
                                 || TO_CHAR ( sd + rn
                                            , 'YYYY' )
                               , 'MM/DD/YYYY' )
                    WHEN TO_CHAR ( sd + rn
                                 , 'Q' ) = 3 THEN
                       TO_DATE ( '09/30/'
                                 || TO_CHAR ( sd + rn
                                            , 'YYYY' )
                               , 'MM/DD/YYYY' )
                    WHEN TO_CHAR ( sd + rn
                                 , 'Q' ) = 4 THEN
                       TO_DATE ( '12/31/'
                                 || TO_CHAR ( sd + rn
                                            , 'YYYY' )
                               , 'MM/DD/YYYY' )
                 END )
                   end_of_cal_quarter
              , TO_CHAR ( sd + rn
                        , 'Q' )
                   calendar_quarter_number
              , TO_CHAR ( sd + rn
                        , 'YYYY' )
                   calendar_year
              , ( TO_DATE ( '12/31/'
                            || TO_CHAR ( sd + rn
                                       , 'YYYY' )
                          , 'MM/DD/YYYY' )
                 - TRUNC ( sd + rn
                         , 'YEAR' ) )
                   days_in_cal_year
              , TRUNC ( sd + rn
                      , 'YEAR' )
                   beg_of_cal_year
              , TO_DATE ( '12/31/'
                          || TO_CHAR ( sd + rn
                                     , 'YYYY' )
                        , 'MM/DD/YYYY' )
                   end_of_cal_year
              , SYSDATE
           FROM (    SELECT TO_DATE ( '12/31/2011'
                                    , 'MM/DD/YYYY' )
                               sd
                          , ROWNUM rn
                       FROM DUAL
                 CONNECT BY LEVEL <= 366);

      --Commit Data
      COMMIT;
   END load_cls_dim_times;



   PROCEDURE load_cls_fct_operations_dd
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_fct_operations_dd';

      --Extract data

      INSERT INTO cls_fct_operations_dd ( event_dt
                                        , restaurant_id
                                        , dish_sur_id
                                        , period_id
                                        , geo_id
                                        , fct_unit_amount
                                        , fct_total_sales_dol
                                        , insert_dt )
           SELECT TRUNC ( oper.event_dt
                        , 'DD' )
                     event_dt
                , oper.restaurant_id
                , oper.dish_id
                , periods.period_id
                , links.parent_geo_id AS geo_id
                , SUM ( oper.unit_amount ) AS amount
                , SUM ( oper.total_price_dol ) AS sales_dol
                , SYSDATE
             FROM u_dw_stage.t_operations oper
                  LEFT JOIN u_dw_stage.t_periods periods
                     ON ( oper.event_dt >= periods.start_dt
                     AND oper.event_dt < periods.end_dt )
                  LEFT JOIN u_dw_stage.t_restaurants rest
                     ON rest.restaurant_id = oper.restaurant_id
                  LEFT JOIN u_dw_stage.t_cities city
                     ON rest.restaurant_geo_id = city.geo_id
                  LEFT JOIN u_dw_stage.w_geo_object_links links
                     ON links.child_geo_id = city.geo_id
         GROUP BY TRUNC ( oper.event_dt
                        , 'DD' )
                , oper.restaurant_id
                , oper.dish_id
                , periods.period_id
                , links.parent_geo_id;

      --Commit Data
      COMMIT;
   END load_cls_fct_operations_dd;
END pkg_load_cls_star;
/