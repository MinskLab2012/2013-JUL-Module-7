drop table DIM_TARIFFS cascade constraints;

/*==============================================================*/
/* Table: DIM_TARIFFS                                               */
/*==============================================================*/
create table DIM_TARIFFS 
(
   tariff_id          NUMBER               not null,
   tariff_code        varchar(5)           not null,
   tariff_name        varchar(30),
   tariff_payment_sum NUMBER,
   tariff_type        char(30),
   tariff_min_payment NUMBER,
   tariff_max_payment NUMBER,
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_TARIFFS primary key (tariff_id)
);
