CREATE OR REPLACE PACKAGE BODY pkg_etl_restaurants_dw_stage
AS

   -- Load All Restaurant Types
   PROCEDURE load_t_restaurant_types
   AS
   BEGIN
      DECLARE
         CURSOR cur_1
         IS
            ( SELECT stage_r_types.restaurant_type_id AS type_id_stage
                   , source_r_types.restaurant_type_name AS type_name_source
                   , stage_r_types.restaurant_type_name AS type_name_stage
                   , 'Restaurant type - ' || source_r_types.restaurant_type_name AS type_desc_source
                   , stage_r_types.restaurant_type_desc AS type_desc_stage
                FROM    (SELECT DISTINCT restaurant_type_name
                           FROM u_dw_cls_stage.cls_restaurants) source_r_types
                     LEFT JOIN
                        t_restaurant_types stage_r_types
                     ON source_r_types.restaurant_type_name = stage_r_types.restaurant_type_name );

         record_1       cur_1%ROWTYPE;
      BEGIN
         OPEN cur_1;

         LOOP
            FETCH cur_1
            INTO record_1;

            EXIT WHEN cur_1%NOTFOUND;

            IF ( record_1.type_id_stage IS NULL ) THEN
               INSERT INTO t_restaurant_types ( restaurant_type_id
                                              , restaurant_type_name
                                              , restaurant_type_desc
                                              , insert_dt
                                              , update_dt )
                    VALUES ( seq_t_restaurant_types.NEXTVAL
                           , record_1.type_name_source
                           , record_1.type_desc_source
                           , SYSDATE
                           , NULL );

               COMMIT;
            ELSIF ( record_1.type_desc_source <> record_1.type_desc_stage ) THEN
               UPDATE t_restaurant_types
                  SET restaurant_type_desc = record_1.type_desc_source
                    , update_dt    = SYSDATE
                WHERE t_restaurant_types.restaurant_type_id = record_1.type_id_stage;

               COMMIT;
            END IF;
         END LOOP;

         IF cur_1%ISOPEN THEN
            CLOSE cur_1;
         END IF;
      END;
   END load_t_restaurant_types;


   -- Load All Restaurants 
   PROCEDURE load_t_restaurants
   AS
   BEGIN
      DECLARE
         CURSOR cur_1
         IS
            ( SELECT DISTINCT stage_rest.restaurant_id AS id_stage
                            , source_rest.restaurant_code AS code_source
                            , stage_rest.restaurant_code AS code_stage
                            , source_rest.restaurant_name AS name_source
                            , stage_rest.restaurant_name AS name_stage
                            , source_rest.restaurant_desc AS desc_source
                            , stage_rest.restaurant_desc AS desc_stage
                            , source_rest.restaurant_email AS email_source
                            , stage_rest.restaurant_email AS email_stage
                            , source_rest.restaurant_phone_number AS phone_number_source
                            , stage_rest.restaurant_phone_number AS phone_number_stage
                            , source_rest.restaurant_address AS address_source
                            , stage_rest.restaurant_address AS address_stage
                            , source_rest.restaurant_numb_of_seats AS numb_of_seats_source
                            , stage_rest.restaurant_numb_of_seats AS numb_of_seats_stage
                            , source_rest.restaurant_numb_of_dining_ro AS numb_of_dining_room_source
                            , stage_rest.restaurant_numb_of_dining_room AS numb_of_dining_room_stage
                            , t_restaurant_types.restaurant_type_id AS type_id_source
                            , stage_rest.restaurant_type_id AS type_id_stage
                            , cities.geo_id AS geo_id_source
                            , stage_rest.restaurant_geo_id AS geo_id_stage
                FROM u_dw_cls_stage.cls_restaurants source_rest
                     LEFT JOIN u_dw_stage.t_cities cities
                        ON source_rest.restaurant_city = cities.city_desc
                     LEFT JOIN t_restaurant_types
                        ON source_rest.restaurant_type_name = t_restaurant_types.restaurant_type_name
                     LEFT JOIN (SELECT t1.*
                                     , t2.restaurant_type_name
                                     , t2.restaurant_type_desc
                                  FROM    t_restaurants t1
                                       LEFT JOIN
                                          t_restaurant_types t2
                                       ON t1.restaurant_type_id = t2.restaurant_type_id) stage_rest
                        ON stage_rest.restaurant_code = source_rest.restaurant_code );

         record_1       cur_1%ROWTYPE;
      BEGIN
         OPEN cur_1;

         LOOP
            FETCH cur_1
            INTO record_1;

            EXIT WHEN cur_1%NOTFOUND;

            IF ( record_1.id_stage IS NULL ) THEN
               INSERT INTO t_restaurants ( restaurant_id
                                         , restaurant_code
                                         , restaurant_name
                                         , restaurant_desc
                                         , restaurant_email
                                         , restaurant_phone_number
                                         , restaurant_address
                                         , restaurant_numb_of_seats
                                         , restaurant_numb_of_dining_room
                                         , restaurant_type_id
                                         , restaurant_geo_id
                                         , insert_dt
                                         , update_dt )
                    VALUES ( seq_t_restaurants.NEXTVAL
                           , record_1.code_source
                           , record_1.name_source
                           , record_1.desc_source
                           , record_1.email_source
                           , record_1.phone_number_source
                           , record_1.address_source
                           , record_1.numb_of_seats_source
                           , record_1.numb_of_dining_room_source
                           , record_1.type_id_source
                           , record_1.geo_id_source
                           , SYSDATE
                           , NULL );

               COMMIT;
            ELSIF ( record_1.code_source <> record_1.code_stage
                OR  record_1.name_source <> record_1.name_stage
                OR  record_1.desc_source <> record_1.desc_stage
                OR  record_1.email_source <> record_1.email_stage
                OR  record_1.phone_number_source <> record_1.phone_number_stage
                OR  record_1.address_source <> record_1.address_stage
                OR  record_1.numb_of_seats_source <> record_1.numb_of_seats_stage
                OR  record_1.numb_of_dining_room_source <> record_1.numb_of_dining_room_stage
                OR  record_1.type_id_source <> record_1.type_id_stage
                OR  record_1.geo_id_source <> record_1.geo_id_stage ) THEN
               UPDATE t_restaurants
                  SET restaurant_code = record_1.code_source
                    , restaurant_name = record_1.name_source
                    , restaurant_desc = record_1.desc_source
                    , restaurant_email = record_1.email_source
                    , restaurant_phone_number = record_1.phone_number_source
                    , restaurant_address = record_1.address_source
                    , restaurant_numb_of_seats = record_1.numb_of_seats_source
                    , restaurant_numb_of_dining_room = record_1.numb_of_dining_room_source
                    , restaurant_type_id = record_1.type_id_source
                    , restaurant_geo_id = record_1.geo_id_source
                    , update_dt    = SYSDATE
                WHERE t_restaurants.restaurant_code = record_1.code_source;

               COMMIT;
            END IF;
         END LOOP;

         IF cur_1%ISOPEN THEN
            CLOSE cur_1;
         END IF;
      END;
   END load_t_restaurants;
END pkg_etl_restaurants_dw_stage;
/