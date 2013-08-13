
DROP TABLE u_dw_source.t_ext_cntr_grouping_iso3166 CASCADE CONSTRAINTS;


create table u_dw_source.t_ext_cntr_grouping_iso3166 
(
   child_code           NUMBER(10,0),
   parent_code          NUMBER(10,0),
   group_desc           VARCHAR2(200 CHAR),
   group_level          VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_data
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( child_code integer external (4), parent_code integer external, group_desc char(200), group_level char(200) ) )
    location ('iso_3166_groups_un.tab')
)
reject limit unlimited;