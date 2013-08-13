/* Formatted on 12.08.2013 23:30:27 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PROCEDURE load_dim_products
AS
BEGIN
merge into sal_star.dim_products dp
using (SELECT PROD_ID,
       PROD_CODE,
       PROD_DESC,
       prod_subcategories.PROD_SUBCATEGORY_ID,
       prod_subcategory AS PROD_SUBCATEGORY_CODE,
       PROD_SUBCATEGORY_DESC,
       prod_categories.PROD_CATEGORY_ID,
       prod_category AS PROD_CATEGORY_CODE,
       PROD_CATEGORY_DESC
  FROM products
       JOIN prod_subcategories
          ON products.prod_subcategory_id =
                prod_subcategories.prod_subcategory_id
       JOIN prod_categories
          ON prod_subcategories.prod_category_id =
                prod_categories.prod_category_id) std
                on (dp.prod_id = std.prod_id)
                when not matched then insert
                ( PROD_ID,
       PROD_CODE,
       PROD_DESC,
      PROD_SUBCATEGORY_ID,
       PROD_SUBCATEGORY_CODE,
       PROD_SUBCATEGORY_DESC,
       PROD_CATEGORY_ID,
       PROD_CATEGORY_CODE,
       PROD_CATEGORY_DESC, insert_dt)
       values  (std.PROD_ID,
       std.PROD_CODE,
       std.PROD_DESC,
      std.PROD_SUBCATEGORY_ID,
       std.PROD_SUBCATEGORY_CODE,
       std.PROD_SUBCATEGORY_DESC,
       std.PROD_CATEGORY_ID,
       std.PROD_CATEGORY_CODE,
       std.PROD_CATEGORY_DESC, sysdate)
       when matched then update
       set prod_code = std.prod_code, prod_desc = std.prod_desc;
   COMMIT;
END load_dim_products;

BEGIN
   load_dim_products;
END;

