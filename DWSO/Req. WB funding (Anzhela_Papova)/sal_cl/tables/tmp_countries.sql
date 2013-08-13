/* Formatted on 12.08.2013 13:23:02 (QP5 v5.139.911.3011) */
--DROP TABLE tmp_countries CASCADE CONSTRAINTS PURGE;

CREATE TABLE tmp_countries
(
   country_geo_id NUMBER NOT NULL
 , country_id     NUMBER
 , country_code_a2 VARCHAR2 ( 30 )
 , country_code_a3 VARCHAR2 ( 30 )
 , country_desc   VARCHAR2 ( 200 )
 , region_geo_id  NUMBER
 , region_id      NUMBER
 , region_code    VARCHAR2 ( 30 )
 , region_desc    VARCHAR2 ( 200 )
 , part_geo_id    NUMBER
 , part_id        NUMBER
 , part_code      VARCHAR2 ( 30 )
 , part_desc      VARCHAR2 ( 200 )
 , geo_system_geo_id NUMBER
 , geo_system_id  NUMBER
 , geo_system_code VARCHAR2 ( 30 )
 , geo_system_desc VARCHAR2 ( 200 )
 , sub_group_geo_id NUMBER
 , sub_group_id   NUMBER
 , sub_group_code VARCHAR2 ( 30 )
 , sub_group_desc VARCHAR2 ( 200 )
 , group_geo_id   NUMBER
 , GROUP_ID       NUMBER
 , group_code     VARCHAR2 ( 30 )
 , group_desc     VARCHAR2 ( 200 )
 , grp_system_geo_id NUMBER
 , grp_system_id  NUMBER
 , grp_system_code VARCHAR2 ( 30 )
 , grp_system_desc VARCHAR2 ( 200 )
 , level_code     VARCHAR2 ( 20 )
);