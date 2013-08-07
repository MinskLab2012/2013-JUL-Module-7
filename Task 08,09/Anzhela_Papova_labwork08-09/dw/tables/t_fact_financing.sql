/* Formatted on 07.08.2013 15:01:29 (QP5 v5.139.911.3011) */
--ALTER TABLE t_fact_financing
--   DROP CONSTRAINT fk_t_fact_f_r6_t_geo_ob;
--
--ALTER TABLE t_fact_financing
--   DROP CONSTRAINT fk_t_fact_f_r8_t_fin_so;
--
--ALTER TABLE t_fact_financing
--   DROP CONSTRAINT fk_t_fact_f_r9_t_progra;
--
--DROP TABLE t_fact_financing CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_fact_financing
(
   event_dt       DATE NOT NULL
 , country_geo_id NUMBER NOT NULL
 , fin_source_id  NUMBER NOT NULL
 , program_id     NUMBER
 , fin_amount     NUMBER
 , loan_charge    NUMBER
 , end_date       DATE
 , insert_dt      DATE
 , update_dt      DATE
);

ALTER TABLE t_fact_financing
   ADD CONSTRAINT fk_t_fact_f_r6_t_geo_ob FOREIGN KEY (country_geo_id)
      REFERENCES t_geo_objects (geo_id);

ALTER TABLE t_fact_financing
   ADD CONSTRAINT fk_t_fact_f_r8_t_fin_so FOREIGN KEY (fin_source_id)
      REFERENCES t_fin_sources (fin_source_id);

ALTER TABLE t_fact_financing
   ADD CONSTRAINT fk_t_fact_f_r9_t_progra FOREIGN KEY (program_id)
      REFERENCES t_programs (program_id);