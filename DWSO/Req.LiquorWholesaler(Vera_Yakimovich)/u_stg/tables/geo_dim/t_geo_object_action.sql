DROP TABLE U_STG.T_GEO_OBIECT_ACTION CASCADE CONSTRAINTS;

CREATE TABLE U_STG.T_GEO_OBIECT_ACTION
(
  GEO_ID          NUMBER(22),
  ACTION_TYPE_ID  NUMBER(20),
  ACTION_DT       DATE,
  VALUE_OLD_NUM   NUMBER(20),
  VALUE_OLD_NM    NUMBER(20)
)
TABLESPACE TS_STG_DATA_01
;

COMMENT ON COLUMN U_STG.T_GEO_OBIECT_ACTION.GEO_ID IS 'Unique ID for All Geography objects';


GRANT INSERT, SELECT, UPDATE ON U_STG.T_GEO_OBIECT_ACTION TO U_DW_EXT_REFERENCES;
