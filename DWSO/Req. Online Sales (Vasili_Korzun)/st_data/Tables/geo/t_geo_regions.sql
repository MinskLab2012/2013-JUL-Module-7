/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "t_geo_regions"                                       */
/*==============================================================*/
create table "t_geo_regions" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "region_id"          NUMBER(22,0)         not null,
   constraint PK_T_GEO_REGIONS primary key ("geo_id"),
   constraint FK_T_GEO_RE_REFERENCE_T_GEO_OB foreign key ("geo_id")
         references "t_geo_objects" ("geo_id")
)
organization index tablespace TS_REFERENCES_DATA_01;

comment on table "t_geo_regions" is
'Referense store: Geographical Continents - Regions';

comment on column "t_geo_regions"."geo_id" is
'Unique ID for All Geography objects';

comment on column "t_geo_regions"."region_id" is
'ID Code of Geographical Continent - Regions';

