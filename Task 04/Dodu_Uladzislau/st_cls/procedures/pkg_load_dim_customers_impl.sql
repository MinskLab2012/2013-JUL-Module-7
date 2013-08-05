CREATE OR REPLACE PACKAGE BODY pkg_load_dim_customers
as
PROCEDURE load_t_and_lc_customers
AS
   curloc         NUMBER := 1;

   CURSOR cur_c1
   IS
        SELECT DISTINCT th.customer_identifier
                      , th.company_name AS cmp_name
                      , th.cust_region
                      , th.cust_city
                      , th.cust_street
                      , th.cust_fax
                      , th.cust_tel
                      , th.cust_email
                      , th.contact_person cnt_per
                      , fir.customer_id
                      , fir.customer_code
                      , fir.customer_fax
                      , fir.customer_tel
                      , sec.customer_id lc_id
                      , sec.company_name
                      , sec.customer_country
                      , sec.customer_city
                      , sec.customer_address
                      , sec.customer_email
                      , sec.contact_person
                      , sec.localization_id
          FROM u_dw_ext_references.ext_customers th
               LEFT OUTER JOIN st.t_customers fir
                  ON ( th.customer_identifier = fir.customer_code )
               LEFT JOIN st.lc_customers sec
                  ON ( fir.customer_id = sec.customer_id )
      ORDER BY 1;

   TYPE t_customer IS TABLE OF cur_c1%ROWTYPE;

   t_cust         t_customer;
BEGIN
   OPEN cur_c1;

   FETCH cur_c1
   BULK COLLECT INTO t_cust;

   FOR i IN t_cust.FIRST .. t_cust.LAST LOOP
      IF t_cust ( i ).customer_identifier = t_cust ( i ).customer_code THEN
         UPDATE st.t_customers t
            SET t.customer_code = t_cust ( i ).customer_identifier
              , t.customer_fax = t_cust ( i ).cust_fax
              , t.customer_tel = t_cust ( i ).cust_tel
              , t.last_update_dt = SYSDATE
          WHERE t.customer_code = t_cust ( i ).customer_identifier
            AND t.customer_fax != t_cust ( i ).cust_fax
            AND t.customer_tel != t_cust ( i ).cust_tel;

         UPDATE st.lc_customers lc
            SET lc.company_name = t_cust ( i ).cmp_name
              , lc.customer_country = t_cust ( i ).cust_region
              , lc.customer_city = t_cust ( i ).cust_city
              , lc.customer_address = t_cust ( i ).cust_street
              , lc.customer_email = t_cust ( i ).cust_email
              , lc.contact_person = t_cust ( i ).cnt_per
              , lc.localization_id =
                   ( SELECT DISTINCT localization_id
                       FROM st.localization
                      WHERE localization_id = curloc )
              , lc.last_insert_dt = SYSDATE
          WHERE lc.customer_id = t_cust ( i ).customer_id
            AND lc.company_name != t_cust ( i ).cmp_name
            AND lc.customer_country != t_cust ( i ).cust_region
            AND lc.customer_city != t_cust ( i ).cust_city
            AND lc.customer_address != t_cust ( i ).cust_street
            AND lc.customer_email != t_cust ( i ).cust_email
            AND lc.contact_person != t_cust ( i ).cnt_per;
      ELSE
         INSERT INTO st.t_customers t ( t.customer_id
                                      , t.customer_code
                                      , t.customer_fax
                                      , t.customer_tel
                                      , t.last_insert_dt )
              VALUES ( st.seq_t_customers.NEXTVAL
                     , t_cust ( i ).customer_identifier
                     , t_cust ( i ).cust_fax
                     , t_cust ( i ).cust_tel
                     , SYSDATE );

         INSERT INTO st.lc_customers lc ( lc.customer_id
                                        , lc.company_name
                                        , lc.customer_country
                                        , lc.customer_city
                                        , lc.customer_address
                                        , lc.customer_email
                                        , lc.contact_person
                                        , localization_id
                                        , lc.last_insert_dt )
              VALUES ( st.seq_t_customers.CURRVAL
                     , t_cust ( i ).cmp_name
                     , t_cust ( i ).cust_region
                     , t_cust ( i ).cust_city
                     , t_cust ( i ).cust_street
                     , t_cust ( i ).cust_email
                     , t_cust ( i ).cnt_per
                     , curloc
                     , SYSDATE );
      END IF;
   END LOOP;

   CLOSE cur_c1;
END load_t_and_lc_customers;
end;