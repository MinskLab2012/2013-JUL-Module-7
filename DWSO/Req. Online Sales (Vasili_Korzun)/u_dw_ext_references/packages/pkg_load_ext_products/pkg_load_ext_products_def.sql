/* Formatted on 8/2/2013 1:17:57 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_load_ext_products
AS
   PROCEDURE load_cursor_prod_categories;
   procedure load_merge_prod_categories;
   PROCEDURE load_cursor_prod_subcategories;
   PROCEDURE load_cursor_bulk_products;
END;
/