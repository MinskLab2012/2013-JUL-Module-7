--drop view dw.w_cntr_groups;

--==============================================================
-- View: w_cntr_groups                                          
--==============================================================
create or replace view dw.w_cntr_groups as
SELECT geo_id
     , group_id     
  FROM t_cntr_groups;

 comment on table dw.w_cntr_groups is
'Work View: T_CNTR_GROUPS';

comment on column dw.w_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column dw.w_cntr_groups.group_id is
'ID Code of Countries Groups';

grant DELETE,INSERT,UPDATE,SELECT on dw.w_cntr_groups to dw_cl;
