drop table DIM_CUSTOMERS;

/*==============================================================*/
/* Table: DIM_CUSTOMERS                                         */
/*==============================================================*/
create table DIM_CUSTOMERS 
(
   cust_id              NUMBER                         not null,
   cust_first_name      varchar(30)                    null,
   cust_last_name       varchar(30)                    null,
   cust_gender          varchar(1)                     null,
   cust_year_of_birth   DATE                         null,
   cust_geo_id          NUMBER                         null,
   cust_level_income    NUMBER                    null,
   cust_email           varchar(50)                    null,
   cust_balance         NUMBER                         null,
   cust_pass_number     varchar(30)                    null,
   insert_dt            date                           null,
   update_dt            date                           null,
   constraint PK_DIM_CUSTOMERS primary key (cust_id)
);