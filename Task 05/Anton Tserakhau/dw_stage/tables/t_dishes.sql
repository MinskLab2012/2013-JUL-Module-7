/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     01.08.2013 14:04:05                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "T_DISHES"                                            */
/*==============================================================*/
CREATE TABLE "U_DW_STAGE"."T_DISHES" 
(
   DISH_ID              NUMBER(15)           NOT NULL,
   DISH_CODE            VARCHAR2(15)           NOT NULL,
   DISH_NAME            VARCHAR2(400)        NOT NULL,
   DISH_DESC            VARCHAR2(2000)       NOT NULL,
   DISH_WEIGHT          NUMBER(10,5)         NOT NULL,
   DISH_TYPE_ID         NUMBER(3)            NOT NULL,
   DISH_CUISINE_ID      NUMBER(3)            NOT NULL,
   START_UNIT_PRICE_DOL NUMBER(10,5)
)
/

ALTER TABLE "U_DW_STAGE"."T_DISHES"
   ADD CONSTRAINT PK_T_DISHES PRIMARY KEY (DISH_ID)
/

