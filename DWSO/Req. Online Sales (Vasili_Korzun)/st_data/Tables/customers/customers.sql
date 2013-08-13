/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 12:32:06 PM                         */
/*==============================================================*/


/*==============================================================*/
/* Table:  customers                                            */
/*==============================================================*/

drop table customers cascade constraints purge;
drop sequence customers_seq;
create table  customers  
(
    customer_id         NUMBER(7,0)          not null,
    first_name          VARCHAR2(36),
    last_name           VARCHAR2(36),
    email varchar2(36),
    birth_date          DATE,
    insert_dt           DATE,
    update_dt           DATE,
   constraint PK_CUSTOMERS primary key ( customer_id )
)
/


create sequence customers_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
 
  
 
 grant insert on customers to u_dw_ext_references
/
grant update on customers to u_dw_ext_references
/
grant select on customers to u_dw_ext_references
/
grant select on customers_seq to u_dw_ext_references
/

