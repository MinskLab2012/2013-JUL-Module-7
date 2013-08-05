/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "t_geo_objects"                                       */
/*==============================================================*/
create table "t_geo_objects" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "geo_type_id"        NUMBER(22,0)         not null,
   "geo_code_id"        NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECTS primary key ("geo_id")
         using index tablespace TS_REFERENCES_IDX_01,
   constraint FK_T_GEO_OB_REFERENCE_T_GEO_TY foreign key ("geo_type_id")
         references "t_geo_types" ("geo_type_id")
)
tablespace TS_REFERENCES_DATA_01;

comment on table "t_geo_objects" is
'Abstarct Referense store all Geography objects';

comment on column "t_geo_objects"."geo_id" is
'Unique ID for All Geography objects';

comment on column "t_geo_objects"."geo_type_id" is
'Code of Geography Type Objects';

comment on column "t_geo_objects"."geo_code_id" is
'NK: Source ID from source systems';

/*==============================================================*/
/* Index: "ui_geo_objects_codes"                                */
/*==============================================================*/
create unique index "ui_geo_objects_codes" on "t_geo_objects" (
   "geo_type_id" ASC,
   "geo_code_id" ASC
)
tablespace TS_REFERENCES_IDX_01;

