/* Formatted on 12.08.2013 12:55:42 (QP5 v5.139.911.3011) */
--DROP TABLE dim_countries_scd CASCADE CONSTRAINTS PURGE;

CREATE TABLE dim_countries_scd
(
   country_surr_id NUMBER NOT NULL
 , country_geo_id NUMBER NOT NULL
 , country_id     NUMBER NOT NULL
 , country_code_a2 VARCHAR2 ( 30 ) NOT NULL
 , country_code_a3 VARCHAR2 ( 30 ) NOT NULL
 , country_desc   VARCHAR2 ( 200 ) NOT NULL
 , region_geo_id  NUMBER NOT NULL
 , region_id      NUMBER NOT NULL
 , region_code    VARCHAR2 ( 30 ) NOT NULL
 , region_desc    VARCHAR2 ( 200 ) NOT NULL
 , part_geo_id    NUMBER NOT NULL
 , part_id        NUMBER NOT NULL
 , part_code      VARCHAR2 ( 30 ) NOT NULL
 , part_desc      VARCHAR2 ( 200 ) NOT NULL
 , geo_system_geo_id NUMBER NOT NULL
 , geo_system_id  NUMBER NOT NULL
 , geo_system_code VARCHAR2 ( 30 ) NOT NULL
 , geo_system_desc VARCHAR2 ( 200 ) NOT NULL
 , sub_group_geo_id NUMBER NOT NULL
 , sub_group_id   NUMBER NOT NULL
 , sub_group_code VARCHAR2 ( 30 ) NOT NULL
 , sub_group_desc VARCHAR2 ( 200 ) NOT NULL
 , group_geo_id   NUMBER NOT NULL
 , GROUP_ID       NUMBER NOT NULL
 , group_code     VARCHAR2 ( 30 ) NOT NULL
 , group_desc     VARCHAR2 ( 200 ) NOT NULL
 , grp_system_geo_id NUMBER NOT NULL
 , grp_system_id  NUMBER NOT NULL
 , grp_system_code VARCHAR2 ( 30 ) NOT NULL
 , grp_system_desc VARCHAR2 ( 200 ) NOT NULL
 , level_code     VARCHAR2 ( 20 ) NOT NULL
 , valid_from     DATE NOT NULL
 , valid_to       DATE NOT NULL
 , is_active      VARCHAR2 ( 4 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_countries_scd PRIMARY KEY ( country_surr_id )
);



INSERT INTO dim_countries_scd ( country_surr_id
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
                              , sub_group_geo_id
                              , sub_group_id
                              , sub_group_code
                              , sub_group_desc
                              , group_geo_id
                              , GROUP_ID
                              , group_code
                              , group_desc
                              , grp_system_geo_id
                              , grp_system_id
                              , grp_system_code
                              , grp_system_desc
                              , level_code
                              , valid_from
                              , valid_to
                              , is_active
                              , insert_dt )
     VALUES ( -98
            , -98
            , -98
            , 'n.a.'
            , 'n.a.'
            , 'not available'
            , -98
            , -98
            , 'n.a.'
            , 'not available'
            , -98
            , -98
            , 'n.a.'
            , 'not available'
            , -98
            , -98
            , 'n.a.'
            , 'not available'
            , -98
            , -98
            , 'n.a.'
            , 'not available'
            , -98
            , -98
            , 'n.a.'
            , 'not available'
            , -98
            , -98
            , 'n.a.'
            , 'not available'
            , 'Country'
            , TO_DATE ( '01/01/1900'
                      , 'dd/mm/yyyy' )
            , TO_DATE ( '31/12/9999'
                      , 'dd/mm/yyyy' )
            , 'Y'
            , SYSDATE );

INSERT INTO dim_countries_scd ( country_surr_id
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
                              , sub_group_geo_id
                              , sub_group_id
                              , sub_group_code
                              , sub_group_desc
                              , group_geo_id
                              , GROUP_ID
                              , group_code
                              , group_desc
                              , grp_system_geo_id
                              , grp_system_id
                              , grp_system_code
                              , grp_system_desc
                              , level_code
                              , valid_from
                              , valid_to
                              , is_active
                              , insert_dt )
     VALUES ( -99
            , -99
            , -99
            , 'n.d.'
            , 'n.d.'
            , 'not defined'
            , -99
            , -99
            , 'n.d.'
            , 'not defined'
            , -99
            , -99
            , 'n.d.'
            , 'not defined'
            , -99
            , -99
            , 'n.d.'
            , 'not defined'
            , -99
            , -99
            , 'n.d.'
            , 'not defined'
            , -99
            , -99
            , 'n.d.'
            , 'not defined'
            , -99
            , -99
            , 'n.d.'
            , 'not defined'
            , 'Country'
            , TO_DATE ( '01/01/1900'
                      , 'dd/mm/yyyy' )
            , TO_DATE ( '31/12/9999'
                      , 'dd/mm/yyyy' )
            , 'Y'
            , SYSDATE );

COMMIT;