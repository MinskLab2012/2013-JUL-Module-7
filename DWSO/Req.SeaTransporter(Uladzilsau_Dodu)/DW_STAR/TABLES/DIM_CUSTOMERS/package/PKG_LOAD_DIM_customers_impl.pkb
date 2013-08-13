/* Formatted on 8/12/2013 3:05:56 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_customers
AS
   PROCEDURE load_dim_customers
   AS
      CURSOR cur_c1
      IS
         SELECT t.customer_id
              , t.customer_code
              , lc.company_name
              , lc.customer_country
              , lc.customer_city
              , lc.customer_address
              , t.customer_fax
              , t.customer_tel
              , lc.customer_email
              , lc.contact_person
              , dw.customer_id AS cust
           FROM st.t_customers t
                JOIN st.lc_customers lc
                   ON t.customer_id = lc.customer_id
                LEFT JOIN dw_star.dim_customers dw
                   ON t.customer_id = dw.customer_id;


      TYPE cust_tab IS TABLE OF cur_c1%ROWTYPE;

      teb            cust_tab;
   BEGIN
      OPEN cur_c1;

      FETCH cur_c1
      BULK COLLECT INTO teb;

      FOR i IN teb.FIRST .. teb.LAST LOOP
         IF teb ( i ).cust IS NULL THEN
            INSERT INTO dw_star.dim_customers ( customer_id
                                              , customer_code
                                              , company_name
                                              , customer_country
                                              , customer_city
                                              , customer_address
                                              , customer_fax
                                              , customer_tel
                                              , customer_email
                                              , contact_person
                                              , last_insert_dt )
                 VALUES ( teb ( i ).customer_id
                        , teb ( i ).customer_code
                        , teb ( i ).company_name
                        , teb ( i ).customer_country
                        , teb ( i ).customer_city
                        , teb ( i ).customer_address
                        , teb ( i ).customer_fax
                        , teb ( i ).customer_tel
                        , teb ( i ).customer_email
                        , teb ( i ).contact_person
                        , SYSDATE );

            COMMIT;
         ELSE
            UPDATE dw_star.dim_customers
               SET customer_code    = teb ( i ).customer_code
                 , company_name  = teb ( i ).company_name
                 , customer_country  = teb ( i ).customer_country
                 , customer_city = teb ( i ).customer_city
                 , customer_address    = teb ( i ).customer_address
                 ,customer_fax = teb(i).customer_fax
                 , customer_tel = teb(i).customer_tel
                 , customer_email = teb(i).customer_email
                 ,contact_person = teb(i).contact_person
                 , last_update_dt = SYSDATE
             WHERE customer_id = teb ( i ).customer_id
               AND ( customer_code    = teb ( i ).customer_code
                 or company_name  = teb ( i ).company_name
                 or customer_country  = teb ( i ).customer_country
                 or customer_city = teb ( i ).customer_city
                 or customer_address    = teb ( i ).customer_address
                 or customer_fax = teb(i).customer_fax
                 or customer_tel = teb(i).customer_tel
                 or customer_email = teb(i).customer_email
                 or contact_person = teb(i).contact_person );
         END IF;
      END LOOP;

      COMMIT;
   END load_dim_customers;
END;