--alter table dw.t_geo_object_links
--   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_C;
--
--alter table dw.t_geo_object_links
--   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_P;
--
--drop table dw.t_geo_object_links cascade constraints;

--==============================================================
-- Table: t_geo_object_links                                    
--==============================================================
create table dw.t_geo_object_links 
(
   parent_geo_id        NUMBER(22,0)         not null,
   child_geo_id         NUMBER(22,0)         not null,
   link_type_id         NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECT_LINKS primary key (parent_geo_id, child_geo_id, link_type_id)
        )
 partition by list
 (link_type_id)
    (
        partition
             p_geo_sys2continents
            values (1)
             nocompress,
        partition
             p_continent2regions
            values (2)
             nocompress,
        partition
             p_region2countries
            values (3)
             nocompress,
        partition
             p_grp_sys2groups
            values (4)
             nocompress,
        partition
             p_group2sub_groups
            values (5)
             nocompress,
        partition
             p_sub_groups2countries
            values (6)
             nocompress
    );

comment on table dw.t_geo_object_links is
'Reference store: All links between Geo Objects';

comment on column dw.t_geo_object_links.parent_geo_id is
'Parent objects of Geo_IDs';

comment on column dw.t_geo_object_links.child_geo_id is
'Child objects of Geo_IDs';

comment on column dw.t_geo_object_links.link_type_id is
'Type of Links, between Geo_IDs';

alter table dw.t_geo_object_links
   add constraint FK_T_GEO_OBJECTS2GEO_LINK_C foreign key (child_geo_id)
      references dw.t_geo_objects (geo_id)
      on delete cascade;

alter table dw.t_geo_object_links
   add constraint FK_T_GEO_OBJECTS2GEO_LINK_P foreign key (parent_geo_id)
      references dw.t_geo_objects (geo_id)
      on delete cascade;
