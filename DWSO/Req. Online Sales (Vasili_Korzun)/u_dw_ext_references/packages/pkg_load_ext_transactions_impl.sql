/* Formatted on 8/5/2013 4:26:29 PM (QP5 v5.139.911.3011) */

create or replace package body pkg_load_ext_transactions
as
PROCEDURE load_bulk_insert_transactions
AS
   CURSOR cur_t
   IS
            SELECT /*+USE_MERGE(cls, cust, ds)  USE_HASH(cls, prod, cntr, ps) parallel( cls, 4) parallel(cust, 4) */
      cls.transaction_dt
     , prod.prod_id
     , cust.customer_id
     , cntr.geo_id AS country_geo_id
     , ps.payment_system_id
     , ds.delivery_system_id
     , cost as amount_sold
     , DECODE ( status,  'sucess', 1,  'fail', 2,  'reject', 3,  -1 ) AS status_id
  FROM tmp_orders cls
       JOIN st_data.customers cust
          ON cls.first_name = cust.first_name
         AND cls.last_name = cust.last_name
         AND cls.birth_day = cust.birth_date
       JOIN st_data.delivery_systems ds
          ON cls.delivery_system_code = ds.delivery_system_code
       JOIN st_data.products prod
          ON cls.prod_name = prod.prod_code
       JOIN u_dw_references.lc_countries cntr
          ON cntr.country_desc = cls.country
       JOIN st_data.payment_systems ps
          ON ps.payment_system_code = cls.payment_system_desc
          minus
          select event_dt
                                       , prod_id
                                       , customer_id
                                       , country_geo_id
                                       , payment_system_id
                                       , delivery_system_id
                                       , amount_sold
                                       , status_id  from st_data.transactions;

   TYPE transactions_table IS TABLE OF cur_t%ROWTYPE;

   transactions   transactions_table;
BEGIN
   OPEN cur_t;

   LOOP
      FETCH cur_t
      BULK COLLECT INTO transactions; --      LIMIT 10000;

      IF cur_t%NOTFOUND THEN
         EXIT;
      END IF;
   END LOOP;

   FORALL i IN transactions.FIRST .. transactions.LAST
      INSERT INTO st_data.transactions ( event_dt
                                       , transaction_id
                                       , prod_id
                                       , customer_id
                                       , country_geo_id
                                       , payment_system_id
                                       , delivery_system_id
                                       , amount_sold
                                       , status_id )
           VALUES ( transactions ( i ).transaction_dt
                  , st_data.transactions_seq.NEXTVAL
                  , transactions ( i ).prod_id
                  , transactions ( i ).customer_id
                  , transactions ( i ).country_geo_id
                  , transactions ( i ).payment_system_id
                  , transactions ( i ).delivery_system_id
                  , transactions ( i ).amount_sold
                  , transactions ( i ).status_id );

   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      raise_application_error ( -20111
                              , 'Error while loading transactions' );
END;
end pkg_load_ext_transactions;



-- initial query
--SELECT /*+USE_MERGE(cls, cust, ds)  USE_HASH(cls, prod, cntr, ps) parallel( cls, 4) parallel(cust, 4) */
--      cls.transaction_dt
--     , prod.prod_id
--     , cust.customer_id
--     , cntr.geo_id AS country_geo_id
--     , ps.payment_system_id
--     , ds.delivery_system_id
--     , cost
--     , DECODE ( status,  'sucess', 1,  'fail', 2,  'reject', 3,  -1 ) AS status_id
--  FROM tmp_orders cls
--       JOIN st_data.customers cust
--          ON cls.first_name = cust.first_name
--         AND cls.last_name = cust.last_name
--         AND cls.birth_day = cust.birth_date
--       JOIN st_data.delivery_systems ds
--          ON cls.delivery_system_code = ds.delivery_system_code
--       JOIN st_data.products prod
--          ON cls.prod_name = prod.prod_code
--       JOIN u_dw_references.lc_countries cntr
--          ON cntr.country_desc = cls.country
--       JOIN st_data.payment_systems ps
--          ON ps.payment_system_code = cls.payment_system_desc;

-- -- joins?
--SELECT /*+ use_merge(cls, st) parallel(st, 4) */ cls.transaction_dt
--     , st.transaction_id
--     , cls.prod_id
--     , cls.customer_id
--     , cls.country_geo_id
--     , cls.payment_system_id
--     , cls.delivery_system_id
--     , cls.amount_sold
--     , cls.status_id
--  FROM    (SELECT /*+USE_MERGE(cls, cust, ds)  USE_HASH(cls, prod, cntr, ps) parallel( cls, 4) parallel(cust, 4) */
--                 cls.transaction_dt
--                , prod.prod_id
--                , cust.customer_id
--                , cntr.geo_id AS country_geo_id
--                , ps.payment_system_id
--                , ds.delivery_system_id
--                , cost AS amount_sold
--                , DECODE ( status,  'sucess', 1,  'fail', 2,  'reject', 3,  -1 ) AS status_id
--             FROM tmp_orders cls
--                  JOIN st_data.customers cust
--                     ON cls.first_name = cust.first_name
--                    AND cls.last_name = cust.last_name
--                    AND cls.birth_day = cust.birth_date
--                  JOIN st_data.delivery_systems ds
--                     ON cls.delivery_system_code = ds.delivery_system_code
--                  JOIN st_data.products prod
--                     ON cls.prod_name = prod.prod_code
--                  JOIN u_dw_references.lc_countries cntr
--                     ON cntr.country_desc = cls.country
--                  JOIN st_data.payment_systems ps
--                     ON ps.payment_system_code = cls.payment_system_desc) cls
--       LEFT JOIN
--          st_data.transactions st
--       ON cls.transaction_dt = st.event_dt
--      AND cls.prod_id = st.prod_id
--      AND cls.customer_id = st.customer_id
--      AND cls.country_geo_id = st.country_geo_id
--      AND cls.payment_system_id = st.payment_system_id
--      AND cls.delivery_system_id = st.delivery_system_id
--      AND cls.amount_sold = st.amount_sold
--      AND cls.status_id = st.status_id;
--      
--      
--      
--      
--      
--      -- minus?
--      SELECT /*+USE_MERGE(cls, cust, ds)  USE_HASH(cls, prod, cntr, ps) parallel( cls, 4) parallel(cust, 4) */
--      cls.transaction_dt
--     , prod.prod_id
--     , cust.customer_id
--     , cntr.geo_id AS country_geo_id
--     , ps.payment_system_id
--     , ds.delivery_system_id
--     , cost
--     , DECODE ( status,  'sucess', 1,  'fail', 2,  'reject', 3,  -1 ) AS status_id
--  FROM tmp_orders cls
--       JOIN st_data.customers cust
--          ON cls.first_name = cust.first_name
--         AND cls.last_name = cust.last_name
--         AND cls.birth_day = cust.birth_date
--       JOIN st_data.delivery_systems ds
--          ON cls.delivery_system_code = ds.delivery_system_code
--       JOIN st_data.products prod
--          ON cls.prod_name = prod.prod_code
--       JOIN u_dw_references.lc_countries cntr
--          ON cntr.country_desc = cls.country
--       JOIN st_data.payment_systems ps
--          ON ps.payment_system_code = cls.payment_system_desc
--          minus
--          select event_dt
--                                       , prod_id
--                                       , customer_id
--                                       , country_geo_id
--                                       , payment_system_id
--                                       , delivery_system_id
--                                       , amount_sold
--                                       , status_id  from st_data.transactions;