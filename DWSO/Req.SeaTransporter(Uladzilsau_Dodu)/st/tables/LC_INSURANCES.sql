/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: LC_INSURANCES                                         */
/*==============================================================*/
CREATE TABLE LC_INSURANCES 
(
   INSURANCE_ID         NUMBER(20,0)         NOT NULL,
   COMPANY_NAME         VARCHAR2(40),
   LOCALIZATION_ID      NUMBER(10,0)         NOT NULL,
   LAST_INSERT_DT       DATE,
   LAST_UPDATE_DT       DATE,
   CONSTRAINT PK_LC_INSURANCES PRIMARY KEY (INSURANCE_ID, LOCALIZATION_ID),
   CONSTRAINT FK_LC_INSUR_REFERENCE_T_INSURA FOREIGN KEY (INSURANCE_ID)
         REFERENCES T_INSURANCE (INSURANCE_ID),
   CONSTRAINT FK_LC_INSUR_REFERENCE_LOCALIZA FOREIGN KEY (LOCALIZATION_ID)
         REFERENCES LOCALIZATION (LOCALIZATION_ID)
);

