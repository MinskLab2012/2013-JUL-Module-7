--alter table dw.lc_geo_systems
--   drop constraint FK_LC_GEO_SYSTEMS;
--
--alter table dw.lc_geo_systems
--   drop constraint FK_LOC2GEO_SYSTEMS;
--
--drop table dw.lc_geo_systems cascade constraints;

--==============================================================
-- Table: lc_geo_systems                                        
--==============================================================
create table dw.lc_geo_systems 
(
   geo_id               NUMBER(22,0)         not null,
   geo_system_id        NUMBER(22,0)         not null,
   geo_system_code      VARCHAR2(30 CHAR),
   geo_system_desc      VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_GEO_SYSTEMS primary key (geo_id, localization_id)
)
;

comment on table dw.lc_geo_systems is
'Localization table: T_GEO_SYSTEMS';

comment on column dw.lc_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column dw.lc_geo_systems.geo_system_id is
'ID Code of Geography System Specifications';

comment on column dw.lc_geo_systems.geo_system_code is
'Code of Geography System Specifications';

comment on column dw.lc_geo_systems.geo_system_desc is
'Description of Geography System Specifications';

comment on column dw.lc_geo_systems.localization_id is
'Identificator of Supported References Languages';

alter table dw.lc_geo_systems
   add constraint CHK_LC_GEO_SYSTEMS_CODE check (geo_system_code is null or (geo_system_code = upper(geo_system_code)));

alter table dw.lc_geo_systems
   add constraint FK_LC_GEO_SYSTEMS foreign key (geo_id)
      references dw.t_geo_systems (geo_id)
      on delete cascade;

--alter table dw.lc_geo_systems
  -- add constraint FK_LOC2GEO_SYSTEMS foreign key (localization_id)
   --   references u_dw_references.t_localizations (localization_id)
     -- on delete cascade;
