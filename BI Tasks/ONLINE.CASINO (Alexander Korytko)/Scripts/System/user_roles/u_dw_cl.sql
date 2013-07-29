drop user "u_dw_cl";

/*==============================================================*/
/* User: "u_dw_cl"                                              */
/*==============================================================*/
create user "U_DW_CL" 
  identified by "%PWD%";

grant CONNECT,CREATE ANY TABLE, SELECT ANY TABLE, CREATE ANY VIEW,RESOURCE to "U_DW_CL";

ALTER USER U_DW_CL default TABLESPACE TS_DW_CL quota unlimited on TS_DW_CL;