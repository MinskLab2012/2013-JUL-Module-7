create or replace procedure disable_constraints
as
begin
execute immediate 'alter table fct_sales_dd disable constraint FK_FCT_SALES_DS';
execute immediate 'alter table fct_sales_dd disable constraint  FK_FCT_SALES_PS';
execute immediate 'alter table fct_sales_dd disable constraint FK_FCT_SALES_PRODS';
execute immediate 'alter table fct_sales_dd disable constraint  FK_FCT_SALES_GEO';
end;

create or replace procedure enable_constraints
as
begin
execute immediate 'alter table fct_sales_dd enable constraint FK_FCT_SALES_DS';
execute immediate 'alter table fct_sales_dd enable constraint  FK_FCT_SALES_PS';
execute immediate 'alter table fct_sales_dd enable constraint FK_FCT_SALES_PRODS';
execute immediate 'alter table fct_sales_dd enable constraint  FK_FCT_SALES_GEO';
end;

grant execute on disable_constraints to st_data;
grant execute on enable_constraints to st_data;
