
DROP TABLE u_dw_star.dim_geo_locations CASCADE CONSTRAINT;

/*==============================================================*/

/* Table: DIM_GEO_LOCATIONS                                     */

/*==============================================================*/

CREATE TABLE u_dw_star.dim_geo_locations
(
   geo_sur_id     NUMBER ( 20 ) NOT NULL
 , country_geo_id NUMBER ( 20 ) NOT NULL
 , country_id     NUMBER ( 20 ) NOT NULL
 , country_code_a2 VARCHAR2 ( 20 )
 , country_code_a3 VARCHAR2 ( 20 )
 , country_desc   VARCHAR2 ( 100 ) NOT NULL
 , region_geo_id  NUMBER ( 20 ) NOT NULL
 , region_id      NUMBER ( 20 ) NOT NULL
 , region_code    VARCHAR2 ( 20 )
 , region_desc    VARCHAR2 ( 100 ) NOT NULL
 , part_geo_id    NUMBER ( 20 ) NOT NULL
 , part_id        NUMBER ( 20 ) NOT NULL
 , part_code      VARCHAR2 ( 20 )
 , part_desc      VARCHAR2 ( 100 ) NOT NULL
 , geo_system_geo_id NUMBER ( 20 ) NOT NULL
 , geo_system_id  NUMBER ( 20 ) NOT NULL
 , geo_system_code VARCHAR2 ( 20 )
 , geo_system_desc VARCHAR2 ( 100 ) NOT NULL
 , from_dt        DATE
 , to_dt          DATE
 , is_valid       VARCHAR2 ( 50 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_geo_locations PRIMARY KEY ( geo_sur_id )
);