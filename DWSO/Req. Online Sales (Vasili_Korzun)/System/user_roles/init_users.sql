-- drop user st_data;
--drop user sal_star;
create user st_data identified by st_data default tablespace  ts_st_data_01;
grant connect, resource to st_data;
grant create view to st_data;
alter user st_data quota unlimited on ts_st_data_01;

create user sal_star identified by sal_star default tablespace ts_star_01;
grant connect, resource to sal_star;
alter user sal_star quota unlimited on ts_star_01;

