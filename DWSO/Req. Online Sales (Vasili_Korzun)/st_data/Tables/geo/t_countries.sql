/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "t_countries"                                         */
/*==============================================================*/
create table "t_countries" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "country_id"         NUMBER(22,0)         not null,
   constraint PK_T_COUNTRIES primary key ("geo_id"),
   constraint FK_T_COUNTR_REFERENCE_T_GEO_OB foreign key ("geo_id")
         references "t_geo_objects" ("geo_id")
);

comment on table "t_countries" is
'Referense store: Geographical Countries';

comment on column "t_countries"."geo_id" is
'Unique ID for All Geography objects';

comment on column "t_countries"."country_id" is
'ID Code of Country';

