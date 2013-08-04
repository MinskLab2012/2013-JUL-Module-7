/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     01.08.2013 14:04:05                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "T_TYPE_PERIODS"                                      */
/*==============================================================*/
CREATE TABLE "U_DW_STAGE"."T_TYPE_PERIODS" 
(
   PERIOD_TYPE_ID       NUMBER(10)           NOT NULL,
   PERIOD_TYPE_DESC     VARCHAR2(50)         NOT NULL,
   PERIOD_TYPE_NAME     VARCHAR2(150)        NOT NULL,
   INSERT_DT            DATE                 NOT NULL,
   UPDATE_DT            DATE
)
/

ALTER TABLE "U_DW_STAGE"."T_TYPE_PERIODS"
   ADD CONSTRAINT PK_T_TYPE_PERIODS PRIMARY KEY (PERIOD_TYPE_ID)
/

