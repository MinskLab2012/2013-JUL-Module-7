/* Formatted on 8/5/2013 8:49:47 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_contr
AS
   --load contracts
   PROCEDURE load_contracts
   AS
      CURSOR c1
      IS
         SELECT cn.event_dt
              , cn.contract_number
              , cr.car_id
              , emp.emp_id
              , cust.cust_id
              , cn.price
           FROM u_sa_data.contracts cn
                JOIN u_dw.cars cr
                   ON ( cn.car_id = cr.car_code )
                JOIN u_dw.employees emp
                   ON ( cn.emp_id = emp.emp_code )
                JOIN u_dw.customers cust
                   ON ( cn.cust_id = cust.cust_code )
         MINUS
         SELECT event_dt
              , contract_number
              , car_id
              , emp_id
              , cust_id
              , price
           FROM u_dw.contracts;

      counter        NUMBER;
   BEGIN
      counter     := 1;

      FOR i IN c1 LOOP
         INSERT INTO u_dw.contracts
              VALUES ( u_dw.sq_contracts_id.NEXTVAL
                     , i.event_dt
                     , i.contract_number
                     , i.car_id
                     , i.emp_id
                     , i.cust_id
                     , i.price );

         IF ( MOD ( counter
                  , 10000 ) = 0 ) THEN
            COMMIT;
         END IF;

         counter     := counter + 1;
      END LOOP;

      COMMIT;
   END load_contracts;
END pkg_load_ext_ref_contr;
