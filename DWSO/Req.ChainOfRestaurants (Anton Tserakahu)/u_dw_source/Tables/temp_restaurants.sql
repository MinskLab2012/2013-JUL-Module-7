
DROP TABLE temp_restaurants;

CREATE TABLE temp_restaurants
(
   restaurant_code NUMBER ( 10 )
 , restaurant_name VARCHAR2 ( 150 )
 , restaurant_desc VARCHAR2 ( 2000 )
 , restaurant_email VARCHAR2 ( 200 )
 , restaurant_phone_number VARCHAR2 ( 30 )
 , restaurant_address VARCHAR2 ( 400 )
 , restaurant_numb_of_seats NUMBER ( 4 )
 , restaurant_numb_of_dining_ro NUMBER ( 4 )
 , restaurant_type_name VARCHAR2 ( 50 )
 , restaurant_city VARCHAR2 ( 70 )
 , restaurant_country_iso_code VARCHAR2 ( 10 )
 , restaurant_country_name VARCHAR2 ( 70 )
);

INSERT INTO temp_restaurants
   ( SELECT numb AS restaurant_code
          , 'Restaurant n. ' || numb AS restaurant_name
          , 'Restaurant in ' || cust_city || ' at ' || cust_street_address AS restaurant_desc
          , 'www.ant.' || country_name || '.' || cust_city || '.com' AS restaurant_email
          ,    '+'
            || TO_CHAR ( ROUND ( dbms_random.VALUE ( 100
                                                   , 999 ) )
                       , '999' )
            || ' ('
            || TO_CHAR ( ROUND ( dbms_random.VALUE ( 00
                                                   , 99 ) )
                       , '00' )
            || ' ) '
            || TO_CHAR ( ROUND ( dbms_random.VALUE ( 100
                                                   , 999 ) )
                       , '999' )
            || ' -'
            || TO_CHAR ( ROUND ( dbms_random.VALUE ( 00
                                                   , 99 ) )
                       , '00' )
            || ' -'
            || TO_CHAR ( ROUND ( dbms_random.VALUE ( 00
                                                   , 99 ) )
                       , '00' )
               AS restaurant_phone_number
          , cust_street_address || ', Postal Code: ' || cust_postal_code AS restaurant_address
          , ROUND ( dbms_random.VALUE ( 20
                                      , 110 ) )
               restaurant_numb_of_seats
          , ROUND ( dbms_random.VALUE ( 1
                                      , 5 ) )
               restaurant_numb_of_dining_room
          , CASE ROUND ( dbms_random.VALUE ( 1
                                           , 6 ) )
               WHEN 1 THEN 'Fast food'
               WHEN 2 THEN 'Fast casual'
               WHEN 3 THEN 'Casual dining'
               WHEN 4 THEN 'Family style'
               WHEN 5 THEN 'Fine dining'
               ELSE 'Combo'
            END
               AS restaurant_type_name
          , cust_city AS restaurant_city
          , country_iso_code AS restaurant_country_iso_code
          , country_name AS restaurant_country_name
       FROM temp_city_addr );

COMMIT;