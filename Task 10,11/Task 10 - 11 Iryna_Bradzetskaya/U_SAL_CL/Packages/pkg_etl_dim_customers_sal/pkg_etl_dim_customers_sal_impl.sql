CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_customers_sal
AS
   -- Load Data From Stage table to Star
   PROCEDURE load_DIM_CUSTOMERS
   AS
      CURSOR c_fg
      IS
         ( SELECT DISTINCT dw_t.cust_id 
                         , dw_t.cust_first_name
                         , dw_t.cust_geo_id
                         , dw_t.cust_last_name
                         , dw_t.cust_gender
                         , dw_t.CUST_YEAR_OF_BIRTH
                         , dw_t.cust_email
                         , dw_t.cust_pass_number
                         , dw_t.cust_balance
                         , dw_t.cust_level_income
                         , sal_t.cust_balance AS bal
                         , sal_t.cust_level_income AS lev
                         , sal_t.cust_id  AS code
             FROM u_dw.DW_CUSTOMERS dw_t
                  LEFT JOIN u_sal.dim_customers sal_t
                     ON ( dw_t.CUST_ID = sal_t.CUST_ID ) );
   BEGIN
      DELETE FROM u_sal.dim_customers sal_t
            WHERE sal_t.CUST_ID NOT IN (SELECT DISTINCT CUST_ID
                                                  FROM u_dw.DW_CUSTOMERS);

      --Insert Source data
      FOR i IN c_fg LOOP
         IF i.cust_id  = i.code THEN
            UPDATE u_sal.dim_customers sal_t
               SET sal_t.cust_balance = i.cust_balance
                 , sal_t.cust_level_income = i.cust_level_income
                 , sal_t.update_dt = SYSDATE
             WHERE i.cust_id = i.code
               AND ( i.cust_balance != i.bal
                 OR  i.cust_level_income != i.lev );
         ELSIF i.cust_id != NVL ( i.code, -99 ) THEN
            INSERT INTO u_sal.dim_customers ( cust_id
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
                 VALUES ( i.cust_id 
                        , i.cust_geo_id
                        , i.cust_first_name
                        , i.cust_last_name
                        , i.cust_gender
                        , i.CUST_YEAR_OF_BIRTH
                        , i.cust_email
                        , i.cust_pass_number
                        , i.cust_balance
                        , i.cust_level_income
                        , SYSDATE );
         END IF;
      END LOOP;
 
      COMMIT;
   END load_DIM_CUSTOMERS;
END pkg_etl_dim_customers_sal;


INSERT INTO u_sal.dim_customers (CUST_ID, CUST_FIRST_NAME, CUST_LAST_NAME) VALUES ( -99, 'n/d', 'n/d');
commit;