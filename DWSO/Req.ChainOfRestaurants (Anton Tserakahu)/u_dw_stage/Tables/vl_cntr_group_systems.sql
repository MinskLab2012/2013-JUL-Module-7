drop view u_dw_stage.vl_cntr_group_systems;

--==============================================================
-- View: vl_cntr_group_systems                                  
--==============================================================
create or replace view u_dw_stage.vl_cntr_group_systems as
SELECT geo_id
     , grp_system_id
     , grp_system_code
     , grp_system_desc
  FROM lc_cntr_group_systems;

 comment on table u_dw_stage.vl_cntr_group_systems is
'Localazible View: T_CNTR_GROUP_SYSTEMS';

comment on column u_dw_stage.vl_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.vl_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

comment on column u_dw_stage.vl_cntr_group_systems.grp_system_code is
'Code of Grouping System Specifications';

comment on column u_dw_stage.vl_cntr_group_systems.grp_system_desc is
'Description of Grouping System Specifications';


