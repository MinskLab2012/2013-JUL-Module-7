--alter table u_dw_references.lc_countries
--   drop constraint FK_LC_COUNTRIES;
--
--alter table u_dw_references.lc_countries
--   drop constraint FK_LOC2COUNTRIES;
--
drop table u_dw_stage.lc_countries cascade constraints;

--==============================================================
-- Table: lc_countries                                          
--==============================================================
create table u_dw_stage.lc_countries 
(
   geo_id               NUMBER(22,0)         not null,
   country_id           NUMBER(22,0)         not null,
   country_code_a2      VARCHAR2(30 CHAR),
   country_code_a3      VARCHAR2(30 CHAR),
   country_desc         VARCHAR2(200 CHAR)   not null,
   constraint PK_LC_COUNTRIES primary key (geo_id)
         using index tablespace ts_dw_stage_idx_01
)
tablespace ts_dw_stage_data_01;

comment on table u_dw_stage.lc_countries is
'Localization table: T_COUNTRIES';

comment on column u_dw_stage.lc_countries.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.lc_countries.country_id is
'ID Code of Country';

comment on column u_dw_stage.lc_countries.country_code_a2 is
'Code of Countries - ALPHA 2';

comment on column u_dw_stage.lc_countries.country_code_a3 is
'Code of Countries - ALPHA 3';

comment on column u_dw_stage.lc_countries.country_desc is
'Description of Countries';

alter table u_dw_stage.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A2 check (country_code_a2 is null or (country_code_a2 = upper(country_code_a2)));

alter table u_dw_stage.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A3 check (country_code_a3 is null or (country_code_a3 = upper(country_code_a3)));

alter table u_dw_stage.lc_countries
   add constraint FK_LC_COUNTRIES foreign key (geo_id)
      references u_dw_stage.t_countries (geo_id)
      on delete cascade;

