drop table DIM_CURRENCY_SCD;

/*==============================================================*/
/* Table: DIM_CURRENCY_SCD                                      */
/*==============================================================*/
create table DIM_CURRENCY_SCD 
(
   currency_sur_id      NUMBER                         not null,
   currency_type_id     NUMBER                         null,
   currency_desc        varchar(30)                    null,
   currency_name        varchar(10)                    null,
   currency_code        NUMBER                         null,
   currency_to_dollar   NUMBER                         null,
   currency_type_desc   varchar(50)                    null,
   valid_to             date                           null,
   valid_from           date                           null,
   constraint PK_DIM_CURRENCY_SCD primary key (currency_sur_id)
);