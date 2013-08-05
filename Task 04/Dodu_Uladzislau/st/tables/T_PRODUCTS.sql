/* Formatted on 8/4/2013 1:02:06 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/


/*==============================================================*/

/* Table: T_PRODUCTS                                            */

/*==============================================================*/

CREATE TABLE t_products
(
   prod_id        NUMBER ( 20, 0 ) NOT NULL
 , prod_code      NUMBER ( 20, 0 )
 , income_coef    NUMBER ( 5, 3 )
 , prod_category_id NUMBER ( 20, 0 )
 , last_insert_dt DATE
 , last_update_dt DATE
 , CONSTRAINT pk_t_products PRIMARY KEY ( prod_id )
 , CONSTRAINT fk_t_produc_reference_t_catego FOREIGN KEY
      ( prod_category_id )
       REFERENCES t_categories ( prod_category_id )
);

CREATE SEQUENCE seq_t_products
   START WITH 1
   INCREMENT BY 1;