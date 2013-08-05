/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table:  payment_systems_actions                              */
/*==============================================================*/
drop table payment_systems_actions cascade constraints purge;
drop sequence payment_systems_actions_seq;

create table  payment_systems_actions  
(
    action_id           NUMBER(5,0)          not null,
    action_date         DATE,
    payment_system_id   NUMBER(5,0),
    action_type_id      NUMBER(4,0),
    value_old           VARCHAR2(100),
    value_new           VARCHAR2(100),
   constraint PK_PAYMENT_SYSTEMS_ACTIONS primary key ( action_id ),
   constraint FK_PS_ACTION_TYPES foreign key ( action_type_id )
         references  payment_systems_action_types  ( action_type_id ),
   constraint FK_PAYMENT__REFERENCE_PAYMENT_ foreign key ( payment_system_id )
         references  payment_systems  ( payment_system_id )
);


create sequence payment_systems_actions_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
   
 grant insert on payment_systems_actions to u_dw_ext_references
/
grant update on payment_systems_actions to u_dw_ext_references
/
grant select on payment_systems_actions to u_dw_ext_references
/
grant select on payment_systems_actions_seq to u_dw_ext_references
/

