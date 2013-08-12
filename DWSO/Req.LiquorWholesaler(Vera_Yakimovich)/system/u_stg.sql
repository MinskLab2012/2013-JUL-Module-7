/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     01.08.2013 13:16:22                          */

/*==============================================================*/


/*==============================================================*/

/* User: "U_STG"                                                */

/*==============================================================*/
DROP USER u_stg CASCADE;
CREATE USER "U_STG"
  IDENTIFIED BY "12345678"
    DEFAULT TABLESPACE ts_stg_data_01;


GRANT CONNECT,CREATE VIEW,RESOURCE TO "U_STG";
ALTER USER u_stg QUOTA UNLIMITED ON ts_stg_data_01;

/