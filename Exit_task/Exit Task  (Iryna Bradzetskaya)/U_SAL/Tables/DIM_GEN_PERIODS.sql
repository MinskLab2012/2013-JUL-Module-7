drop table DIM_GEN_PERIODS;

/*==============================================================*/
/* Table: DIM_GEN_PERIODS                                       */
/*==============================================================*/
create table DIM_GEN_PERIODS 
(
   period_id            NUMBER                         not null,
   period_desc          varchar(10)                    null,
   period_val           NUMBER                         null,
   period_start_num     NUMBER                         null,
   period_end_num       NUMBER                         null,
   period_start_date    date                           null,
   period_end_date      date                           null,
    insert_dt            date                           null,
   update_dt            date                           null,
   constraint PK_DIM_GEN_PERIODS primary key  (period_id)
);
