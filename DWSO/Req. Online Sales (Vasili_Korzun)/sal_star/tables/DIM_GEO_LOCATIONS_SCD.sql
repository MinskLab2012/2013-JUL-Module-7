/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.08.2013 22:48:01                          */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_GEO_LOCATIONS_SCD                                 */
/*==============================================================*/

drop table DIM_GEO_LOCATIONS_SCD cascade constraints;
drop sequence seq_dim_geo_locations;
create table DIM_GEO_LOCATIONS_SCD 
(
   geo_surr_id        NUMBER(6,0)          not null,
   geo_id             NUMBER(5,0),
   geo_country_id     NUMBER(5,0),
   geo_country_code2  VARCHAR(36),
   geo_country_code3  VARCHAR(36),
   geo_country_desc   VARCHAR(100),
   geo_region_id      NUMBER(4,0),
   geo_region_code    VARCHAR(36),
   geo_region_desc    VARCHAR(100),
   geo_continent_id   NUMBER(3,0),
   geo_continent_desc VARCHAR(100),
   geo_system_id      NUMBER(4,0),
   geo_system_code    VARCHAR(36),
   geo_system_desc    VARCHAR(100),
   geo_level_code     VARCHAR(36),
   valid_from         DATE,
   valid_to           DATE,
   is_actual          VARCHAR(1),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_DIM_GEO_LOCATIONS_SCD primary key (geo_surr_id)
);

create sequence seq_dim_geo_locations
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
 grant insert on DIM_GEO_LOCATIONS_SCD to u_dw_references;
  grant select on DIM_GEO_LOCATIONS_SCD to u_dw_references;
   grant select on seq_dim_geo_locations to u_dw_references;
