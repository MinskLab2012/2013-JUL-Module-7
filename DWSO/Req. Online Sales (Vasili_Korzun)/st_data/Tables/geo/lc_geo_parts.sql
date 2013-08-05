/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "lc_geo_parts"                                        */
/*==============================================================*/
create table "lc_geo_parts" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "part_id"            NUMBER(22,0)         not null,
   "part_code"          VARCHAR2(30 CHAR)   
      constraint CHK_LC_CONTINENTS_CODE check ("part_code" is null or ("part_code" = upper("part_code"))),
   "part_desc"          VARCHAR2(200 CHAR)   not null,
   "localization_id"    NUMBER(22,0)         not null,
   constraint PK_LC_GEO_PARTS primary key ("geo_id", "localization_id")
         using index tablespace TS_REFERENCES_IDX_01,
   constraint FK_LC_GEO_P_REFERENCE_T_GEO_PA foreign key ("geo_id")
         references "t_geo_parts" ("geo_id")
)
tablespace TS_REFERENCES_DATA_01;

comment on table "lc_geo_parts" is
'Localization table: T_GEO_SYSTEMS';

comment on column "lc_geo_parts"."geo_id" is
'Unique ID for All Geography objects';

comment on column "lc_geo_parts"."part_id" is
'ID Code of Part of World';

comment on column "lc_geo_parts"."part_code" is
'Code of Part of World';

comment on column "lc_geo_parts"."part_desc" is
'Description of Part of World';

comment on column "lc_geo_parts"."localization_id" is
'Identificator of Supported References Languages';

