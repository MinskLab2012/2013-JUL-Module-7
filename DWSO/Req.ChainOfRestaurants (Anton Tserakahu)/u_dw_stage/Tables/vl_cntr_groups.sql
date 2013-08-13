drop view u_dw_stage.vl_cntr_groups;

--==============================================================
-- View: vl_cntr_groups                                         
--==============================================================
create or replace view u_dw_stage.vl_cntr_groups as
SELECT geo_id
     , GROUP_ID
     , group_code
     , group_desc
  FROM lc_cntr_groups;

 comment on table u_dw_stage.vl_cntr_groups is
'Localazible View: T_CNTR_GROUPS';

comment on column u_dw_stage.vl_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.vl_cntr_groups.GROUP_ID is
'ID Code of Countries Groups';

comment on column u_dw_stage.vl_cntr_groups.group_code is
'Code of Countries Groups';

comment on column u_dw_stage.vl_cntr_groups.group_desc is
'Description of Countries Groups';


