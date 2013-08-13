-- DROP TABLESPACE ts_st_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS

-- DROP TABLESPACE ts_star_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS

create tablespace ts_st_data_01 datafile 'st_data_001.dat' size 50M autoextend on next 10M maxsize 200M;

create tablespace ts_star_01 datafile 'star_001.dat' size 100M autoextend on next 50M maxsize 500M;
