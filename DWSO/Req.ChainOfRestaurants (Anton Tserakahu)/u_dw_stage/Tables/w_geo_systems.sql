drop view u_dw_stage.w_geo_systems;

--==============================================================
-- View: w_geo_systems                                          
--==============================================================
create or replace view u_dw_stage.w_geo_systems as
SELECT geo_id
     , geo_system_id
  FROM t_geo_systems;

 comment on table u_dw_stage.w_geo_systems is
'Work View: T_GEO_SYSTEMS';

comment on column u_dw_stage.w_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.w_geo_systems.geo_system_id is
'ID Code of Geography System Specifications';

