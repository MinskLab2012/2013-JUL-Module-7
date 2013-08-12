ALTER TABLE U_STG.LC_CUST_STATUS
 DROP PRIMARY KEY CASCADE;

DROP TABLE U_STG.LC_CUST_STATUS CASCADE CONSTRAINTS;

CREATE TABLE U_STG.LC_CUST_STATUS
(
  STATUS_ID        NUMBER(20)                   NOT NULL,
  STATUS_CODE      VARCHAR2(10 BYTE),
  STATUS_DESC      VARCHAR2(70 BYTE),
  LOCALIZATION_ID  NUMBER(22)                   NOT NULL
)
TABLESPACE TS_STG_DATA_01
;

COMMENT ON COLUMN U_STG.LC_CUST_STATUS.LOCALIZATION_ID IS 'Identificator of Supported References Languages';


CREATE UNIQUE INDEX U_STG.PK_LC_CUST_STATUS ON U_STG.LC_CUST_STATUS
(STATUS_ID, LOCALIZATION_ID)
LOGGING
TABLESPACE TS_STG_DATA_01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          160K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


ALTER TABLE U_STG.LC_CUST_STATUS ADD (
  CONSTRAINT PK_LC_CUST_STATUS
 PRIMARY KEY
 (STATUS_ID, LOCALIZATION_ID)
    USING INDEX 
    TABLESPACE TS_STG_DATA_01
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          160K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
               ));

ALTER TABLE U_STG.LC_CUST_STATUS ADD (
  CONSTRAINT FK_LC_CUST__REFERENCE_T_CUST_S 
 FOREIGN KEY (STATUS_ID) 
 REFERENCES U_STG.T_CUST_STATUS (STATUS_ID),
  CONSTRAINT FK_LC_CUST__REFERENCE_T_LOCALI 
 FOREIGN KEY (LOCALIZATION_ID) 
 REFERENCES U_STG.T_LOCALIZATIONS (LOCALIZATION_ID));

GRANT INSERT, SELECT, UPDATE ON U_STG.LC_CUST_STATUS TO U_DW_EXT_REFERENCES;
