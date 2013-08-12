/* Formatted on 12.08.2013 13:29:49 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY prod_load
AS
   PROCEDURE ins_upd
   AS
      TYPE t_code IS TABLE OF t_orders.product_code%TYPE;

      TYPE t_name IS TABLE OF t_orders.product_name%TYPE;

      TYPE t_price IS TABLE OF t_orders.price%TYPE;

      TYPE t_quant IS TABLE OF t_orders.quantity%TYPE;

      TYPE t_sort IS TABLE OF u_stg.t_products.prod_category_id%TYPE;

      TYPE t_meas IS TABLE OF u_stg.t_products.measure_id%TYPE;

      tab_code       t_code;
      tab_name       t_name;
      tab_price      t_price;
      tab_sort       t_sort;
      tab_meas       t_meas;
      tab_quant      t_quant;

      CURSOR upd
      IS
         SELECT product_code
              , lc.product_name
           FROM u_stg.lc_products lc
         MINUS
         SELECT DISTINCT tor.product_code
                       , tor.product_name
           FROM t_orders tor;



      TYPE type_cur IS REF CURSOR;

      ref_cur        type_cur;
   BEGIN
      OPEN ref_cur FOR
         SELECT tor.product_code
              , tor.product_name
              , tor.price
              , ( SELECT prod_category_id
                    FROM u_stg.t_prod_category
                   WHERE category_code = tor.sort_code )
                   AS prod_id
              , ( SELECT measure_id
                    FROM u_stg.t_measures
                   WHERE measure_code = tor.measure_code )
                   AS meas_id
              , quantity
           FROM (  SELECT tor.product_code
                        , MAX ( tor.product_name ) AS product_name
                        , MAX ( tor.price ) AS price
                        , MAX ( tor.sort_code ) AS sort_code
                        , MAX ( tor.measure_code ) AS measure_code
                        , MAX ( quantity ) AS quantity
                     FROM t_orders tor
                    WHERE product_code IN (SELECT DISTINCT tor.product_code
                                             FROM t_orders tor
                                           MINUS
                                           SELECT product_code
                                             FROM u_stg.t_products)
                 GROUP BY product_code) tor;


      LOOP
         FETCH ref_cur
         BULK COLLECT INTO tab_code, tab_name, tab_price, tab_sort, tab_meas, tab_quant
         LIMIT 1000;

         FORALL i IN 1 .. tab_code.COUNT
            INSERT ALL
              INTO u_stg.t_products
            VALUES ( u_stg.sq_prod_id.NEXTVAL
                   , tab_code ( i )
                   , tab_sort ( i )
                   , tab_meas ( i )
                   , tab_quant ( i )
                   , tab_price ( i )
                   , SYSDATE
                   , '' )
              INTO u_stg.lc_products
            VALUES ( u_stg.sq_prod_id.CURRVAL
                   , tab_name ( i )
                   , tab_code ( i )
                   , 1
                   , SYSDATE
                   , '' )
               SELECT tab_code ( i )
                    , tab_name ( i )
                    , tab_sort ( i )
                    , tab_meas ( i )
                    , tab_quant ( i )
                    , tab_price ( i )
                    , SYSDATE
                 FROM DUAL;

         COMMIT;
         EXIT WHEN ref_cur%NOTFOUND;
      END LOOP;

      COMMIT;

      CLOSE ref_cur;

      OPEN upd;

      LOOP
         FETCH upd
         BULK COLLECT INTO tab_code, tab_name
         LIMIT 1000;

         FORALL j IN 1 .. tab_code.COUNT
            UPDATE u_stg.lc_products
               SET product_name = tab_name ( j )
                 , update_dt    = SYSDATE
             WHERE product_code = tab_code ( j );

         EXIT WHEN upd%NOTFOUND;
      END LOOP;

      CLOSE upd;


      COMMIT;
   END ins_upd;

   PROCEDURE prod_categ_load
   AS
      TYPE code_ins IS REF CURSOR;

      CURSOR upd
      IS
         SELECT DISTINCT sort_code
                       , sort_name
                       , tc.category_desc AS cat_desc
           FROM t_orders INNER JOIN u_stg.lc_prod_categories tc ON t_orders.sort_code = tc.category_code;


      prod_ins       code_ins;


      TYPE code_t IS TABLE OF t_orders.sort_code%TYPE;

      TYPE desc_t IS TABLE OF t_orders.sort_name%TYPE;

      bulk_code      code_t;
      bulk_desc      desc_t;
      bulk_lc_desc   desc_t;
   BEGIN
      OPEN prod_ins FOR
         SELECT DISTINCT sort_code
                       , sort_name
           FROM t_orders
          WHERE sort_code IN (SELECT DISTINCT sort_code
                                FROM t_orders
                              MINUS
                              SELECT category_code
                                FROM u_stg.t_prod_category);

      LOOP
         FETCH prod_ins
         BULK COLLECT INTO bulk_code, bulk_desc;

         EXIT WHEN prod_ins%NOTFOUND;

         FOR i IN bulk_code.FIRST .. bulk_code.LAST LOOP
            INSERT INTO u_stg.t_prod_category
               SELECT u_stg.sq_prod_categ_id.NEXTVAL
                    , bulk_code ( i )
                    , SYSDATE
                    , NULL
                 FROM DUAL;

            INSERT INTO u_stg.lc_prod_categories
               SELECT u_stg.sq_prod_categ_id.CURRVAL
                    , bulk_code ( i )
                    , bulk_desc ( i )
                    , 1
                    , SYSDATE
                    , ''
                 FROM DUAL;
         END LOOP;
      END LOOP;



      COMMIT;

      CLOSE prod_ins;

      FOR rec_upd IN upd LOOP
         CASE
            WHEN rec_upd.sort_name != rec_upd.cat_desc THEN
               UPDATE u_stg.lc_prod_categories
                  SET category_desc = rec_upd.sort_name
                    , update_dt    = SYSDATE
                WHERE category_code = rec_upd.sort_code;
            ELSE
               CONTINUE;
         END CASE;
      END LOOP;

      COMMIT;
   END prod_categ_load;


   PROCEDURE measure_load
   AS
      TYPE t_code IS TABLE OF t_orders.measure_code%TYPE;

      TYPE t_name IS TABLE OF t_orders.measure%TYPE;

      TYPE t_quant IS TABLE OF t_orders.quantity%TYPE;



      tab_code       t_code;
      tab_name       t_name;
      tab_quant      t_quant;

      CURSOR ins
      IS
         SELECT DISTINCT tor.measure_code
                       , tor.measure
                       , tor.quantity
           FROM t_orders tor
         MINUS
         SELECT measure_code
              , measure_desc
              , quantity
           FROM u_stg.t_measures;
   BEGIN
      OPEN ins;


      LOOP
         FETCH ins
         BULK COLLECT INTO tab_code, tab_name, tab_quant;


         FORALL i IN 1 .. tab_code.COUNT
         MERGE INTO u_stg.t_measures USING (SELECT tab_code(i), tab_name(i), tab_quant(i) FROM DUAL)
         ON (t_measures.measure_code = tab_code(i))
         WHEN NOT MATCHED THEN
         INSERT VALUES (u_stg.sq_prod_id.NEXTVAL, tab_code(i), tab_name(i), SYSDATE, '', tab_quant(i))
         WHEN MATCHED THEN
         UPDATE SET measure_desc = tab_name(i), update_dt = SYSDATE, quantity = tab_quant(i) WHERE t_measures.measure_code = tab_code(i);

         COMMIT;
         EXIT WHEN ins%NOTFOUND;
      END LOOP;

      COMMIT;

      CLOSE ins;
   END measure_load;
END prod_load;
/