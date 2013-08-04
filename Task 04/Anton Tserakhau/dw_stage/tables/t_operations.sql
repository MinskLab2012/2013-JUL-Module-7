/* Formatted on 04.08.2013 14:02:43 (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     01.08.2013 14:04:05                          */

/*==============================================================*/

/*==============================================================*/

/* Table: "T_OPERATIONS"                                        */

/*==============================================================*/

CREATE TABLE "U_DW_STAGE"."T_OPERATIONS"
(
   operation_id   NUMBER ( 10 ) NOT NULL
 , transaction_id NUMBER ( 10 ) NOT NULL
 , event_dt       DATE NOT NULL
 , restaurant_id  NUMBER ( 10 )
 , dish_id        NUMBER ( 15 )
 , unit_price_dol NUMBER ( 20, 5 ) NOT NULL
 , unit_amount    NUMBER ( 20, 5 ) NOT NULL
 , total_price_dol NUMBER ( 20, 5 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
/

ALTER TABLE "U_DW_STAGE"."T_OPERATIONS"
   ADD CONSTRAINT pk_t_operations PRIMARY KEY (operation_id)
/