alter table u_stg.t_geo_objects
   drop constraint FK_T_GEO_TYPES2T_GEO_OBJECTS;

alter table u_stg.t_geo_systems
   drop constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS;

drop index u_stg.ui_geo_objects_codes;

drop table u_stg.t_geo_objects cascade constraints;

--==============================================================
-- Table: t_geo_objects                                         
--==============================================================
create table u_stg.t_geo_objects 
(
   geo_id               NUMBER(22,0)         not null,
   geo_type_id          NUMBER(22,0)         not null,
   geo_code_id          NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECTS primary key (geo_id)
         using index tablespace ts_stg_data_01
)
tablespace ts_stg_data_01;

comment on table u_stg.t_geo_objects is
'Abstarct Referense store all Geography objects';

comment on column u_stg.t_geo_objects.geo_id is
'Unique ID for All Geography objects';

comment on column u_stg.t_geo_objects.geo_type_id is
'Code of Geography Type Objects';

comment on column u_stg.t_geo_objects.geo_code_id is
'NK: Source ID from source systems';

--==============================================================
-- Index: ui_geo_objects_codes                                  
--==============================================================
create unique index u_stg.ui_geo_objects_codes on u_stg.t_geo_objects (
   geo_type_id ASC,
   geo_code_id ASC
)
tablespace ts_stg_data_01;

alter table u_stg.t_geo_objects
   add constraint FK_T_GEO_TYPES2T_GEO_OBJECTS foreign key (geo_type_id)
      references u_stg.t_geo_types (geo_type_id);
