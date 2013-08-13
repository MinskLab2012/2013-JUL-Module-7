/* Formatted on 11.08.2013 12:16:20 (QP5 v5.139.911.3011) */
DROP TABLE dim_employees_scd CASCADE CONSTRAINTS;

CREATE TABLE dim_employees_scd
(
   emp_surr_id    NUMBER ( 20 ) NOT NULL
 , emp_id         NUMBER ( 20 )
 , first_name     VARCHAR2 ( 300 )
 , last_name      VARCHAR2 ( 300 )
 , gender         VARCHAR2 ( 10 )
 , position       VARCHAR2 ( 300 )
 , salary         NUMBER ( 20 )
 , office_country VARCHAR2 ( 300 )
 , office_city    VARCHAR2 ( 300 )
 , office_adress  VARCHAR2 ( 300 )
 , valid_from     DATE
 , valid_to       DATE
);

INSERT INTO dim_employees_scd
     VALUES ( -99
            , -99
            , 'not available'
            , 'not available'
            , 'n.a.'
            , 'not available'
            , -99
            , 'not available'
            , 'not available'
            , 'not available'
            , NULL
            , NULL );

COMMIT;

GRANT DELETE,INSERT,UPDATE,SELECT ON dim_employees_scd TO u_sal_cl;