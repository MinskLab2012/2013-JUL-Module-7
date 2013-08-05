--alter table dw.lc_countries
--   drop constraint FK_LC_COUNTRIES;
--
--alter table dw.lc_countries
--   drop constraint FK_LOC2COUNTRIES;
--
--drop table dw.lc_countries cascade constraints;

--==============================================================
-- Table: lc_countries                                          
--==============================================================
create table dw.lc_countries 
(
   geo_id               NUMBER(22,0)         not null,
   country_id           NUMBER(22,0)         not null,
   country_code_a2      VARCHAR2(30 CHAR),
   country_code_a3      VARCHAR2(30 CHAR),
   country_desc         VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_COUNTRIES primary key (geo_id, localization_id)
)
;

comment on table dw.lc_countries is
'Localization table: T_COUNTRIES';

comment on column dw.lc_countries.geo_id is
'Unique ID for All Geography objects';

comment on column dw.lc_countries.country_id is
'ID Code of Country';

comment on column dw.lc_countries.country_code_a2 is
'Code of Countries - ALPHA 2';

comment on column dw.lc_countries.country_code_a3 is
'Code of Countries - ALPHA 3';

comment on column dw.lc_countries.country_desc is
'Description of Countries';

comment on column dw.lc_countries.localization_id is
'Identificator of Supported References Languages';

alter table dw.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A2 check (country_code_a2 is null or (country_code_a2 = upper(country_code_a2)));

alter table dw.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A3 check (country_code_a3 is null or (country_code_a3 = upper(country_code_a3)));

alter table dw.lc_countries
   add constraint FK_LC_COUNTRIES foreign key (geo_id)
      references dw.t_countries (geo_id)
      on delete cascade;

--alter table dw.lc_countries
 --  add constraint FK_LOC2COUNTRIES foreign key (localization_id)
  --    references dw.t_localizations (localization_id)
 --     on delete cascade;
