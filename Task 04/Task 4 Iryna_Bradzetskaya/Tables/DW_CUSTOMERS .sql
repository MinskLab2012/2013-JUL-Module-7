alter table DW_CUSTOMERS
   drop constraint FK_CUSTOMER_REFERENCE_T_GEO_OB;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_CUSTOMER;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_CUSTOMER;

drop table DW_CUSTOMERS cascade constraints;

/*==============================================================*/
/* Table: DW_CUSTOMERS                                             */
/*==============================================================*/
create table DW_CUSTOMERS 
(
   cust_id            NUMBER               not null,
   cust_geo_id        NUMBER(22,0),
   cust_first_name    varchar(30),
   cust_last_name     varchar(30),
   cust_gender        varchar(1),
   cust_year_of_birth DATE,
   cust_email         varchar(40),
   cust_balance       NUMBER,
   cust_level_income  NUMBER,
   CUST_PASS_NUMBER     VARCHAR2(15),
   update_dt          DATE,
   insert_dt          date,   
   constraint PK_CUSTOMERS primary key (cust_id)
);

comment on column DW_CUSTOMERS.cust_geo_id is
'Unique ID for All Geography objects';

alter table DW_CUSTOMERS
   add constraint FK_CUSTOMER_REFERENCE_T_GEO_OB foreign key (cust_geo_id)
      references u_dw_references.t_geo_objects (geo_id);

