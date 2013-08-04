/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     01.08.2013 14:04:05                          */
/*==============================================================*/


/*==============================================================*/
/* Table: "T_RESTAURANTS"                                       */
/*==============================================================*/
CREATE TABLE "U_DW_STAGE"."T_RESTAURANTS" 
(
   RESTAURANT_ID        NUMBER(10)           NOT NULL,
   RESTAURANT_CODE      NUMBER(10)           NOT NULL,
   RESTAURANT_NAME      VARCHAR2(150)        NOT NULL,
   RESTAURANT_DESC      VARCHAR2(2000)       NOT NULL,
   RESTAURANT_EMAIL     VARCHAR2(200),
   RESTAURANT_PHONE_NUMBER VARCHAR2(30),
   RESTAURANT_ADDRESS   VARCHAR2(400)        NOT NULL,
   RESTAURANT_NUMB_OF_SEATS NUMBER(4)            NOT NULL,
   RESTAURANT_NUMB_OF_DINING_ROOM NUMBER(4)            NOT NULL,
   RESTAURANT_TYPE_ID   NUMBER(3)            NOT NULL,
   RESTAURANT_GEO_ID    NUMBER(22,0),
   INSERT_DT            DATE                 NOT NULL,
   UPDATE_DT            DATE
)
/

COMMENT ON COLUMN "U_DW_STAGE"."T_RESTAURANTS".RESTAURANT_GEO_ID IS
'Unique ID for All Geography objects'
/

ALTER TABLE "U_DW_STAGE"."T_RESTAURANTS"
   ADD CONSTRAINT PK_T_RESTAURANTS PRIMARY KEY (RESTAURANT_ID)
/

