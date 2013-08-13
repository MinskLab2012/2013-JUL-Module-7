/* Formatted on 13.08.2013 12:40:43 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_fct_sales_dd
AS
   PROCEDURE load_fct_sales_dd ( sales_year IN NUMBER )
   AS
      sql_str        VARCHAR2 ( 3000 );
      sql_str1       VARCHAR2 ( 3000 );
      sql_str2       VARCHAR2 ( 3000 );
   BEGIN
      sql_str     := 'TRUNCATE  TABLE sales_dd_temp ';

      EXECUTE IMMEDIATE sql_str;

      sql_str     :=
         ' INSERT /*+ append*/
         INTO u_sal_cl.sales_dd_temp
         SELECT TRUNC ( con.event_dt
               , ''DD'' )
            AS event_dt
       , gp.per_surr_id
       , con.contract_number
       , con.car_id
       , geo.geo_surr_id
       , geo.geo_id
       , con.cust_id
       , emp_surr_id
       , COUNT ( * ) AS amount_sold
       , SUM ( con.price - cr.cost ) AS profit
       , SYSDATE
    FROM u_dw.contracts con
         LEFT JOIN u_str_data.dim_gen_periods gp
            ON ( TRUNC ( con.event_dt
                       , ''DD'' ) >= gp.per_begin
            AND TRUNC ( con.event_dt
                      , ''DD'' ) < gp.per_end )
         LEFT JOIN u_dw.customers cust
            ON ( con.cust_id = cust.cust_id )
         LEFT JOIN u_dw.cities ct
            ON ( cust.city_id = ct.city_id )
         LEFT JOIN u_str_data.dim_geo_locations_scd geo
            ON ( ct.country_geo_id = geo.geo_id
            -- AND con.event_dt >= geo.valid_from
            --no rows satisfy the condition because event_dt start from 1999 year and valid_from was taken like sysdate when row was inserted
            --correct valid_from must be business date
            AND con.event_dt <= geo.valid_to
            AND geo.level_code = ''Countries'' )
         LEFT JOIN u_str_data.dim_employees_scd emp
            ON ( con.emp_id = emp.emp_id
            --  AND con.event_dt >= emp.valid_from
            --the same situation :(
            AND con.event_dt <= emp.valid_to )
        LEFT JOIN u_str_data.dim_cars cr
            ON ( con.car_id = cr.car_id )
   WHERE EXTRACT ( YEAR FROM con.event_dt ) = :a
GROUP BY TRUNC ( con.event_dt
               , ''DD'' )
       , gp.per_surr_id
       , con.contract_number
       , con.car_id
       , geo.geo_surr_id
       , geo.geo_id
       , con.cust_id
       , emp_surr_id
       , SYSDATE';


      EXECUTE IMMEDIATE sql_str USING sales_year;

      COMMIT;

      sql_str1    := 'ALTER TABLE u_str_data.fct_sales_dd EXCHANGE PARTITION sales';
      sql_str2    := ' WITH TABLE sales_dd_temp INCLUDING INDEXES WITHOUT VALIDATION';
      sql_str     := sql_str1 || sales_year || sql_str2;

      EXECUTE IMMEDIATE sql_str;
   END load_fct_sales_dd;
END pkg_load_fct_sales_dd;