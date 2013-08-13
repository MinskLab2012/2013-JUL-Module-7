DROP TABLE U_SAL.DIM_PRODUCTS CASCADE CONSTRAINTS;

CREATE TABLE U_SAL.DIM_PRODUCTS
(
  PRODUCT_ID     NUMBER(20)                     NOT NULL,
  CATEGORY_DESC  VARCHAR2(70 BYTE),
  MEASURE_DESC   VARCHAR2(70 BYTE),
  COST           NUMBER(15,3)
)
TABLESPACE TS_STAR_01
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          160K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;
