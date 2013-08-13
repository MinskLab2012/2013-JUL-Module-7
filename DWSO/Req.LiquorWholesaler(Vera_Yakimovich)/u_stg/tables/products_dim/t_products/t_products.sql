ALTER TABLE U_STG.T_PRODUCTS
 DROP PRIMARY KEY CASCADE;

DROP TABLE U_STG.T_PRODUCTS CASCADE CONSTRAINTS;

CREATE TABLE U_STG.T_PRODUCTS
(
  PRODUCT_ID        NUMBER(20)                  NOT NULL,
  PRODUCT_CODE      VARCHAR2(15 BYTE),
  PROD_CATEGORY_ID  NUMBER(20),
  MEASURE_ID        NUMBER(20),
  QUANTITY          NUMBER(10),
  COST              NUMBER(15,3),
  INSERT_DT         DATE,
  UPDATE_DT         DATE
)
TABLESPACE TS_STG_DATA_01
;


CREATE UNIQUE INDEX U_STG.PK_T_PRODUCTS ON U_STG.T_PRODUCTS
(PRODUCT_ID)
LOGGING
TABLESPACE TS_STG_DATA_01
;


ALTER TABLE U_STG.T_PRODUCTS ADD (
  CONSTRAINT PK_T_PRODUCTS
 PRIMARY KEY
 (PRODUCT_ID)
    USING INDEX 
    TABLESPACE TS_STG_DATA_01
);

ALTER TABLE U_STG.T_PRODUCTS ADD (
  CONSTRAINT FK_T_PRODUC_REFERENCE_T_MEASUR 
 FOREIGN KEY (MEASURE_ID) 
 REFERENCES U_STG.T_MEASURES (MEASURE_ID),
  CONSTRAINT FK_T_PRODUC_REFERENCE_T_PROD_C 
 FOREIGN KEY (PROD_CATEGORY_ID) 
 REFERENCES U_STG.T_PROD_CATEGORY (PROD_CATEGORY_ID));

GRANT INSERT, SELECT, UPDATE ON U_STG.T_PRODUCTS TO U_DW_EXT_REFERENCES;
