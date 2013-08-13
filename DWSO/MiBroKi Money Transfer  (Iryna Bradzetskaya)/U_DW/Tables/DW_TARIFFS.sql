alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_TARIFFS;

drop table DW_TARIFFS cascade constraints;

/*==============================================================*/
/* Table: DW_TARIFFS                                                */
/*==============================================================*/
create table DW_TARIFFS 
(
   tariff_id          NUMBER               not null,
   tariff_code        varchar(5)           ,
   tariff_name       varchar(30),
   tariff_payment_sum NUMBER,
   tariff_type        varchar(30),
   tariff_min_payment NUMBER,
   tariff_max_payment NUMBER,
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_TARIFFS primary key (tariff_id)
);