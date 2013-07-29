--drop user u_sa_data;

--==============================================================
-- User: u_sa_data                                              
--==============================================================
create user u_sa_data 
  identified by "%PWD%"
    default tablespace TS_SA_DATA_01;

grant CONNECT,RESOURCE to u_sa_data;
