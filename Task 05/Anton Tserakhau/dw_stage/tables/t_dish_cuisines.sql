/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     01.08.2013 14:04:05                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "T_DISH_CUISINES"                                     */
/*==============================================================*/
CREATE TABLE "U_DW_STAGE"."T_DISH_CUISINES" 
(
   DISH_CUISINE_ID      NUMBER(3)            NOT NULL,
   DISH_CUISINE_DESC    VARCHAR2(500)        NOT NULL,
   DISH_CUISINE_NAME    VARCHAR2(50)         NOT NULL,
   INSERT_DT            DATE                 NOT NULL,
   UPDATE_DT            DATE
)
/

ALTER TABLE "U_DW_STAGE"."T_DISH_CUISINES"
   ADD CONSTRAINT PK_T_DISH_CUISINES PRIMARY KEY (DISH_CUISINE_ID)
/

