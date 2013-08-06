/* Formatted on 8/4/2013 1:01:02 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/


/*==============================================================*/

/* Table: T_PORTS                                               */

/*==============================================================*/

CREATE TABLE t_ports
(
   port_id        NUMBER ( 20, 0 ) NOT NULL
 , port_code      NUMBER ( 20, 0 )
 , pier_code      NUMBER ( 20, 0 )
 , contact_tel    VARCHAR2 ( 40 )
 , last_insert_dt DATE
 , last_update_dt DATE
 , CONSTRAINT pk_t_ports PRIMARY KEY ( port_id )
);

CREATE SEQUENCE seq_t_ports
   START WITH 1
   INCREMENT BY 1;