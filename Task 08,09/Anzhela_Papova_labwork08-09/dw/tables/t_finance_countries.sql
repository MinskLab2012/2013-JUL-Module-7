/* Formatted on 07.08.2013 16:01:13 (QP5 v5.139.911.3011) */
--ALTER TABLE t_finance_countries
--   DROP CONSTRAINT fk_t_financ_r1_t_financ;
--
--ALTER TABLE t_finance_countries
--   DROP CONSTRAINT fk_t_financ_r2_t_financ;
--
--ALTER TABLE t_finance_countries
--   DROP CONSTRAINT fk_t_financ_r3_t_geo_ob;
--
--DROP TABLE t_finance_countries CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_finance_countries
(
   event_dt       DATE NOT NULL
 , country_geo_id NUMBER ( 22, 0 ) NOT NULL
 , fin_group_id   NUMBER NOT NULL
 , fin_item_id    NUMBER NOT NULL
 , bud_amount     NUMBER
 , insert_dt      DATE
 , update_dt      DATE
);

COMMENT ON COLUMN t_finance_countries.country_geo_id IS
'Unique ID for All Geography objects';

ALTER TABLE t_finance_countries
   ADD CONSTRAINT fk_t_financ_r1_t_financ FOREIGN KEY (fin_group_id)
      REFERENCES t_finance_groups (fin_group_id);

ALTER TABLE t_finance_countries
   ADD CONSTRAINT fk_t_financ_r2_t_financ FOREIGN KEY (fin_item_id)
      REFERENCES t_finance_items (fin_item_id);

ALTER TABLE t_finance_countries
   ADD CONSTRAINT fk_t_financ_r3_t_geo_ob FOREIGN KEY (country_geo_id)
      REFERENCES t_geo_objects (geo_id);