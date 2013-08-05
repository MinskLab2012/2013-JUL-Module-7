--drop view dw.w_geo_objects;

--==============================================================
-- View: w_geo_objects                                          
--==============================================================
create or replace view dw.w_geo_objects as
SELECT geo_id
     , geo_type_id
     , geo_code_id
  FROM t_geo_objects;

 comment on table dw.w_geo_objects is
'Work View: T_GEO_TYPES';

comment on column dw.w_geo_objects.geo_id is
'Unique ID for All Geography objects';

comment on column dw.w_geo_objects.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column dw.w_geo_objects.geo_code_id is
'NK: Source ID from source systems';

grant DELETE,INSERT,UPDATE,SELECT on dw.w_geo_objects to dw_cl;
