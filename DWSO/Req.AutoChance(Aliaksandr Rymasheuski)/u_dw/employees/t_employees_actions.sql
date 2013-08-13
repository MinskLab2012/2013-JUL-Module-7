/* Formatted on 09.08.2013 19:35:19 (QP5 v5.139.911.3011) */
--ALTER TABLE EMPLOYEES_ACTIONS
--   DROP CONSTRAINT FK_EMPLOYEE_REFERENCE_ACTION_T;
--
--ALTER TABLE EMPLOYEES_ACTIONS
--   DROP CONSTRAINT FK_EMPLOYEE_REFERENCE_EMPLOYEE;

DROP TABLE employees_actions CASCADE CONSTRAINTS;

/*==============================================================*/

/* Table: "EMPLOYEES_ACTIONS"                                   */

/*==============================================================*/

CREATE TABLE employees_actions
(
   emp_id         NUMBER ( 20 )
 , action_date    DATE
 , action_type_id NUMBER ( 20 )
 , new_value_str      VARCHAR2 ( 50 CHAR )
);

ALTER TABLE employees_actions
   ADD CONSTRAINT fk_employee_reference_action_t FOREIGN KEY (action_type_id)
      REFERENCES employees_action_types (action_type_id);

ALTER TABLE employees_actions
   ADD CONSTRAINT fk_employee_reference_employee FOREIGN KEY (emp_id)
      REFERENCES employees (emp_id);


GRANT DELETE,INSERT,UPDATE,SELECT ON employees_actions TO u_dw_cleansing;