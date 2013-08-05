/* Formatted on 8/1/2013 6:53:32 PM (QP5 v5.139.911.3011) */
ALTER TABLE models
   DROP CONSTRAINT fk_models_reference_brands;

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


truncate table brands;
select * from brands;





(SELECT brand_code
            , brand_desc 
FROM u_dw.brands
MINUS
SELECT DISTINCT 
            brand_id
            , brand
FROM u_sa_data.contracts)
UNION ALL
(SELECT DISTINCT 
            brand_id
            , brand
FROM u_sa_data.contracts
MINUS
SELECT brand_code
            , brand_desc 
FROM u_dw.brands);