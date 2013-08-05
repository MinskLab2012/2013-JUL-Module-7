/* Formatted on 03.08.2013 23:13:49 (QP5 v5.139.911.3011) */
--ALTER TABLE t_program_manager
  -- DROP CONSTRAINT fk_t_pr1;

--DROP TABLE t_managers CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_managers
(
   manager_id     NUMBER NOT NULL
 , manager_desc   VARCHAR2 ( 100 )
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_t_managers PRIMARY KEY ( manager_id )
);