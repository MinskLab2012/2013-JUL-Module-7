ALTER TABLE contracts
   DROP CONSTRAINT fk_contract_reference_employee;

ALTER TABLE employees
   DROP CONSTRAINT fk_employee_reference_offices;

ALTER TABLE employees_actions
   DROP CONSTRAINT fk_employee_reference_employee;

DROP TABLE employees CASCADE CONSTRAINTS;

/*==============================================================*/

/* Table: EMPLOYEES                                           */

/*==============================================================*/

CREATE TABLE employees
(
   emp_id         NUMBER ( 20 ) NOT NULL
 , emp_code       NUMBER ( 20 )
 , first_name     VARCHAR2 ( 50 CHAR )
 , last_name      VARCHAR2 ( 50 CHAR )
 , position       VARCHAR ( 50 )
 , office_id      NUMBER ( 20 )
 , gender         VARCHAR2 ( 10 CHAR )
 , salary         NUMBER ( 20 )
 , CONSTRAINT pk_employees PRIMARY KEY ( emp_id )
);

ALTER TABLE employees
   ADD CONSTRAINT fk_employee_reference_offices FOREIGN KEY (office_id)
      REFERENCES offices (office_id);


GRANT DELETE,INSERT,UPDATE,SELECT ON employees TO u_dw_cleansing;