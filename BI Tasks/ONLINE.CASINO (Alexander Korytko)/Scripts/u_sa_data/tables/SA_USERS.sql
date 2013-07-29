DROP TABLE T_SA_USERS;

CREATE TABLE T_SA_USERS (
   User_ID number default NULL,
  First_Name varchar2(255) default NULL,
  Last_Name varchar2(255) default NULL,
  Gender varchar2(255) default NULL,
  Year_Of_Birth varchar2(100) default NULL,
  User_Balance varchar2(50) default NULL,
  Email varchar2(255) default NULL,
  Country_ID varchar2(50) default NULL,
  Marige_Status varchar2(255) default NULL
);