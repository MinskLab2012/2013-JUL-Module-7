/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 12:32:06 PM                         */
/*==============================================================*/


/*==============================================================*/
/* Table:  delivery_systems                                     */
/*==============================================================*/

drop table delivery_systems cascade constraints purge;
drop sequence delivery_systems_seq;

create table  delivery_systems  
(
    delivery_system_id  NUMBER(5,0)          not null,
    delivery_system_code  VARCHAR2(36),
    delivery_system_desc  VARCHAR2(100),
    insert_dt           DATE,
    update_dt           DATE,
    localization_id     NUMBER(10,0)         not null,
   constraint PK_DELIVERY_SYSTEMS primary key ( delivery_system_id ,  localization_id )
)
/

create sequence delivery_systems_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
 
 grant insert on delivery_systems to u_dw_ext_references
/
grant update on delivery_systems to u_dw_ext_references
/
grant select on delivery_systems to u_dw_ext_references
/
grant select on delivery_systems_seq to u_dw_ext_references
/

