--drop view dw.w_geo_regions;

--==============================================================
-- View: w_geo_regions                                          
--==============================================================
create or replace view dw.w_geo_regions as
select
   geo_id,
   region_id
from
   t_geo_regions;

 comment on table dw.w_geo_regions is
'Work View: T_CONTINENTS';

comment on column dw.w_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column dw.w_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

grant DELETE,INSERT,UPDATE,SELECT on dw.w_geo_regions to dw_cl;
