--drop view dw.w_cntr_sub_groups;

--==============================================================
-- View: w_cntr_sub_groups                                      
--==============================================================
create or replace view dw.w_cntr_sub_groups as
SELECT geo_id
     , sub_group_id     
  FROM t_cntr_sub_groups;

 comment on table dw.w_cntr_sub_groups is
'Work View: T_CNTR_SUB_GROUPS';

comment on column dw.w_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column dw.w_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

grant DELETE,INSERT,UPDATE,SELECT on dw.w_cntr_sub_groups to dw_cl;
