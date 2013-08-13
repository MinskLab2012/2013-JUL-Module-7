/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 2:30:12 PM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: PROD_ACTIONS                                          */
/*==============================================================*/
CREATE TABLE PROD_ACTIONS 
(
   ACTION_ID            NUMBER(20,0)         NOT NULL,
   ACTION_DATE          DATE,
   ACTION_TYPE_ID       NUMBER(10,0),
   PROD_ID              NUMBER(20,0),
   OLD_VALUE            NUMBER(5,3),
   NEW_VALUE            NUMBER(5,3),
   CONSTRAINT PK_PROD_ACTIONS PRIMARY KEY (ACTION_ID),
   CONSTRAINT FK_PROD_ACT_REFERENCE_T_PRODUC FOREIGN KEY (PROD_ID)
         REFERENCES T_PRODUCTS (PROD_ID),
   CONSTRAINT FK_PROD_ACT_REFERENCE_ACTION_T FOREIGN KEY (ACTION_TYPE_ID)
         REFERENCES ACTION_TYPES (ACTION_TYPE_ID)
);

create sequence seq_prod_actions
start with 1
increment by 1;
