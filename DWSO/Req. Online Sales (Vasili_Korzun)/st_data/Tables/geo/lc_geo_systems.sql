/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "lc_geo_systems"                                      */
/*==============================================================*/
create table "lc_geo_systems" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "geo_system_id"      NUMBER(22,0)         not null,
   "geo_system_code"    VARCHAR2(30 CHAR)   
      constraint CHK_LC_GEO_SYSTEMS_CODE check ("geo_system_code" is null or ("geo_system_code" = upper("geo_system_code"))),
   "geo_system_desc"    VARCHAR2(200 CHAR)   not null,
   "localization_id"    NUMBER(22,0)         not null,
   constraint PK_LC_GEO_SYSTEMS primary key ("geo_id", "localization_id")
         using index tablespace TS_REFERENCES_IDX_01,
   constraint FK_LC_GEO_S_REFERENCE_T_GEO_SY foreign key ("geo_id")
         references "t_geo_systems" ("geo_id")
)
tablespace TS_REFERENCES_DATA_01;

comment on table "lc_geo_systems" is
'Localization table: T_GEO_SYSTEMS';

comment on column "lc_geo_systems"."geo_id" is
'Unique ID for All Geography objects';

comment on column "lc_geo_systems"."geo_system_id" is
'ID Code of Geography System Specifications';

comment on column "lc_geo_systems"."geo_system_code" is
'Code of Geography System Specifications';

comment on column "lc_geo_systems"."geo_system_desc" is
'Description of Geography System Specifications';

comment on column "lc_geo_systems"."localization_id" is
'Identificator of Supported References Languages';

