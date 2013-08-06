/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     01.08.2013 14:04:05                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "T_PERIODS"                                           */
/*==============================================================*/
CREATE TABLE "U_DW_STAGE"."T_PERIODS" 
(
   PERIOD_ID            VARCHAR2(150)        NOT NULL,
   PERIOD_DESC          VARCHAR2(500)        NOT NULL,
   PERIOD_CODE          VARCHAR2(50)         NOT NULL,
   PERIOD_TYPE_ID       NUMBER(10)           NOT NULL,
   START_DT             DATE                 NOT NULL,
   END_DT               DATE                 NOT NULL,
   INSERT_DT            DATE                 NOT NULL,
   UPDATE_DT            DATE
)
/

ALTER TABLE "U_DW_STAGE"."T_PERIODS"
   ADD CONSTRAINT PK_T_PERIODS PRIMARY KEY (PERIOD_ID)
/

