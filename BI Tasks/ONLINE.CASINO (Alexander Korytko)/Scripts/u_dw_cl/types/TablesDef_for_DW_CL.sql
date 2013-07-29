-- DROP TABLE T_DW_CL_USERS
-- DROP TABLE T_DW_CL_TRANSACTIONS

-- SELECT * FROM u_dw_references.cu_countries
-- SELECT * FROM Alexander.GEO
-- SELECT * FROM T_DW_CL_USERS
-- SELECT * FROM T_DW_CL_TRANSACTIONS

CREATE TABLE T_DW_CL_USERS
(
  User_ID number default NULL,
  First_Name varchar2(255) default NULL,
  Last_Name varchar2(255) default NULL,
  Gender varchar2(255) default NULL,
  Year_Of_Birth varchar2(100) default NULL,
  User_Balance varchar2(50) default NULL,
  Country_ID number(32) default NULL,
  Marige_Status varchar2(255) default NULL
);

CREATE TABLE T_DW_CL_TRANSACTIONS
(
   TRANSACTION_ID number default NULL,
   EVENT_DT DATE,
   COUNTRY_ID number default NULL,
   USER_ID number default NULL,
   CURRENCY_ID number default NULL,
   CURRENCY_NAME varchar2(10) default NULL,
   AMOUNT number default NULL,
   OPERATION_TYPE_ID number default NULL,
   OPERATION_TYPE_NAME varchar2(32) default NULL,
   OPERATION_TYPE_METHOD_ID number default NULL,
   OPERATION_TYPE_METHOD_NAME varchar2(32) default NULL
 );  
 