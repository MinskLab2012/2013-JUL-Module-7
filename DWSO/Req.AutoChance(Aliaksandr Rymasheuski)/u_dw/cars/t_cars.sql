--ALTER TABLE cars
--   DROP CONSTRAINT fk_cars_reference_models;
--
--ALTER TABLE contracts
--   DROP CONSTRAINT fk_contract_reference_cars;

DROP TABLE cars CASCADE CONSTRAINTS;

/*==============================================================*/

/* Table: CARS                                                */

/*==============================================================*/

CREATE TABLE cars
(
   car_id         NUMBER ( 20 ) NOT NULL
 , car_code       NUMBER ( 20 )
 , car_stand_number NUMBER ( 20 )
 , year_of_production NUMBER ( 10 )
 , model_id       NUMBER ( 20 )
 , color          VARCHAR ( 20 )
 , date_of_purchase DATE
 , country        VARCHAR2 ( 60 )
 , cost           NUMBER ( 20 )
 , status         VARCHAR2 ( 10 )
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_cars PRIMARY KEY ( car_id )
);

ALTER TABLE cars
   ADD CONSTRAINT fk_cars_reference_models FOREIGN KEY (model_id)
      REFERENCES models (model_id);


GRANT DELETE,INSERT,UPDATE,SELECT ON cars TO u_dw_cleansing;


