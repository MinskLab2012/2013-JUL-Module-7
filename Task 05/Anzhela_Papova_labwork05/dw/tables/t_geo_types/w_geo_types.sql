drop view dw.w_geo_types;

--==============================================================
-- View: w_geo_types                                            
--==============================================================
create or replace view dw.w_geo_types as
SELECT geo_type_id
     , geo_type_code
     , geo_type_desc
  FROM t_geo_types;

 comment on table dw.w_geo_types is
'Work View: T_GEO_TYPES';

comment on column dw.w_geo_types.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column dw.w_geo_types.geo_type_code is
'Code of Geography Type Objects';

comment on column dw.w_geo_types.geo_type_desc is
'Description of Geography Type Objects (Not Localizable)';

grant DELETE,INSERT,UPDATE,SELECT on dw.w_geo_types to u_dw_ext_references;
