/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: ACTION_TYPES                                          */
/*==============================================================*/
CREATE TABLE ACTION_TYPES 
(
   ACTION_TYPE_ID       NUMBER(10,0)         NOT NULL,
   ACTION_TYPE_DESC     VARCHAR2(40),
   CONSTRAINT PK_ACTION_TYPES PRIMARY KEY (ACTION_TYPE_ID)
);

create sequence seq_action_type
start with 1
increment by 1;

