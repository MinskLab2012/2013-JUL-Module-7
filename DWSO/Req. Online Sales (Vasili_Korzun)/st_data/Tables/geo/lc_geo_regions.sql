/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "lc_geo_regions"                                      */
/*==============================================================*/
create table "lc_geo_regions" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "region_id"          NUMBER(22,0)         not null,
   "region_code"        VARCHAR2(30 CHAR)   
      constraint CHK_LC_GEO_REGIONS_CODE check ("region_code" is null or ("region_code" = upper("region_code"))),
   "region_desc"        VARCHAR2(200 CHAR)   not null,
   "localization_id"    NUMBER(22,0)         not null,
   constraint PK_LC_GEO_REGIONS primary key ("geo_id", "localization_id")
         using index tablespace TS_REFERENCES_IDX_01,
   constraint FK_LC_GEO_R_REFERENCE_T_GEO_RE foreign key ("geo_id")
         references "t_geo_regions" ("geo_id")
)
tablespace TS_REFERENCES_DATA_01;

comment on table "lc_geo_regions" is
'Localization table: T_GEO_SYSTEMS';

comment on column "lc_geo_regions"."geo_id" is
'Unique ID for All Geography objects';

comment on column "lc_geo_regions"."region_id" is
'ID Code of Geographical Continent - Regions';

comment on column "lc_geo_regions"."region_code" is
'Code of Continent Regions';

comment on column "lc_geo_regions"."region_desc" is
'Description of Continent Regions';

comment on column "lc_geo_regions"."localization_id" is
'Identificator of Supported References Languages';

