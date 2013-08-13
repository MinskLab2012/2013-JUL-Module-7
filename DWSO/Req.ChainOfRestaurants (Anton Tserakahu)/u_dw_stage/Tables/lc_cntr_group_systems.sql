--alter table u_dw_references.lc_cntr_group_systems
--   drop constraint FK_LC_CNTR_GROUP_SYSTEMS;
--
--alter table u_dw_references.lc_cntr_group_systems
--   drop constraint FK_LOC2CNTR_GROUP_SYSTEMS;
--
drop table u_dw_stage.lc_cntr_group_systems cascade constraints;

--==============================================================
-- Table: lc_cntr_group_systems                                 
--==============================================================
create table u_dw_stage.lc_cntr_group_systems 
(
   geo_id               NUMBER(22,0)         not null,
   grp_system_id        NUMBER(22,0)         not null,
   grp_system_code      VARCHAR2(30 CHAR),
   grp_system_desc      VARCHAR2(200 CHAR)   not null,
   constraint PK_LC_CNTR_GROUP_SYSTEMS primary key (geo_id)
         using index tablespace ts_dw_stage_idx_01
)
tablespace ts_dw_stage_data_01;

comment on table u_dw_stage.lc_cntr_group_systems is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_stage.lc_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.lc_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

comment on column u_dw_stage.lc_cntr_group_systems.grp_system_code is
'Code of Grouping System Specifications';

comment on column u_dw_stage.lc_cntr_group_systems.grp_system_desc is
'Description of Grouping System Specifications';


alter table u_dw_stage.lc_cntr_group_systems
   add constraint CHK_LC_GRP_SYSTEMS_CODE check (grp_system_code is null or (grp_system_code = upper(grp_system_code)));

alter table u_dw_stage.lc_cntr_group_systems
   add constraint FK_LC_CNTR_GROUP_SYSTEMS foreign key (geo_id)
      references u_dw_stage.t_cntr_group_systems (geo_id)
      on delete cascade;


