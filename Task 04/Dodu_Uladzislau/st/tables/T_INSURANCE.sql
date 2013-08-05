/* Formatted on 8/4/2013 12:57:35 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/


/*==============================================================*/

/* Table: T_INSURANCE                                           */

/*==============================================================*/

CREATE TABLE t_insurance
(
   insurance_id   NUMBER ( 20, 0 ) NOT NULL
 , insurance_type_id NUMBER ( 20, 0 )
 , insurance_code NUMBER ( 20, 0 )
 , insurence_type_id NUMBER ( 20, 0 )
 , insurence_cost NUMBER ( 10, 2 )
 , last_insert_dt DATE
 , last_update_dt DATE
 , CONSTRAINT pk_t_insurance PRIMARY KEY ( insurance_id )
 , CONSTRAINT fk_t_insura_reference_t_insura FOREIGN KEY
      ( insurance_type_id )
       REFERENCES t_insurance_type ( insurance_type_id )
);

CREATE SEQUENCE seq_t_insurance
   START WITH 1
   INCREMENT BY 1;