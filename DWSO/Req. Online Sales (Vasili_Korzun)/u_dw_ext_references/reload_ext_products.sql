/* Formatted on 8/2/2013 1:11:24 PM (QP5 v5.139.911.3011) */
BEGIN
   --pkg_load_ext_products.load_cursor_prod_categories;  --procedure that use explicit cursor
   pkg_load_ext_products.load_merge_prod_categories;  --procedure that use merge
   pkg_load_ext_products.load_cursor_prod_subcategories;
   pkg_load_ext_products.load_cursor_bulk_products;
END;

