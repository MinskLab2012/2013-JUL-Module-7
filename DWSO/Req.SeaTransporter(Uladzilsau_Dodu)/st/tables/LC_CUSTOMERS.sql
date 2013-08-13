/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: LC_CUSTOMERS                                          */
/*==============================================================*/
CREATE TABLE LC_CUSTOMERS 
(
   CUSTOMER_ID          NUMBER(20,0)         NOT NULL,
   COMPANY_NAME         VARCHAR2(40),
   CUSTOMER_COUNTRY     VARCHAR2(40),
   CUSTOMER_CITY        VARCHAR2(40),
   CUSTOMER_ADDRESS     VARCHAR2(40),
   CUSTOMER_EMAIL       VARCHAR2(40),
   CONTACT_PERSON       VARCHAR2(40),
   LOCALIZATION_ID      NUMBER(10,0)         NOT NULL,
   LAST_INSERT_DT       DATE,
   LAST_UPDATE_DT       DATE,
   CONSTRAINT PK_LC_CUSTOMERS PRIMARY KEY (CUSTOMER_ID, LOCALIZATION_ID),
   CONSTRAINT FK_LC_CUSTO_REFERENCE_T_CUSTOM FOREIGN KEY (CUSTOMER_ID)
         REFERENCES T_CUSTOMERS (CUSTOMER_ID),
   CONSTRAINT FK_LC_CUSTO_REFERENCE_LOCALIZA FOREIGN KEY (LOCALIZATION_ID)
         REFERENCES LOCALIZATION (LOCALIZATION_ID)
);

