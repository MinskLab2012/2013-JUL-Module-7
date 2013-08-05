/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 12:32:06 PM                         */
/*==============================================================*/


/*==============================================================*/
/* Table:  prod_subcategories                                   */
/*==============================================================*/
alter table  prod_subcategories 
  drop constraint FK_PROD_SUB_REFERENCE_PROD_CAT
/
drop table prod_subcategories cascade constraints purge;


drop sequence prod_subcategories_seq
/

create table  prod_subcategories  
(
    prod_subcategory_id  NUMBER(5,0)          not null,
    prod_subcategory VARCHAR2(36),
    prod_subcategory_desc  VARCHAR2(100),
    prod_category_id    NUMBER(5,0),
    insert_dt           DATE,
    update_dt           DATE,
    localization_id     NUMBER(10,0)         not null,
   constraint PK_PROD_SUBCATEGORIES primary key ( prod_subcategory_id ,  localization_id )
)
/

create sequence prod_subcategories_seq
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /


alter table  prod_subcategories 
   add constraint FK_PROD_SUB_REFERENCE_PROD_CAT foreign key ( prod_category_id ,  localization_id )
      references  prod_categories  ( prod_category_id ,  localization_id )
/

grant insert on prod_subcategories to u_dw_ext_references
/
grant update on prod_subcategories to u_dw_ext_references
/
grant select on prod_subcategories to u_dw_ext_references
/
grant select on prod_subcategories_seq to u_dw_ext_references
/

