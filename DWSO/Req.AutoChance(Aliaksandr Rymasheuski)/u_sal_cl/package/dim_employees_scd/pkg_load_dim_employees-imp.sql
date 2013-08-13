/* Formatted on 11.08.2013 14:09:00 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_employees
AS
   PROCEDURE load_employees
   AS
      CURSOR new_empl
      IS
         SELECT emp.emp_id
              , emp.first_name
              , emp.last_name
              , emp.gender
              , emp.position
              , emp.salary
              , NVL ( cc.region_desc, 'not defined ' ) AS office_country
              , NVL ( ct.city_desc, 'not defined' ) AS office_city
              , NVL ( o.office_adress, 'not defined' ) AS office_adress
           FROM u_dw.employees emp
                LEFT JOIN u_dw.offices o
                   ON ( emp.office_id = o.office_id )
                LEFT JOIN u_dw.cities ct
                   ON ( o.city_id = ct.city_id )
                LEFT JOIN u_dw_references.cu_countries cc
                   ON ( ct.country_geo_id = cc.geo_id )
          WHERE emp.emp_id NOT IN (SELECT DISTINCT emp_id
                                     FROM u_str_data.dim_employees_scd);



      CURSOR chg_emp_scd1
      IS
         SELECT emp.emp_id
              , emp.first_name
              , emp.last_name
              , emp.gender
              , emp.salary
              , NVL ( cc.region_desc, 'not defined ' ) AS office_country
              , NVL ( ct.city_desc, 'not defined' ) AS office_city
              , NVL ( o.office_adress, 'not defined' ) AS office_adress
           FROM u_dw.employees emp
                LEFT JOIN u_dw.offices o
                   ON ( emp.office_id = o.office_id )
                LEFT JOIN u_dw.cities ct
                   ON ( o.city_id = ct.city_id )
                LEFT JOIN u_dw_references.cu_countries cc
                   ON ( ct.country_geo_id = cc.geo_id )
         MINUS
         SELECT emp_id
              , first_name
              , last_name
              , gender
              , salary
              , office_country
              , office_city
              , office_adress
           FROM u_str_data.actual_employees;

      CURSOR chg_emp_scd2
      IS
         SELECT emp.emp_id
              , emp.first_name
              , emp.last_name
              , emp.gender
              , emp.position
              , emp.salary
              , NVL ( cc.region_desc, 'not defined ' ) AS office_country
              , NVL ( ct.city_desc, 'not defined' ) AS office_city
              , NVL ( o.office_adress, 'not defined' ) AS office_adress
           FROM u_dw.employees emp
                LEFT JOIN u_dw.offices o
                   ON ( emp.office_id = o.office_id )
                LEFT JOIN u_dw.cities ct
                   ON ( o.city_id = ct.city_id )
                LEFT JOIN u_dw_references.cu_countries cc
                   ON ( ct.country_geo_id = cc.geo_id )
          WHERE ( emp_id, position ) NOT IN (SELECT emp_id
                                                  , position
                                               FROM u_str_data.actual_employees);
   BEGIN
      FOR i IN new_empl LOOP
         INSERT INTO u_str_data.dim_employees_scd
              VALUES ( u_str_data.sq_emp_surr_id.NEXTVAL
                     , i.emp_id
                     , i.first_name
                     , i.last_name
                     , i.gender
                     , i.position
                     , i.salary
                     , i.office_country
                     , i.office_city
                     , i.office_adress
                     , ( SELECT MAX ( action_date ) AS action_dt
                           FROM u_dw.employees_actions
                          WHERE action_type_id = 1
                            AND emp_id = i.emp_id )
                     , TO_DATE ( '12/12/9999'
                               , 'mm/dd/yyyy' ) );
      END LOOP;

      COMMIT;

      FOR j IN chg_emp_scd1 LOOP
         UPDATE u_str_data.dim_employees_scd
            SET first_name   = j.first_name
              , last_name    = j.last_name
              , gender       = j.gender
              , salary       = j.salary
              , office_country = j.office_country
              , office_city  = j.office_city
              , office_adress = j.office_adress
          WHERE emp_id = j.emp_id;
      END LOOP;

      COMMIT;

      FOR i IN chg_emp_scd2 LOOP
         INSERT INTO u_str_data.dim_employees_scd
              VALUES ( u_str_data.sq_emp_surr_id.NEXTVAL
                     , i.emp_id
                     , i.first_name
                     , i.last_name
                     , i.gender
                     , i.position
                     , i.salary
                     , i.office_country
                     , i.office_city
                     , i.office_adress
                     , ( SELECT MAX ( action_date ) AS action_dt
                           FROM u_dw.employees_actions
                          WHERE action_type_id = 1
                            AND emp_id = i.emp_id )
                     , TO_DATE ( '12/12/9999'
                               , 'mm/dd/yyyy' ) );

         UPDATE u_str_data.dim_employees_scd
            SET valid_to     =
                   ( SELECT MAX ( action_date ) AS action_dt
                       FROM u_dw.employees_actions
                      WHERE action_type_id = 1
                        AND emp_id = i.emp_id )
          WHERE valid_to = TO_DATE ( '12/12/9999'
                                   , 'mm/dd/yyyy' )
            AND emp_id = i.emp_id
            AND valid_from < (SELECT MAX ( action_date ) AS action_dt
                                FROM u_dw.employees_actions
                               WHERE action_type_id = 1
                                 AND emp_id = i.emp_id);
      END LOOP;

      COMMIT;
   END load_employees;
END pkg_load_dim_employees;