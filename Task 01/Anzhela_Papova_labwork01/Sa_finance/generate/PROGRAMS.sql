CREATE TABLE programs
(
   program_code   VARCHAR2 ( 16 BYTE )
 , program_name   VARCHAR2 ( 100 BYTE )
 , program_purpose VARCHAR2 ( 200 BYTE )
 , manager_fn     VARCHAR2 ( 50 BYTE )
 , manager_ln     VARCHAR2 ( 50 BYTE )
 , start_date     DATE
 , end_date       DATE
);

INSERT INTO programs
   SELECT DISTINCT SUBSTR ( dep.department_name
                          , 1
                          , 4 )
                      AS program_code
                 , 'PRG-' || dep.department_name AS program_name
                 , 'Optimisation of ' || dep.department_name AS program_purpose
                 , emp.first_name AS manager_fn
                 , emp.last_name AS manager_ln
                 , TO_DATE ( TRUNC ( dbms_random.VALUE ( 2451000
                                                       , 2452000 ) )
                           , 'j' )
                      AS start_date
                 , TO_DATE ( TRUNC ( dbms_random.VALUE ( 2452001
                                                       , 2456293 ) )
                           , 'j' )
                      AS end_date
     FROM hr.departments dep
        , hr.employees emp;

COMMIT;