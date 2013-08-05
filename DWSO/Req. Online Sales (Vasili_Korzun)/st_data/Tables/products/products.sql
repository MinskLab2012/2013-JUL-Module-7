/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 12:32:06 PM                         */
/*==============================================================*/


/*==============================================================*/
/* Table:  products                                             */
/*==============================================================*/
alter table  products 
   drop constraint FK_PRODUCTS_REFERENCE_PROD_SUB
/
drop table products cascade constraints purge;

drop sequence products_seq
/


create table  products  
(
    prod_id             NUMBER(10,0)         not null,
    prod_code           VARCHAR2(60),
    prod_desc           VARCHAR2(100),
    prod_subcategory_id  NUMBER(5,0),
    insert_dt           DATE,
    update_dt           DATE,
    localization_id     NUMBER(10,0)         not null,
   constraint PK_PRODUCTS primary key ( prod_id ,  localization_id )
)
/



create sequence products_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
alter table  products 
   add constraint FK_PRODUCTS_REFERENCE_PROD_SUB foreign key ( prod_subcategory_id ,  localization_id )
      references  prod_subcategories  ( prod_subcategory_id ,  localization_id )
/

grant insert on products to u_dw_ext_references
/
grant update on products to u_dw_ext_references
/
grant select on products to u_dw_ext_references
/
grant select on products_seq to u_dw_ext_references
/

