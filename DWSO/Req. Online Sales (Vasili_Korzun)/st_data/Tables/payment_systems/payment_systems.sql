/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table:  payment_systems                                      */
/*==============================================================*/

drop table payment_systems cascade constraints purge;
drop sequence payment_systems_seq;

create table  payment_systems  
(
    payment_system_id   NUMBER(5,0)          not null,
    payment_system_code  VARCHAR2(100)         not null,
    payment_system_desc  VARCHAR2(100)        not null,
    payment_system_type_id  NUMBER(3,0)          not null,
    insert_dt           DATE,
    update_dt           DATE,
   constraint PK_PAYMENT_SYSTEMS primary key ( payment_system_id ),
   constraint FK_PS_TYPE foreign key ( payment_system_type_id )
         references  payment_systems_types  ( payment_system_type_id )
);

create sequence payment_systems_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
  
 grant insert on payment_systems to u_dw_ext_references
/
grant update on payment_systems to u_dw_ext_references
/
grant select on payment_systems to u_dw_ext_references
/
grant select on payment_systems_seq to u_dw_ext_references
/

