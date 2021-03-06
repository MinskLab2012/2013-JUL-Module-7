DROP TABLE U_SAL.FCT_INCOME_PRODUCTS_MONTHLY CASCADE CONSTRAINTS;

CREATE TABLE U_SAL.FCT_INCOME_PRODUCTS_MONTHLY
(
  EVENT_DT     DATE,
  PRODUCT_ID   NUMBER(20),
  ORD_GEO_ID   NUMBER(22),
  CUSTOMER_ID  NUMBER(20),
  QUANTITY     NUMBER(10),
  TOTAL_COST   NUMBER(25,2),
  AMOUNT_SOLD  NUMBER(25,2)
)
TABLESPACE TS_STAR_01
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
PARTITION BY RANGE (EVENT_DT)
(  
  PARTITION ARCH VALUES LESS THAN (TO_DATE(' 2013-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_CLS_FCT_MONTHLY
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          160K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION Y2013 VALUES LESS THAN (TO_DATE(' 2014-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_FCT_ARCH
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          160K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               )
)
NOCOMPRESS 
NOCACHE
PARALLEL ( DEGREE DEFAULT INSTANCES DEFAULT )
MONITORING;


GRANT ALTER, SELECT ON U_SAL.FCT_INCOME_PRODUCTS_MONTHLY TO U_CLS_STAR;
