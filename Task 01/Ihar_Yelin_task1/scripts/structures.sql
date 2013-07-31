/* Formatted on 7/30/2013 9:10:59 PM (QP5 v5.139.911.3011) */
CREATE TABLE structures
AS
   SELECT DISTINCT e.employee_id
                 , e.first_name
                 , e.last_name
                 , ROUND ( ( SYSDATE - e.hire_date ) / 365 ) EXP
                 , e.phone_number
                 , e.email
                 , dept.department_id
                 , dept.department_name
                 , dept.manager_id
                 , loc.city
                 , co.geo_id
     FROM jobs jo
          RIGHT JOIN employees e
             ON e.job_id = e.job_id
          FULL JOIN departments dept
             ON dept.department_id = e.department_id
          FULL JOIN locations loc
             ON loc.location_id = dept.location_id
          LEFT JOIN u_dw_references.lc_countries co
             ON co.country_code_a2 = loc.country_id;