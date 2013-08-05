ALTER TABLE EMPLOYEES_ACTIONS
   DROP CONSTRAINT FK_EMPLOYEE_REFERENCE_ACTION_T;

DROP TABLE ACTION_TYPES CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: ACTION_TYPIES                                      */
/*==============================================================*/
CREATE TABLE ACTION_TYPES 
(
   ACTION_TYPE_ID     NUMBER(20)           NOT NULL,
   ACTION_DESC        VARCHAR2(50 CHAR),
   CONSTRAINT PK_ACTION_TYPES PRIMARY KEY (ACTION_TYPE_ID)
);



GRANT DELETE,INSERT,UPDATE,SELECT ON ACTION_TYPES TO u_dw_cleansing;