/* Formatted on 8/4/2013 1:02:35 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/


/*==============================================================*/

/* Table: T_SHIPS                                               */

/*==============================================================*/

CREATE TABLE t_ships
(
   ship_id        NUMBER ( 20, 0 ) NOT NULL
 , ship_code      NUMBER ( 20, 0 )
 , weight         NUMBER ( 10, 2 )
 , height         NUMBER ( 10, 2 )
 , water_volume   NUMBER ( 10, 2 )
 , max_cargo      NUMBER ( 10, 2 )
 , last_insert_dt DATE
 , last_update_dt DATE
 , CONSTRAINT pk_t_ships PRIMARY KEY ( ship_id )
);

CREATE SEQUENCE seq_t_ships
   START WITH 1
   INCREMENT BY 1;