drop table u_dw_stage.t_cities cascade constraints;

--==============================================================
-- Table: t_cities                                          
--==============================================================

create table u_dw_stage.t_cities 
(
   geo_id               NUMBER(22,0)         not null,
   city_id        NUMBER ( 22 ) NOT NULL
 , city_desc      VARCHAR2 ( 200 CHAR ) NOT NULL,
   constraint PK_T_CITIES primary key (geo_id)
         using index tablespace ts_dw_stage_idx_01
)
tablespace ts_dw_stage_data_01;

comment on table u_dw_stage.t_cities is
'Localization table: T_COUNTRIES';

comment on column u_dw_stage.t_cities.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.t_cities.city_id is
'ID Code of City';

comment on column u_dw_stage.t_cities.city_desc is
'Description of City';

