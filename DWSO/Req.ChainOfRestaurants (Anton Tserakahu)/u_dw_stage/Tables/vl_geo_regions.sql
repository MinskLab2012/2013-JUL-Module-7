drop view u_dw_stage.vl_geo_regions;

--==============================================================
-- View: vl_geo_regions                                         
--==============================================================
create or replace view u_dw_stage.vl_geo_regions as
SELECT geo_id
     , region_id
     , region_code
     , region_desc
  FROM lc_geo_regions;

 comment on table u_dw_stage.vl_geo_regions is
'Localazible View: T_CONTINENTS';

comment on column u_dw_stage.vl_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.vl_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

comment on column u_dw_stage.vl_geo_regions.region_code is
'Code of Continent Regions';

comment on column u_dw_stage.vl_geo_regions.region_desc is
'Description of Continent Regions';

