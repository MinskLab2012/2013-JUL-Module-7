

--system role:
--grant select on U_DW_EXT_REFERENCES.CLS_RESTAURANTS to U_DW_REFERENCES;

SELECT ROWNUM AS city_id
     , restaurant_city AS city
     , cntr.geo_id AS paren_geo_id
  FROM    u_dw_ext_references.cls_restaurants city
       LEFT JOIN
          cu_countries cntr
       ON city.restaurant_country_iso_code = cntr.country_code_a2;

DROP TABLE lc_cities;

CREATE TABLE lc_cities
(
   geo_id         NUMBER ( 22 ) NOT NULL
 , city_id        NUMBER ( 22 ) NOT NULL
 , city_desc      VARCHAR2 ( 200 CHAR ) NOT NULL
 , localization_id NUMBER ( 22 ) NOT NULL
);


INSERT INTO lc_cities
   SELECT ROWNUM
          + ( SELECT MAX ( geo_id )
                FROM t_geo_objects )
             AS geo_id
        , ROWNUM AS city_id
        , restaurant_city AS city
        , 1 AS loc
     FROM    (SELECT DISTINCT restaurant_city
                            , restaurant_country_iso_code
                            , restaurant_country_name
                FROM u_dw_ext_references.cls_restaurants) city
          LEFT JOIN
             cu_countries cntr
          ON ( city.restaurant_country_iso_code = cntr.country_code_a2 )
         AND ( city.restaurant_country_name = cntr.region_desc );

COMMIT;


INSERT INTO t_geo_types
     VALUES ( 55
            , 'CITY'
            , 'List all cities' );

INSERT INTO t_geo_objects
   SELECT geo_id
        , 55
        , city_id
     FROM lc_cities;

ALTER TABLE t_geo_object_links ADD PARTITION p_city2countries VALUES (7) TABLESPACE ts_references_data_01;


INSERT INTO t_geo_object_links
   SELECT DISTINCT cntr.geo_id AS paren_geo_id
                 , lc_cities.geo_id
                 , 7 AS lvl
     FROM u_dw_ext_references.cls_restaurants city
          LEFT JOIN cu_countries cntr
             ON ( city.restaurant_country_iso_code = cntr.country_code_a2 )
          LEFT JOIN lc_cities
             ON lc_cities.city_desc = city.restaurant_city
    WHERE cntr.region_desc NOT IN
             ( 'United States Virgin Islands'
            , 'China, Hong Kong Special Administrative Region'
            , 'China, Macao Special Administrative Region' );

COMMIT;