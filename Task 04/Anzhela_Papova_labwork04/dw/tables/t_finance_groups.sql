/* Formatted on 01.08.2013 14:36:33 (QP5 v5.139.911.3011) */
--DROP TABLE T_FINANCE_GROUPS CASCADE CONSTRAINT PURGE;

CREATE TABLE t_finance_groups
(
   fin_group_id   NUMBER NOT NULL
 , fin_group_desc VARCHAR2 ( 20 )
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_t_finance_groups PRIMARY KEY ( fin_group_id )
);