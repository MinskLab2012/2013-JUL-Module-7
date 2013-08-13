/* Formatted on 8/2/2013 2:51:05 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_customers_dw
AS
   -- Load Data From Sources table to DataBase
   PROCEDURE load_tmp_customers
   AS
      CURSOR c_fg
      IS
         ( SELECT DISTINCT sa_t.cust_first_name
                         , t2.geo_id
                         , sa_t.cust_last_name
                         , sa_t.cust_gender
                         , sa_t.cust_birth_year
                         , sa_t.cust_email
                         , sa_t.cust_pass_number
                         , sa_t.cust_balance
                         , sa_t.cust_level_income
                         , t3.cust_pass_number AS code
                         , t3.cust_balance AS bal
                         , t3.cust_level_income AS lev
             FROM u_sa_data.tmp_customers sa_t
                  LEFT OUTER JOIN u_dw_references.cu_countries t2
                     ON ( sa_t.cust_country_desc = t2.region_desc )
                  LEFT JOIN u_dw.dw_customers t3
                     ON ( sa_t.cust_pass_number = t3.cust_pass_number ) );
   BEGIN
      DELETE FROM u_dw.dw_customers dw_t
            WHERE dw_t.cust_pass_number NOT IN (SELECT DISTINCT cust_pass_number
                                                  FROM u_sa_data.tmp_customers);

      --Insert Source data
      FOR i IN c_fg LOOP
         IF i.cust_pass_number = i.code THEN
            UPDATE u_dw.dw_customers dw_c
               SET dw_c.cust_balance = i.cust_balance
                 , dw_c.cust_level_income = i.cust_level_income
                 , dw_c.update_dt = SYSDATE
             WHERE i.cust_pass_number = i.code
               AND ( i.cust_balance != i.bal
                 OR  i.cust_level_income != i.lev );
         ELSIF i.cust_pass_number != NVL ( i.code, -99 ) THEN
            INSERT INTO u_dw.dw_customers ( cust_id
                                          , cust_geo_id
                                          , cust_first_name
                                          , cust_last_name
                                          , cust_gender
                                          , cust_year_of_birth
                                          , cust_email
                                          , cust_pass_number
                                          , cust_balance
                                          , cust_level_income
                                          , insert_dt )
                 VALUES ( seq_customers.NEXTVAL
                        , i.geo_id
                        , i.cust_first_name
                        , i.cust_last_name
                        , i.cust_gender
                        , i.cust_birth_year
                        , i.cust_email
                        , i.cust_pass_number
                        , i.cust_balance
                        , i.cust_level_income
                        , SYSDATE );
         END IF;
      END LOOP;

      COMMIT;
   END load_tmp_customers;
END pkg_etl_dim_customers_dw;