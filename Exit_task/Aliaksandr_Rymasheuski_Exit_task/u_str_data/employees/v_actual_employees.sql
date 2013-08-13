/* Formatted on 11.08.2013 12:34:59 (QP5 v5.139.911.3011) */
CREATE VIEW actual_employees
AS
   SELECT emp_id
        , first_name
        , last_name
        , gender
        , position
        , salary
        , office_country
        , office_city
        , office_adress
     FROM u_str_data.dim_employees_scd
    WHERE valid_to = TO_DATE ( '12/12/9999'
                             , 'mm/dd/yyyy' );

GRANT SELECT ON actual_employees TO u_sal_cl;