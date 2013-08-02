/* Formatted on 01.08.2013 19:27:00 (QP5 v5.139.911.3011) */
--DROP TABLE t_gen_periods CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_gen_periods
(
   period_id      NUMBER NOT NULL
 , period_code    VARCHAR2 ( 30 )
 , period_desc    VARCHAR2 ( 50 )
 , value_from_num NUMBER
 , value_to_num   NUMBER
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_t_gen_periods PRIMARY KEY ( period_id )
);