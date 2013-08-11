/* Formatted on 02.08.2013 21:10:36 (QP5 v5.139.911.3011) */
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
 , order_code     NUMBER ( 10 )
 , country_code   VARCHAR2 ( 20 )
 , country_desc   VARCHAR2 ( 70 )
 , company_code   VARCHAR2 ( 20 )
 , company_name   VARCHAR2 ( 70 )
 , comp_country_code VARCHAR2 ( 20 )
 , comp_country_desc VARCHAR2 ( 70 )
 , comp_status_code VARCHAR ( 20 )
 , comp_status    VARCHAR2 ( 50 )
 , product_code   VARCHAR2 ( 15 )
 , product_name   VARCHAR2 ( 50 )
 , sort_code      VARCHAR2 ( 15 )
 , sort_name      VARCHAR2 ( 50 )
 , measure_code   VARCHAR2 ( 15 )
 , measure        VARCHAR2 ( 50 )
 , quantity       NUMBER ( 10, 2 )
 , price          NUMBER ( 15, 2 )
 , set_quantity   NUMBER ( 10 )
 , total_price    NUMBER ( 30, 2 )
)
TABLESPACE ts_references_ext_data_01;

BEGIN
   FOR c IN 1 .. 110 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO t_orders
         SELECT DISTINCT event_dt
                       , order_code
                       , temp_cntr.country_code
                       , temp_cntr.country_desc
                       , tmp_companies.company_code
                       , tmp_companies.company_name
                       , tmp_companies.country_code AS comp_country_code
                       , tmp_companies.country_desc AS comp_country_desc
                       , tmp_companies.comp_status_code
                       , comp_status
                       , tmp_products.product_code
                       , product_name
                       , tmp_products.sort_code
                       , sort_name
                       , tmp_products.measure_code
                       , measure
                       , tmp_products.quantity
                       , price
                       , set_quantity
                       , ROUND ( (  set_quantity
                                  * price
                                  * dbms_random.VALUE ( 1
                                                      , 1.311 ) )
                               , 2 )
                            AS total_price
           FROM (SELECT --+NO_MERGE
                       order_code
                      , event_dt
                      , company_id
                      , country_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , ( SELECT COUNT ( * )
                                                        FROM cls_products ) ) )
                           AS prod_id
                      , ROUND ( dbms_random.VALUE ( 1
                                                  , 50 ) )
                           AS set_quantity
                   FROM cls_orders) temp_orders
              , (SELECT ROWNUM AS comp_id
                      , company_code
                      , company_name
                      , country_code
                      , country_desc
                      , comp_status_code
                      , comp_status
                   FROM cls_companies) tmp_companies
              , (SELECT ROWNUM AS prod_id
                      , product_code
                      , product_name
                      , sort_code
                      , sort_name
                      , measure_code
                      , measure
                      , quantity
                      , price
                   FROM cls_products) tmp_products
              , (SELECT ROWNUM AS country_id
                      , country_desc
                      , country_code_a3 AS country_code
                   FROM u_dw_references.lc_countries) temp_cntr
          WHERE temp_orders.company_id = tmp_companies.comp_id
            AND temp_orders.prod_id = tmp_products.prod_id
            AND temp_orders.country_id = temp_cntr.country_id
            ORDER BY country_code NULLS FIRST
            ;


      COMMIT;
   END LOOP;
END;

SELECT count( *)
  FROM t_orders;
  
