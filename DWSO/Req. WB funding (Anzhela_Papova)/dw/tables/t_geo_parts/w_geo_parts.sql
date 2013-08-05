--drop view dw.w_geo_parts;

--==============================================================
-- View: w_geo_parts                                            
--==============================================================
create or replace view dw.w_geo_parts as
select
   geo_id,
   part_id
from
   t_geo_parts;

 comment on table dw.w_geo_parts is
'Work View: T_GEO_PARTS';

comment on column dw.w_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column dw.w_geo_parts.part_id is
'ID Code of Geographical Part of World';

grant DELETE,INSERT,UPDATE,SELECT on dw.w_geo_parts to dw_cl;
