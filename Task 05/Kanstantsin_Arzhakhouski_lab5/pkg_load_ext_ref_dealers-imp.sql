/* Formatted on 8/13/2013 12:47:55 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_dealers --
AS --
   PROCEDURE load_dealers --
   AS -- 
      CURSOR c_d --
      IS -- 
         SELECT DISTINCT d.dealer_id
                       , d.dealer_name
                       , d.dealer_address
                       , c.capital_id
           FROM u_sa_data.tmp_dealers d join u_sa_data.tmp_capitals c on d.dealer_city = c.capital
          WHERE d.dealer_id NOT IN (SELECT d.dealer_code
                                     FROM u_dw.t_dealers d);
   BEGIN -- 
      FOR i IN c_d LOOP --
         INSERT INTO u_dw.t_dealers ( dealer_id
                                     , dealer_code
                                     , city_id
                                     , dealer_name
                                     , dealer_address
                                     , insert_dt )
              VALUES ( u_dw.sq_dealer_id.NEXTVAL
                     , i.dealer_id
                     
                     , i.capital_id
                     , i.dealer_name
                     , i.dealer_address
                     , SYSDATE );

         EXIT WHEN c_d%NOTFOUND; --
      END LOOP;  --

      COMMIT; --
   END load_dealers; --
END pkg_load_ext_ref_dealers; --
/