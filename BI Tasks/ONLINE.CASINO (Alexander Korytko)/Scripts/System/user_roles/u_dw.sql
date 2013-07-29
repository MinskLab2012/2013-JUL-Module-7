drop user "u_dw";

/*==============================================================*/
/* User: "u_dw"                                                 */
/*==============================================================*/
create user "U_DW" 
  identified by "%PWD%";

grant CONNECT,CREATE ANY TABLE, SELECT ANY TABLE, CREATE ANY VIEW,RESOURCE to "U_DW";

ALTER USER U_DW default TABLESPACE TS_DW_DATA_01 quota unlimited on TS_DW_DATA_01;