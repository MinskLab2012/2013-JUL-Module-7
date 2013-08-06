/* Formatted on 8/2/2013 1:08:07 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_products
AS
-- Explicit cursor
 PROCEDURE load_cursor_prod_categories
   AS
      CURSOR cur_pc
      IS
         SELECT /*+ parallel(cls 4) */
               DISTINCT st.prod_category_id AS prod_category_id
                      , cls.prod_category
                      , cls.prod_category_desc
           FROM tmp_orders cls --cls_products cls
                              LEFT JOIN st_data.prod_categories st ON st.prod_category = cls.prod_category;

      cnt_rows_processed PLS_INTEGER;
   BEGIN
      cnt_rows_processed := 0;

      FOR pc IN cur_pc LOOP
         cnt_rows_processed := cnt_rows_processed + 1;

         IF pc.prod_category_id IS NOT NULL THEN
            UPDATE st_data.prod_categories st
               SET st.prod_category = pc.prod_category
                 , st.prod_category_desc = pc.prod_category_desc
                 , st.update_dt = SYSDATE
             WHERE st.prod_category_id = pc.prod_category_id
               AND TRIM ( st.prod_category_desc ) != TRIM ( pc.prod_category_desc );
         ELSIF pc.prod_category_id IS NULL THEN
            cnt_rows_processed := 0;

            INSERT INTO st_data.prod_categories ( prod_category_id
                                                , prod_category
                                                , prod_category_desc
                                                , insert_dt
                                                , localization_id )
                 VALUES ( st_data.prod_categories_seq.NEXTVAL
                        , pc.prod_category
                        , pc.prod_category_desc
                        , SYSDATE
                        , 1 );
         ELSE
            EXIT;
         END IF;

         IF cnt_rows_processed >= 100 THEN
            COMMIT;
            cnt_rows_processed := 0;
         END IF;
      END LOOP;

      COMMIT;
   END;
   
   
  -- merge
   PROCEDURE load_merge_prod_categories
AS
BEGIN
   MERGE INTO st_data.prod_categories mst
        USING 
        (SELECT /*+ parallel(cls 4)*/  DISTINCT
             st.prod_category_id AS prod_category_id,
             cls.prod_category,
             cls.PROD_CATEGORY_DESC
        FROM  tmp_orders cls
             LEFT JOIN
                st_data.PROD_CATEGORIES st
             ON st.prod_category = cls.prod_category) cls
           ON (                  mst.prod_category_id  = cls.prod_category_id 
               and TRIM (mST.PROD_CATEGORY)  = TRIM (cls.prod_category)
              )
   WHEN MATCHED
   THEN
      UPDATE SET
         mst.prod_category_desc = cls.prod_category_desc,
         mst.update_dt = SYSDATE
         where mst.prod_category_desc != cls.prod_category_desc
   WHEN NOT MATCHED
   THEN
      INSERT            (prod_category_id,
                         prod_category,
                         prod_category_desc,
                         insert_dt,
                         localization_id)
          VALUES (st_data.prod_categories_seq.NEXTVAL,
                  cls.prod_category,
                  cls.prod_category_desc,
                  SYSDATE,
                  1);
   COMMIT;
END;

/*
select st.prod_subcategory_id AS p_id
                      , cls.prod_subcategory
                      , cls.prod_subcategory_desc
                      , cls.prod_category_id from
(
select distinct  cls.prod_subcategory, cls.prod_subcategory_desc, st_pc.prod_category_id from tmp_orders cls
left join st_data.prod_categories st_pc
                   ON st_pc.prod_category = cls.prod_category
)cls
 join ST_DATA.PROD_SUBCATEGORIES st
on st.prod_subcategory = cls.prod_subcategory
and cls.prod_category_id = st.prod_category_id
 ;
*/




-- Explicit cursor
   PROCEDURE load_cursor_prod_subcategories
   AS
      CURSOR cur_spc
      IS
         SELECT /*+ parallel(cls 4) */
               DISTINCT st.prod_subcategory_id AS p_id
                      , cls.prod_subcategory
                      , cls.prod_subcategory_desc
                      , st_pc.prod_category_id
           FROM tmp_orders cls --cls_products cls
                LEFT JOIN st_data.prod_subcategories st
                   ON st.prod_subcategory = cls.prod_subcategory
                LEFT JOIN st_data.prod_categories st_pc
                   ON st_pc.prod_category = cls.prod_category;

      cnt_rows_processed PLS_INTEGER;
   BEGIN
      cnt_rows_processed := 0;

      FOR pc IN cur_spc LOOP
         cnt_rows_processed := cnt_rows_processed + 1;

         IF pc.p_id IS NOT NULL THEN
            UPDATE st_data.prod_subcategories st
               SET st.prod_category_id = pc.prod_category_id
                 , st.prod_subcategory_desc = pc.prod_subcategory_desc
                 , st.update_dt = SYSDATE
             WHERE st.prod_subcategory_id = pc.p_id
               AND (TRIM ( st.prod_subcategory_desc ) != TRIM ( pc.prod_subcategory_desc )
                 and  NVL ( st.prod_category_id, 0 ) != NVL ( pc.prod_category_id, 0 ) );
         ELSIF pc.p_id IS NULL THEN
            cnt_rows_processed := 0;

            INSERT INTO st_data.prod_subcategories ( prod_subcategory_id
                                                   , prod_subcategory
                                                   , prod_subcategory_desc
                                                   , prod_category_id
                                                   , insert_dt
                                                   , localization_id )
                 VALUES ( st_data.prod_subcategories_seq.NEXTVAL
                        , pc.prod_subcategory
                        , pc.prod_subcategory_desc
                        , pc.prod_category_id
                        , SYSDATE
                        , 1 );
         ELSE
            EXIT;
         END IF;

         IF cnt_rows_processed >= 100 THEN
            COMMIT;
            cnt_rows_processed := 0;
         END IF;
      END LOOP;

      COMMIT;
   END;

-- Explicit cursor and bulk insert/update
PROCEDURE load_cursor_bulk_products
AS
   CURSOR cur_p
   IS
      SELECT --+ parallel(cls 4) 
            DISTINCT st_p.prod_id AS p_id,
                    cls.prod_name
                   , st_psc.prod_subcategory_id
        FROM tmp_orders cls
             LEFT JOIN st_data.prod_subcategories st_psc
                ON st_psc.prod_subcategory = cls.prod_subcategory
             left JOIN st_data.products st_p
               ON st_p.prod_code = cls.prod_name;

   TYPE prod_array IS TABLE OF cur_p%ROWTYPE;

   insert_data    prod_array; -- table for rows that should be inserted
   update_data    prod_array; -- table for rows that should be updated
BEGIN
   insert_data := prod_array ( );
   update_data := prod_array ( );

   -- dividing rows in two groups: needed to be inserted and needed to be updated;
   FOR pc IN cur_p LOOP
      IF pc.p_id IS NULL THEN
         insert_data.EXTEND;
         insert_data ( insert_data.LAST ) := pc;
      ELSIF pc.p_id IS NOT NULL THEN
         update_data.EXTEND;
         update_data ( update_data.LAST ) := pc;
      ELSE
         EXIT;
      END IF;
   END LOOP;

   --bulk insert
   FORALL i IN insert_data.FIRST .. insert_data.LAST
      INSERT INTO st_data.products ( prod_id
                                   , prod_code
                                   , prod_desc
                                   , prod_subcategory_id
                                   , insert_dt
                                   , localization_id )
           VALUES ( st_data.products_seq.NEXTVAL
                  , insert_data ( i ).prod_name
                  , insert_data ( i ).prod_name
                  , insert_data ( i ).prod_subcategory_id
                  , SYSDATE
                  , 1 );

   COMMIT;

   -- bulk update
   FORALL j IN update_data.FIRST .. update_data.LAST
      UPDATE st_data.products st
         SET st.prod_desc = update_data ( j ).prod_name
           , st.prod_subcategory_id = update_data ( j ).prod_subcategory_id
           , st.update_dt = SYSDATE
       WHERE  trim(st.prod_code) = trim(update_data ( j ).prod_name)
         AND ( st.prod_subcategory_id != update_data ( j ).prod_subcategory_id
           and  trim(st.prod_desc) != trim(update_data ( j ).prod_name) );

   COMMIT;
END;
END;
/

