/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: LOCALIZATION                                          */
/*==============================================================*/
CREATE TABLE LOCALIZATION 
(
   LOCALIZATION_ID      NUMBER(10,0)         NOT NULL,
   LOCALIZATION_CODE    NUMBER(10,0),
   LOCALIZATION_DESC    VARCHAR2(40),
   CONSTRAINT PK_LOCALIZATION PRIMARY KEY (LOCALIZATION_ID)
);

create sequence SEQ_LOCALIZATION
start with 1
increment by 1;
