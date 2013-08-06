BEGIN
   --pkg_load_ext_products.load_cursor_prod_categories;  --procedure that use explicit cursor
   pkg_load_ext_products.load_merge_prod_categories; --procedure that use merge
   pkg_load_ext_products.load_cursor_prod_subcategories;
   pkg_load_ext_products.load_cursor_bulk_products;

   pkg_load_ext_payment_systems.load_cursor_ps_types;
   pkg_load_ext_payment_systems.load_cursor_payment_systems;
   
   pkg_load_ext_customers.load_to_refcursor_customers; -- load using native cursor converted from dynamic (to_refcursor function)
   --pkg_load_ext_customers.load_to_cursor_num_customers; -- load using  dynamic cursor converted from native (to_cursor_number function)
 
   pkg_load_ext_delivery_systems.load_ic_delivery_systems;

   pkg_load_ext_transactions.load_bulk_insert_transactions;
END;


