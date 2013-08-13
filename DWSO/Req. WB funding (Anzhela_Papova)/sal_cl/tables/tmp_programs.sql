/* Formatted on 10.08.2013 14:11:11 (QP5 v5.139.911.3011) */
--DROP TABLE tmp_programs CASCADE CONSTRAINTS PURGE;

CREATE TABLE tmp_programs
(
   program_id     NUMBER NOT NULL
 , program_code   VARCHAR2 ( 10 BYTE )
 , program_desc   VARCHAR2 ( 100 BYTE )
 , manager_id     NUMBER NOT NULL
 , manager_desc   VARCHAR2 ( 100 BYTE )
 , start_date     DATE NOT NULL
);