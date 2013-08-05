/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table:  payment_systems_types                                */
/*==============================================================*/

drop table payment_systems_types  cascade constraints purge;
drop sequence payment_systems_types_seq;
create table  payment_systems_types  
(
    payment_system_type_id  NUMBER(3,0)          not null,
    payment_system_type_desc  VARCHAR2(100)        not null,
    insert_dt           DATE,
    update_dt           DATE,
   constraint PK_PAYMENT_SYSTEMS_TYPES primary key ( payment_system_type_id )
)
organization index;

create sequence payment_systems_types_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
  grant insert on payment_systems_types to u_dw_ext_references
/
grant update on payment_systems_types to u_dw_ext_references
/
grant select on payment_systems_types to u_dw_ext_references
/
grant select on payment_systems_types_seq to u_dw_ext_references
/

