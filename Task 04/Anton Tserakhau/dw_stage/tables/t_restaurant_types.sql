/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     01.08.2013 14:04:05                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "T_RESTAURANT_TYPES"                                  */
/*==============================================================*/
CREATE TABLE "U_DW_STAGE"."T_RESTAURANT_TYPES" 
(
   RESTAURANT_TYPE_ID   NUMBER(3)            NOT NULL,
   RESTAURANT_TYPE_DESC VARCHAR2(200)        NOT NULL,
   RESTAURANT_TYPE_NAME VARCHAR2(50)         NOT NULL,
   INSERT_DT            DATE                 NOT NULL,
   UPDATE_DT            DATE
)
/

ALTER TABLE "U_DW_STAGE"."T_RESTAURANT_TYPES"
   ADD CONSTRAINT PK_T_RESTAURANT_TYPES PRIMARY KEY (RESTAURANT_TYPE_ID)
/

