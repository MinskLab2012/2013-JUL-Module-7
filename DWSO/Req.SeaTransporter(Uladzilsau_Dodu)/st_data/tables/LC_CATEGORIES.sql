/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: LC_CATEGORIES                                         */
/*==============================================================*/
CREATE TABLE LC_CATEGORIES 
(
   PROD_CATEGORY_ID     NUMBER(20,0)         NOT NULL,
   PROD_CATEGORY_NAME   VARCHAR2(40),
   PROD_CATEGORY_DESC   VARCHAR2(100),
   LOCALIZATION_ID      NUMBER(10,0)         NOT NULL,
   LAST_INSERT_DT       DATE,
   LAST_UPDATE_DT       DATE,
   CONSTRAINT PK_LC_CATEGORIES PRIMARY KEY (PROD_CATEGORY_ID, LOCALIZATION_ID),
   CONSTRAINT FK_LC_CATEG_REFERENCE_T_CATEGO FOREIGN KEY (PROD_CATEGORY_ID)
         REFERENCES T_CATEGORIES (PROD_CATEGORY_ID),
   CONSTRAINT FK_LC_CATEG_REFERENCE_LOCALIZA FOREIGN KEY (LOCALIZATION_ID)
         REFERENCES LOCALIZATION (LOCALIZATION_ID)
);

