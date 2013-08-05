/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "lc_countries"                                        */
/*==============================================================*/
create table "lc_countries" 
(
   "geo_id"             NUMBER(22,0)         not null,
   "country_id"         NUMBER(22,0)         not null,
   "country_code_a2"    VARCHAR2(30 CHAR)   
      constraint CHK_LC_COUNTRIES_CODE_A2 check ("country_code_a2" is null or ("country_code_a2" = upper("country_code_a2"))),
   "country_code_a3"    VARCHAR2(30 CHAR)   
      constraint CHK_LC_COUNTRIES_CODE_A3 check ("country_code_a3" is null or ("country_code_a3" = upper("country_code_a3"))),
   "country_desc"       VARCHAR2(200 CHAR)   not null,
   "localization_id"    NUMBER(22,0)         not null,
   constraint PK_LC_COUNTRIES primary key ("geo_id", "localization_id")
         using index tablespace TS_REFERENCES_IDX_01,
   constraint FK_LC_COUNT_REFERENCE_T_COUNTR foreign key ("geo_id")
         references "t_countries" ("geo_id")
)
tablespace TS_REFERENCES_DATA_01;

comment on table "lc_countries" is
'Localization table: T_COUNTRIES';

comment on column "lc_countries"."geo_id" is
'Unique ID for All Geography objects';

comment on column "lc_countries"."country_id" is
'ID Code of Country';

comment on column "lc_countries"."country_code_a2" is
'Code of Countries - ALPHA 2';

comment on column "lc_countries"."country_code_a3" is
'Code of Countries - ALPHA 3';

comment on column "lc_countries"."country_desc" is
'Description of Countries';

comment on column "lc_countries"."localization_id" is
'Identificator of Supported References Languages';

