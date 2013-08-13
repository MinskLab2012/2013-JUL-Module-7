create or replace procedure
truncate_dim_times
as
begin
execute immediate 'truncate table DIM_TIMES';
end truncate_dim_times;

grant execute on truncate_dim_times to st_data;