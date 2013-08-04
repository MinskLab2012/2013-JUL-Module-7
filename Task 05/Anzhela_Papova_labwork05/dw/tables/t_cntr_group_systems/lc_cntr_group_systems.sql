--alter table dw.lc_cntr_group_systems
--   drop constraint FK_LC_CNTR_GROUP_SYSTEMS;
--
--alter table dw.lc_cntr_group_systems
--   drop constraint FK_LOC2CNTR_GROUP_SYSTEMS;
--
--drop table dw.lc_cntr_group_systems cascade constraints;

--==============================================================
-- Table: lc_cntr_group_systems                                 
--==============================================================
create table dw.lc_cntr_group_systems 
(
   geo_id               NUMBER(22,0)         not null,
   grp_system_id        NUMBER(22,0)         not null,
   grp_system_code      VARCHAR2(30 CHAR),
   grp_system_desc      VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_GROUP_SYSTEMS primary key (geo_id, localization_id)
        )
;

comment on table dw.lc_cntr_group_systems is
'Localization table: T_GEO_SYSTEMS';

comment on column dw.lc_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column dw.lc_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

comment on column dw.lc_cntr_group_systems.grp_system_code is
'Code of Grouping System Specifications';

comment on column dw.lc_cntr_group_systems.grp_system_desc is
'Description of Grouping System Specifications';

comment on column dw.lc_cntr_group_systems.localization_id is
'Identificator of Supported References Languages';

alter table dw.lc_cntr_group_systems
   add constraint CHK_LC_GRP_SYSTEMS_CODE check (grp_system_code is null or (grp_system_code = upper(grp_system_code)));

alter table dw.lc_cntr_group_systems
   add constraint FK_LC_CNTR_GROUP_SYSTEMS foreign key (geo_id)
      references dw.t_cntr_group_systems (geo_id)
      on delete cascade;

--alter table dw.lc_cntr_group_systems
   --add constraint FK_LOC2CNTR_GROUP_SYSTEMS foreign key (localization_id)
     -- references dw.t_localizations (localization_id)
    --  on delete cascade;
