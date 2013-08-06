/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: LC_PRODUCTS                                           */
/*==============================================================*/
CREATE TABLE LC_PRODUCTS 
(
   PROD_ID              NUMBER(20,0)         NOT NULL,
   PROD_NAME            VARCHAR2(40),
   PROD_DESC            VARCHAR2(100),
   LOCALIZATION_ID      NUMBER(10,0)         NOT NULL,
   LAST_INSERT_DT       DATE,
   LAST_UPDATE_DT       DATE,
   CONSTRAINT PK_LC_PRODUCTS PRIMARY KEY (PROD_ID, LOCALIZATION_ID),
   CONSTRAINT FK_LC_PRODU_REFERENCE_T_PRODUC FOREIGN KEY (PROD_ID)
         REFERENCES T_PRODUCTS (PROD_ID),
   CONSTRAINT FK_LC_PRODU_REFERENCE_LOCALIZA FOREIGN KEY (LOCALIZATION_ID)
         REFERENCES LOCALIZATION (LOCALIZATION_ID)
);

