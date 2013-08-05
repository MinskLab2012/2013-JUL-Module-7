--drop view dw.w_cntr_group_systems;

--==============================================================
-- View: w_cntr_group_systems                                   
--==============================================================
create or replace view dw.w_cntr_group_systems as
SELECT geo_id
     , grp_system_id     
  FROM t_cntr_group_systems;

 comment on table dw.w_cntr_group_systems is
'Work View: T_GEO_TYPES';

comment on column dw.w_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column dw.w_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

grant DELETE,INSERT,UPDATE,SELECT on dw.w_cntr_group_systems to dw_cl;
