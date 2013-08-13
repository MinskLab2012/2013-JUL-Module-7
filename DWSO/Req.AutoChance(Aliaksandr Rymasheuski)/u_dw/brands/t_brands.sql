/* Formatted on 8/6/2013 1:28:12 PM (QP5 v5.139.911.3011) */
--ALTER TABLE models
--   DROP CONSTRAINT fk_models_reference_brands;

DROP TABLE brands CASCADE CONSTRAINTS;

/*==============================================================*/

/* Table: brands                                             */

/*==============================================================*/

CREATE TABLE brands
(
   brand_id       NUMBER ( 20 ) NOT NULL
 , brand_code     NUMBER ( 20 )
 , brand_desc     VARCHAR2 ( 50 CHAR )
 , insert_dt      DATE
 , update_dt      DATE
 , CONSTRAINT pk_brands PRIMARY KEY ( brand_id )
);

GRANT DELETE,INSERT,UPDATE,SELECT ON brands TO u_dw_cleansing;



