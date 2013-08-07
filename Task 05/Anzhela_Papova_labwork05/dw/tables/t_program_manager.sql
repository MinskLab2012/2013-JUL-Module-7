/* Formatted on 03.08.2013 23:17:18 (QP5 v5.139.911.3011) */
--ALTER TABLE t_program_manager
 --  DROP CONSTRAINT fk_t_pr1;

--ALTER TABLE t_program_manager
--   DROP CONSTRAINT fk_t_pr2;

--DROP TABLE t_program_manager CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_program_manager
(
   program_id     NUMBER NOT NULL
 , manager_id     NUMBER NOT NULL
 , start_date     DATE NOT NULL
 , insert_dt      DATE
 , CONSTRAINT pk_t_pr PRIMARY KEY ( program_id, manager_id, start_date )
);

ALTER TABLE t_program_manager
   ADD CONSTRAINT fk_t_pr1 FOREIGN KEY (manager_id)
      REFERENCES t_managers (manager_id);

ALTER TABLE t_program_manager
   ADD CONSTRAINT fk_t_pr2 FOREIGN KEY (program_id)
      REFERENCES t_programs (program_id);