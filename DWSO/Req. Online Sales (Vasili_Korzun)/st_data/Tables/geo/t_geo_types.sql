/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "t_geo_types"                                         */
/*==============================================================*/
create table "t_geo_types" 
(
   "geo_type_id"        NUMBER(22,0)         not null,
   "geo_type_code"      VARCHAR2(30 CHAR)    not null
      constraint CKC_GEO_TYPE_CODE_T_GEO_TY check ("geo_type_code" = upper("geo_type_code")),
   "geo_type_desc"      VARCHAR2(200 CHAR)   not null,
   constraint PK_T_GEO_TYPES primary key ("geo_type_id")
);

comment on table "t_geo_types" is
'Reference store all abstraction types of geograhy objects';

comment on column "t_geo_types"."geo_type_id" is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column "t_geo_types"."geo_type_code" is
'Code of Geography Type Objects';

comment on column "t_geo_types"."geo_type_desc" is
'Description of Geography Type Objects (Not Localizable)';

