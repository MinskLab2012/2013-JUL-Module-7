/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "t_geo_systems"                                       */
/*==============================================================*/
create table "t_geo_systems" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "geo_system_id"      NUMBER(22,0)         not null,
   constraint PK_T_GEO_SYSTEMS primary key ("geo_id"),
   constraint FK_T_GEO_SY_REFERENCE_T_GEO_OB foreign key ("geo_id")
         references "t_geo_objects" ("geo_id")
);

comment on table "t_geo_systems" is
'Referense store:  Geographical Systems of Specifications';

comment on column "t_geo_systems"."geo_id" is
'Unique ID for All Geography objects';

comment on column "t_geo_systems"."geo_system_id" is
'ID Code of Geography System Specifications';

