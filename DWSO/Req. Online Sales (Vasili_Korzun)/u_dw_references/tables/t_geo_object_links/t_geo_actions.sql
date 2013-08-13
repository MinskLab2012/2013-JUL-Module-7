drop table t_geo_actions purge;
drop sequence t_geo_actions_seq;

create table t_geo_actions
(
    action_id           NUMBER(5,0)          not null,
    action_dt         DATE,
    geo_id   NUMBER(22),
    action_type_id      NUMBER(4,0),
    int_value_old           NUMBER(22),
    int_value_new           NUMBER(22),
    constraint PK_T_GEO_ACTIONS primary key (action_id)
);
alter table t_geo_actions add constraint FK_ID_GEO_OBJ foreign key (geo_id) references t_geo_objects(geo_id);


create sequence t_geo_actions_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
 grant select on t_geo_actions_seq to u_dw_ext_references;
 
  grant insert on t_geo_actions to u_dw_ext_references;

       
create or replace view u_dw_references.w_geo_object_links as
SELECT parent_geo_id
     , child_geo_id
     , link_type_id
  FROM t_geo_object_links;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_object_links to u_dw_ext_references;