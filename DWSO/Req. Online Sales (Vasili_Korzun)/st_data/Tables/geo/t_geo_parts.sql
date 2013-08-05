/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "t_geo_parts"                                         */
/*==============================================================*/
create table "t_geo_parts" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "part_id"            NUMBER(22,0)         not null,
   constraint PK_T_GEO_PARTS primary key ("geo_id"),
   constraint FK_T_GEO_PA_REFERENCE_T_GEO_OB foreign key ("geo_id")
         references "t_geo_objects" ("geo_id")
);

comment on table "t_geo_parts" is
'Referense store: Geographical Parts of Worlds';

comment on column "t_geo_parts"."geo_id" is
'Unique ID for All Geography objects';

comment on column "t_geo_parts"."part_id" is
'ID Code of Geographical Part of World';

