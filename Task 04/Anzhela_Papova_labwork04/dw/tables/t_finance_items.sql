/* Formatted on 01.08.2013 15:11:55 (QP5 v5.139.911.3011) */
--drop table T_FINANCE_ITEMS cascade constraints PURGE;

CREATE TABLE t_finance_items
(
   fin_item_id    NUMBER NOT NULL
 , fin_item_code  NUMBER
 , fin_item_desc  VARCHAR2 ( 100 )
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_t_finance_items PRIMARY KEY ( fin_item_id )
);