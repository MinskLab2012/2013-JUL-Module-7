/* Formatted on 04.08.2013 14:36:55 (QP5 v5.139.911.3011) */
DECLARE
   TYPE code_ins IS REF CURSOR;

   CURSOR upd
   IS
       SELECT DISTINCT sort_code
                    , sort_name
                    , tc.category_desc as cat_desc
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
      EXIT WHEN prod_ins%NOTFOUND;
   END LOOP;



   COMMIT;

   CLOSE prod_ins;

FOR rec_upd IN upd LOOP
CASE WHEN rec_upd.sort_name != rec_upd.cat_desc
THEN UPDATE u_stg.lc_prod_categories
               SET category_desc = rec_upd.sort_name, update_dt = sysdate
               WHERE category_code = rec_upd.sort_code;
          
               ELSE CONTINUE;
               END CASE;
END LOOP;

COMMIT;

end;