/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.08.2013 22:49:24                          */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_PRODUCTS                                          */
/*==============================================================*/
drop table DIM_PRODUCTS cascade constraints purge;
create table DIM_PRODUCTS 
(
   prod_id            NUMBER(7,0)          not null,
   prod_code          VARCHAR(36),
   prod_desc          VARCHAR(100),
   prod_subcategory_id NUMBER(5,0),
   prod_subcategory_code VARCHAR(36),
   prod_subcategory_desc VARCHAR(100),
   prod_category_id   NUMBER(5,0),
   prod_category_code VARCHAR(36),
   prod_category_desc VARCHAR(100),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_DIM_PRODUCTS primary key (prod_id)
);
 grant insert on DIM_PRODUCTS to st_data;
  grant select on DIM_PRODUCTS to st_data;
