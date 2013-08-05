--alter table dw.t_geo_objects
--   drop constraint FK_T_GEO_TYPES2T_GEO_OBJECTS;
--
--alter table dw.t_geo_systems
--   drop constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS;
--
--drop index dw.ui_geo_objects_codes;
--
--drop table dw.t_geo_objects cascade constraints;

--==============================================================
-- Table: t_geo_objects                                         
--==============================================================
create table dw.t_geo_objects 
(
   geo_id               NUMBER(22,0)         not null,
   geo_type_id          NUMBER(22,0)         not null,
   geo_code_id          NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECTS primary key (geo_id)
)
;

comment on table dw.t_geo_objects is
'Abstarct Referense store all Geography objects';

comment on column dw.t_geo_objects.geo_id is
'Unique ID for All Geography objects';

comment on column dw.t_geo_objects.geo_type_id is
'Code of Geography Type Objects';

comment on column dw.t_geo_objects.geo_code_id is
'NK: Source ID from source systems';

--==============================================================
-- Index: ui_geo_objects_codes                                  
--==============================================================
create unique index dw.ui_geo_objects_codes on dw.t_geo_objects (
   geo_type_id ASC,
   geo_code_id ASC
)
;

alter table dw.t_geo_objects
   add constraint FK_T_GEO_TYPES2T_GEO_OBJECTS foreign key (geo_type_id)
      references dw.t_geo_types (geo_type_id);
