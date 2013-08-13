/* Formatted on 10.08.2013 13:51:01 (QP5 v5.139.911.3011) */
--DROP TABLE DIM_GEO_LOCATIONS_SCD CASCADE CONSTRAINTS;

CREATE TABLE dim_geo_locations_scd
(
   geo_surr_id    NUMBER ( 20 ) NOT NULL
 , geo_id         NUMBER ( 20 )
 , country_geo_id NUMBER ( 20 )
 , country_id     NUMBER ( 20 )
 , country_code_a2 VARCHAR2 ( 30 )
 , country_code_a3 VARCHAR2 ( 30 )
 , country_desc   VARCHAR2 ( 300 )
 , region_geo_id  NUMBER ( 20 )
 , region_id      NUMBER ( 20 )
 , region_code    VARCHAR2 ( 30 )
 , region_desc    VARCHAR2 ( 300 )
 , part_geo_id    NUMBER ( 20 )
 , part_id        NUMBER ( 20 )
 , part_code      VARCHAR2 ( 30 )
 , part_desc      VARCHAR2 ( 300 )
 , level_code     VARCHAR2 ( 50 )
 , valid_from     DATE
 , valid_to       DATE
);

INSERT INTO dim_geo_locations_scd
     VALUES ( -99
            , -99
            , -99
            , -99
            , 'n.a.'
            , 'n.a.'
            , 'not available'
            , -99
            , -99
            , 'n.a.'
            , 'not available'
            , -99
            , -99
            , 'n.a.'
            , 'not available'
            , NULL
            , NULL
            , NULL );

COMMIT;

GRANT DELETE,INSERT,UPDATE,SELECT ON dim_geo_locations_scd TO u_sal_cl;