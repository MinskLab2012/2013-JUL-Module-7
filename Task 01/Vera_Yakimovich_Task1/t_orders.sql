--countries
/*
( SELECT ROWNUM AS country_id
       , country_desc
    FROM u_dw_references.lc_countries );
*/

DROP TABLE t_orders PURGE;

CREATE TABLE t_orders
(
   event_dt       DATE
 , order_id       NUMBER ( 30 )
 , country_desc   VARCHAR2 ( 70 )
 , company_code   NUMBER ( 30 )
 , company_name   VARCHAR2 ( 70 )
 , comp_country_desc VARCHAR2 ( 70 )
 , comp_status    VARCHAR2 ( 50 )
 , product_name   VARCHAR2 ( 70 )
 , sort_name      VARCHAR2 ( 50 )
 , measure        VARCHAR2 ( 50 )
 , quantity       NUMBER ( 10 )
 , price          NUMBER ( 20, 2 )
 , set_quantity   NUMBER ( 5 )
 , total_price    NUMBER ( 30, 2 )
)
TABLESPACE ts_references_ext_data_01;

BEGIN
   FOR c IN 1 .. 110 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO t_orders
         SELECT DISTINCT event_dt
                       , order_id
                       , temp_cntr.country_desc
                       , temp_orders.company_code
                       , company_name
                       , temp_companies.country_desc AS comp_country_desc
                       , comp_status
                       , product_name
                       , sort_name
                       , measure
                       , quantity
                       , price
                       , set_quantity
                       ,   set_quantity
                         * price
                         * ROUND ( dbms_random.VALUE ( 1
                                                     , 1.311 )
                                 , 2 )
                            AS total_price
           FROM (SELECT --+NO_MERGE
                       order_id
                      , event_dt
                      , company_code
                      , country_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM temp_products ) ) )
                           AS prod_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , 50 ) )
                           AS set_quantity
                   FROM tmp_orders) temp_orders
              , temp_companies
              , temp_products
              , (SELECT ROWNUM AS country_id
                      , country_desc
                   FROM u_dw_references.lc_countries) temp_cntr
          WHERE temp_orders.company_code = temp_companies.company_code
            AND temp_orders.prod_id = temp_products.prod_id
            AND temp_orders.country_id = temp_cntr.country_id;

      COMMIT;
   END LOOP;
END;
	