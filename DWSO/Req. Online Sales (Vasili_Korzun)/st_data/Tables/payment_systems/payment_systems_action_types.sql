/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table:  payment_systems_action_types                         */
/*==============================================================*/

drop table payment_systems_action_types cascade constraints purge;
create table  payment_systems_action_types  
(
    action_type_id      NUMBER(4,0)          not null,
    action_type_desc    VARCHAR2(36),
   constraint PK_PAYMENT_SYSTEMS_ACTION_TYPE primary key ( action_type_id )
);

insert into payment_systems_action_types values(1, 'PSDESC');
commit;

  grant insert on payment_systems_action_types to u_dw_ext_references
/
grant update on payment_systems_action_types to u_dw_ext_references
/
grant select on payment_systems_action_types to u_dw_ext_references
/

