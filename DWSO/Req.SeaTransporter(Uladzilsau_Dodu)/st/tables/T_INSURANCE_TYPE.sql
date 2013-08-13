/* Formatted on 8/4/2013 12:59:03 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/


/*==============================================================*/

/* Table: T_INSURANCE_TYPE                                      */

/*==============================================================*/

CREATE TABLE t_insurance_type
(
   insurance_type_id NUMBER ( 20, 0 ) NOT NULL
 , insurance_type VARCHAR ( 40 )
 , localization_id NUMBER ( 10, 0 ) NOT NULL
 , last_insert_dt DATE
 , last_update_dt DATE
 , CONSTRAINT pk_t_insurance_type PRIMARY KEY ( insurance_type_id )
 , CONSTRAINT fk_t_insura_reference_localiza FOREIGN KEY
      ( localization_id )
       REFERENCES localization ( localization_id )
);

CREATE SEQUENCE seq_t_insurance_type
   START WITH 1
   INCREMENT BY 1;