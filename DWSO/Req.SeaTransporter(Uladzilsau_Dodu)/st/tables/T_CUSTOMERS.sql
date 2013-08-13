/* Formatted on 8/4/2013 12:56:20 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/


/*==============================================================*/

/* Table: T_CUSTOMERS                                           */

/*==============================================================*/

CREATE TABLE t_customers
(
   customer_id    NUMBER ( 20, 0 ) NOT NULL
 , customer_code  NUMBER ( 20, 0 )
 , customer_fax   VARCHAR2 ( 20 )
 , customer_tel   VARCHAR2 ( 20 )
 , last_insert_dt DATE
 , last_update_dt DATE
 , CONSTRAINT pk_t_customers PRIMARY KEY ( customer_id )
);

CREATE SEQUENCE seq_t_customers
   START WITH 1
   INCREMENT BY 1;
