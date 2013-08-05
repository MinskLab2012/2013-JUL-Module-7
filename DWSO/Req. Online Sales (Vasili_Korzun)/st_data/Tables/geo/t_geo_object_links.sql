/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "t_geo_object_links"                                  */
/*==============================================================*/
create table "t_geo_object_links" 
(
   "parent_geo_id"      NUMBER(22,0)         not null,
   "child_geo_id"       NUMBER(22,0)         not null,
   "link_type_id"       NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECT_LINKS primary key ("parent_geo_id", "child_geo_id", "link_type_id")
         using index
       local
       tablespace TS_REFERENCES_IDX_01,
   constraint FK_GEO_LINK_CHILD foreign key ("child_geo_id")
         references "t_geo_objects" ("geo_id"),
   constraint FK_GEO_LINK_PARENT foreign key ("parent_geo_id")
         references "t_geo_objects" ("geo_id")
)
tablespace TS_REFERENCES_DATA_01
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

comment on table "t_geo_object_links" is
'Reference store: All links between Geo Objects';

comment on column "t_geo_object_links"."parent_geo_id" is
'Parent objects of Geo_IDs';

comment on column "t_geo_object_links"."child_geo_id" is
'Child objects of Geo_IDs';

comment on column "t_geo_object_links"."link_type_id" is
'Type of Links, between Geo_IDs';

