/* Formatted on 07.08.2013 12:57:03 (QP5 v5.139.911.3011) */
--ALTER TABLE t_gdp_countries
  -- DROP CONSTRAINT fk_t_gdp_co_r4_t_geo_ob;

--DROP TABLE t_gdp_countries CASCADE CONSTRAINTS PURGE;

CREATE TABLE t_gdp_countries
(
   event_dt       DATE NOT NULL
 , country_geo_id NUMBER ( 22, 0 ) NOT NULL
 , gdp            NUMBER 
 , insert_dt            date
 , update_dt            date
);

COMMENT ON COLUMN t_gdp_countries.country_geo_id IS
'Unique ID for All Geography objects';

ALTER TABLE t_gdp_countries
   ADD CONSTRAINT fk_t_gdp_co_r4_t_geo_ob FOREIGN KEY (country_geo_id)
      REFERENCES t_geo_objects (geo_id);