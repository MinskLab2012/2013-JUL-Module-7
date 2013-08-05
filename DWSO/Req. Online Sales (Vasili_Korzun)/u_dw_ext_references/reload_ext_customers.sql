begin
--2 variants of loading customers (5 task ETL labs)
pkg_load_ext_customers.load_to_refcursor_customers; 
--pkg_load_ext_customers.load_to_cursor_num_customers;
end;