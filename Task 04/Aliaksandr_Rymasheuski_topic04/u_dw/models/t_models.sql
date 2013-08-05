/* Formatted on 8/1/2013 6:53:27 PM (QP5 v5.139.911.3011) */
ALTER TABLE cars
   DROP CONSTRAINT fk_cars_reference_models;

ALTER TABLE models
   DROP CONSTRAINT fk_models_reference_brands;

DROP TABLE models CASCADE CONSTRAINTS;

/*==============================================================*/

/* Table: MODELS                                            */

/*==============================================================*/

CREATE TABLE models
(
   model_id       NUMBER ( 20 ) NOT NULL
 , model_code     NUMBER ( 20 )
 , brand_id       NUMBER ( 20 )
 , model_desc     VARCHAR2 ( 50 CHAR ) NOT NULL
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_models PRIMARY KEY ( model_id )
);

ALTER TABLE models
   ADD CONSTRAINT fk_models_reference_brands FOREIGN KEY (brand_id)
      REFERENCES u_dw.brands (brand_id);

GRANT DELETE,INSERT,UPDATE,SELECT ON models TO u_dw_cleansing;


select * from MODELS; where update_dt is not null;

truncate table models;

(SELECT DISTINCT md.model_code
            , br.brand_desc
            , md.model_desc 
FROM u_dw.models md JOIN u_dw.brands br ON (md.brand_id=br.brand_id)
MINUS
SELECT DISTINCT model_id
            , brand
            , model
FROM u_sa_data.contracts)
UNION ALL
(SELECT DISTINCT model_id
            , brand
            , model
FROM u_sa_data.contracts
MINUS
SELECT DISTINCT md.model_code
            , br.brand_desc
            , md.model_desc 
FROM u_dw.models md JOIN u_dw.brands br ON (md.brand_id=br.brand_id));