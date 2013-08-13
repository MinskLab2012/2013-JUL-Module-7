
CREATE OR REPLACE PACKAGE BODY pkg_load_dwh
AS
  
   PROCEDURE load_delivery
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dm_delivery';

      --Extract data
      INSERT INTO dm_delivery
         SELECT deliv.NEXTVAL del_surr_id
              , deliv_id
              , deliv_category
              , cost
              , department_id
              , insert_dt
              , update_dt
           FROM u_dw_references.delivery;

      --Commit Data
      COMMIT;
   END load_delivery;

  
   PROCEDURE load_structures
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dm_structures';

      --Extract data
      INSERT INTO dm_structures
         SELECT structu.NEXTVAL struct_surr_id
              , employee_id
              , first_name
              , last_name
              , experience
              , phone_number
              , email
              , department_id
              , department_name
              , manager_id
              , city
              , geo_id
              , insert_dt
              , update_dt
           FROM (  SELECT e.employee_id
                        , e.first_name
                        , e.last_name
                        , e.experience
                        , e.phone_number
                        , e.email
                        , d.department_id
                        , d.department_name
                        , d.manager_id
                        , d.city
                        , d.geo_id
                        , MIN ( e.insert_dt ) insert_dt
                        , MAX ( e.update_dt ) update_dt
                     FROM    u_dw_references.employees e
                          FULL OUTER JOIN
                             u_dw_references.departments d
                          ON e.department_id = d.department_id
                 GROUP BY e.employee_id
                        , e.first_name
                        , e.last_name
                        , e.experience
                        , e.phone_number
                        , e.email
                        , d.department_id
                        , d.department_name
                        , d.manager_id
                        , d.city
                        , d.geo_id);

      --Commit Data
      COMMIT;
   END load_structures;

  
   PROCEDURE load_products
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dm_products';

      --Extract data
      INSERT INTO dm_products
         SELECT prod.NEXTVAL prod_surr_id
              , prod_id
              , prod_name
              , prod_category
              , prod_list_price
              , insert_dt
              , update_dt
           FROM (  SELECT p.prod_id
                        , p.prod_name
                        , ca.prod_category
                        , p.prod_list_price
                        , MIN ( p.insert_dt ) insert_dt
                        , MAX ( p.update_dt ) update_dt
                     FROM    u_dw_references.products p
                          FULL OUTER JOIN
                             u_dw_references.prod_category ca
                          ON ca.category_id = p.prod_category_id
                 GROUP BY p.prod_id
                        , p.prod_name
                        , ca.prod_category
                        , p.prod_list_price);

      --Commit Data
      COMMIT;
   END load_products;

  
   PROCEDURE load_suppliers
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dm_suppliers';

      --Extract data
      INSERT INTO dm_suppliers
         SELECT suppl.NEXTVAL suppl_surr_id
              , suppl_id
              , suppl_name
              , phone_number
              , mail
              , country_name
              , category_id
              , geo_id
              , insert_dt
              , update_dt
           FROM u_dw_references.suppliers;

      --Commit Data
      COMMIT;
   END load_suppliers;

   PROCEDURE load_clients
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE dm_clients';

      --Extract data
      INSERT INTO dm_clients
         SELECT client.NEXTVAL client_surr_id
              , cl.client_id
              , cl.first_name
              , cl.last_name
              , cl.gender
              , cl.street_address
              , cl.city
              , cl.account
              , cl.email
              , cl.phone_number
              , NVL ( ac.action_date, SYSDATE ) update_dt
           FROM u_dw_references.clients cl LEFT JOIN u_dw_references.client_actions ac ON ac.client_id = cl.client_id                --Commit Data
                                       commit;
   end load_clients;

 
  


end pkg_load_dwh;
/