/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: LC_PORTS                                              */
/*==============================================================*/
CREATE TABLE LC_PORTS 
(
   PORT_ID              NUMBER(20,0)         NOT NULL,
   CONTACT_PERSON       VARCHAR2(40),
   PORT_COUTRY          VARCHAR2(40),
   PORT_CITY            VARCHAR2(40),
   PORT_ADDRESS         VARCHAR2(40),
   LOCALIZATION_ID      NUMBER(10,0)         NOT NULL,
   LAST_INSERT_DT       DATE,
   LAST_UPDATE_DT       DATE,
   CONSTRAINT PK_LC_PORTS PRIMARY KEY (PORT_ID, LOCALIZATION_ID),
   CONSTRAINT FK_LC_PORTS_REFERENCE_T_PORTS FOREIGN KEY (PORT_ID)
         REFERENCES T_PORTS (PORT_ID),
   CONSTRAINT FK_LC_PORTS_REFERENCE_LOCALIZA FOREIGN KEY (LOCALIZATION_ID)
         REFERENCES LOCALIZATION (LOCALIZATION_ID)
);

