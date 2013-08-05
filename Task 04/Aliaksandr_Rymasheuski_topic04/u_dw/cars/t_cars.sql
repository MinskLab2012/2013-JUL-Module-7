ALTER TABLE cars
   DROP CONSTRAINT fk_cars_reference_models;

ALTER TABLE contracts
   DROP CONSTRAINT fk_contract_reference_cars;

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





(SELECT DISTINCT cr.car_code
            , cr.car_stand_number
            , cr.year_of_production
            , md.model_desc
            , cr.color
            , cr.date_of_purchase
            , cr.country
            , cr.cost
            , cr.status 
FROM u_dw.cars cr JOIN u_dw.models md ON (cr.model_id=md.model_id)
MINUS
SELECT DISTINCT car_id
            , cat_stand_num
            , year_of_production
            , model
            , color
            , date_of_purchase
            , country
            , cost
            , status
FROM u_sa_data.contracts)
UNION ALL
(SELECT DISTINCT car_id
            , cat_stand_num
            , year_of_production
            , model
            , color
            , date_of_purchase
            , country
            , cost
            , status
FROM u_sa_data.contracts
MINUS
SELECT DISTINCT cr.car_code
            , cr.car_stand_number
            , cr.year_of_production
            , md.model_desc
            , cr.color
            , cr.date_of_purchase
            , cr.country
            , cr.cost
            , cr.status 
FROM u_dw.cars cr JOIN u_dw.models md ON (cr.model_id=md.model_id));


truncate table cars;
select * from cars;
 where update_dt is not null;