ALTER TABLE EMPLOYEES
   DROP CONSTRAINT FK_EMPLOYEE_REFERENCE_OFFICES;

ALTER TABLE OFFICES
   DROP CONSTRAINT FK_OFFICES_REFERENCE_CITIES;

DROP TABLE OFFICES CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OFFICES                                            */
/*==============================================================*/
CREATE TABLE OFFICES 
(
   OFFICE_ID          NUMBER(20)           NOT NULL,
   OFFICE_CODE        NUMBER(20),
   CITY_ID            NUMBER(20),
   OFFICE_ADRESS      VARCHAR2(50 CHAR),
   INSERT_DT          DATE,
   UPDATE_DT          DATE,
   CONSTRAINT PK_OFFICES PRIMARY KEY (OFFICE_ID)
);

ALTER TABLE OFFICES
   ADD CONSTRAINT FK_OFFICES_REFERENCE_CITIES FOREIGN KEY (CITY_ID)
      REFERENCES CITIES (CITY_ID);

GRANT DELETE,INSERT,UPDATE,SELECT ON OFFICES TO u_dw_cleansing;

