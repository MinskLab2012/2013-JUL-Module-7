create or replace package pkg_load_ext_customers
as 
procedure load_to_refcursor_customers;
procedure load_to_cursor_num_customers;
end;