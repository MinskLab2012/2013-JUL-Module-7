/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 12:32:06 PM                         */
/*==============================================================*/


/*==============================================================*/
/* Table:  transactions                                         */
/*==============================================================*/
drop table transactions cascade constraints purge;
drop sequence transactions_seq;
create table  transactions  
(
    event_dt            DATE                 not null,
    transaction_id      NUMBER(10,0)         not null,
    prod_id             NUMBER(10,0),
    customer_id         NUMBER(7,0)          not null,
    country_geo_id      NUMBER(22,0),
    payment_system_id   NUMBER(5,0),
    delivery_system_id  NUMBER(5,0),
    amount_sold                NUMBER(10,0),
    status_id           NUMBER(3,0),
   constraint PK_TRANSACTIONS primary key ( event_dt ,  transaction_id )
/*
   constraint FK_TRANSACT_REFERENCE_CUSTOMER foreign key ( customer_id )
         references  customers  ( customer_id ),
            constraint FK_TRANSACT_REFERENCE_DELIVERY foreign key ( delivery_system_id ,  localization_id )
         references  delivery_systems  ( delivery_system_id ,  localization_id ),
   constraint FK_TRANSACT_REFERENCE_PAYMENT_ foreign key ( payment_system_id )
         references  payment_systems  ( payment_system_id ),
   constraint FK_TRANSACT_REFERENCE_T_GEO_OB foreign key ( country_geo_id )
         references  t_geo_objects  ( geo_id ),
         */

);

create sequence transactions_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 

 grant insert on transactions to u_dw_ext_references
/
grant update on transactions to u_dw_ext_references
/
grant select on transactions to u_dw_ext_references
/
grant select on transactions_seq to u_dw_ext_references
/

