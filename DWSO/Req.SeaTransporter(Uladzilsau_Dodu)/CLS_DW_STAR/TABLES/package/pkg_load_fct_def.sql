create or replace package pkg_load_fct
as
procedure load_FCT_200X(year in date, var_par in varchar2);
end;