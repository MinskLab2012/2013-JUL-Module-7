/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 12:32:06 PM                         */
/*==============================================================*/


/*==============================================================*/
/* Table:  prod_categories                                      */
/*==============================================================*/
drop table prod_categories cascade constraints purge
/
drop sequence prod_categories_seq
/

create sequence prod_categories_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /

create table  prod_categories  
(
    prod_category_id    NUMBER(5,0)          not null,
    prod_category  VARCHAR2(36),
    prod_category_desc  VARCHAR2(100),
    insert_dt           DATE,
    update_dt           DATE,
    localization_id     NUMBER(10,0)         not null,
   constraint PK_PROD_CATEGORIES primary key ( prod_category_id ,  localization_id )
)
/

grant insert on prod_categories to u_dw_ext_references
/
grant update on prod_categories to u_dw_ext_references
/
grant select on prod_categories to u_dw_ext_references
/
--grant delete on prod_categories to u_dw_ext_references
--/
grant select on prod_categories_seq to u_dw_ext_references
/

