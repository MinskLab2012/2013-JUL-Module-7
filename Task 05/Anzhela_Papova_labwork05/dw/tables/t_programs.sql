/* Formatted on 07.08.2013 17:08:21 (QP5 v5.139.911.3011) */
--ALTER TABLE t_program_manager
--   DROP CONSTRAINT fk_t_pr2;

--DROP TABLE t_programs CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_programs
(
   program_id     NUMBER NOT NULL
 , program_code   VARCHAR2 ( 10 )
 , program_desc   VARCHAR2 ( 100 )
 , program_purpose VARCHAR2 ( 200 )
 , valid_from     DATE
 , insert_dt      DATE
 , CONSTRAINT pk_t_programs PRIMARY KEY ( program_id, valid_from )
);