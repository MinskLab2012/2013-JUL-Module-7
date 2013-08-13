/* Formatted on 8/4/2013 1:03:20 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/


/*==============================================================*/

/* Table: T_TRANS                                               */

/*==============================================================*/

CREATE TABLE t_trans
(
   transaction_id NUMBER ( 20 ) NOT NULL
 , tran_id        DATE
 , ship_id        NUMBER ( 20, 0 )
 , insurance_id   NUMBER ( 20, 0 )
 , prod_id        NUMBER ( 20, 0 )
 , customer_id    NUMBER ( 20, 0 )
 , ar_port_id     NUMBER ( 20, 0 )
 , ar_time        DATE
 , dep_port_id    NUMBER ( 20, 0 )
 , dep_time       DATE
 , dep_goods      NUMBER ( 20, 2 )
 , ar_goods       NUMBER ( 20, 2 )
 , last_insert_dt CHAR ( 10 )
 , last_update_dt CHAR ( 10 )
 , CONSTRAINT pk_t_trans PRIMARY KEY ( transaction_id )
 , CONSTRAINT fk_t_trans_reference_t_produc FOREIGN KEY ( prod_id ) REFERENCES t_products ( prod_id )
 , CONSTRAINT fk_t_trans_reference_t_ships FOREIGN KEY ( ship_id ) REFERENCES t_ships ( ship_id )
 , CONSTRAINT fk_t_trans_reference_ar_ports FOREIGN KEY ( ar_port_id ) REFERENCES t_ports ( port_id )
 , CONSTRAINT fk_t_trans_reference_dep_ports FOREIGN KEY ( dep_port_id ) REFERENCES t_ports ( port_id )
 , CONSTRAINT fk_t_trans_reference_t_insura FOREIGN KEY ( insurance_id ) REFERENCES t_insurance ( insurance_id )
 , CONSTRAINT fk_t_trans_reference_t_custom FOREIGN KEY ( customer_id ) REFERENCES t_customers ( customer_id )
);

CREATE SEQUENCE seq_t_trans
   START WITH 1
   INCREMENT BY 1;