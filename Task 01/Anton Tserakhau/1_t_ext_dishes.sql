/* Formatted on 30.07.2013 16:06:09 (QP5 v5.139.911.3011) */
DROP TABLE u_dw_ext_references.t_ext_dishes CASCADE CONSTRAINTS;

create table u_dw_ext_references.t_ext_dishes 
(
   dish_code VARCHAR2(20 CHAR),
   dish_name   VARCHAR2(400 CHAR),
   dish_region  VARCHAR2(60 CHAR),
   dish_type    VARCHAR2(100 CHAR),
   dish_desc   VARCHAR2(2000 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (dish_code char(20), dish_name char(400), dish_region char(60), dish_type char(100), dish_desc char(2000) ) ) 
    location ('Spanish_dishes.tab')
)
reject limit unlimited;