/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: T_CATEGORIES                                          */
/*==============================================================*/
CREATE TABLE T_CATEGORIES 
(
   PROD_CATEGORY_ID     NUMBER(20,0)         NOT NULL,
   PROD_CATEGORY_CODE   NUMBER(20,0),
   LAST_INSERT_DT       DATE,
   LAST_UPDATE_DT       DATE,
   CONSTRAINT PK_T_CATEGORIES PRIMARY KEY (PROD_CATEGORY_ID)
);


create sequence seq_t_categories
start with 1
increment by 1;
