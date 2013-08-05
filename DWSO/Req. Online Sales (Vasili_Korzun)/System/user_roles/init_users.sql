-- drop user st_data;
-- drop user sal_cl;
create user st_data identified by st_data default tablespace  ts_st_data_01;
grant connect, resource to st_data;
alter user st_data quota unlimited on ts_st_data_01;

create user sal_cl identified by sal_cl default tablespace ts_star_cl_01;
grant connect, resource to sal_cl;
alter user sal_cl quota unlimited on ts_star_cl_01;

