/* Formatted on 01.08.2013 13:50:52 (QP5 v5.139.911.3011) */
--DROP TABLE t_fin_sources  CASCADE CONSTRAINT PURGE;

CREATE TABLE t_fin_sources
(
   fin_source_id  NUMBER NOT NULL
 , fin_source_code NUMBER
 , fin_source_desc VARCHAR2 ( 100 )
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_t_fin_sources PRIMARY KEY ( fin_source_id )
);