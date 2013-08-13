drop table DIM_OPERATIONS;

/*==============================================================*/
/* Table: DIM_OPERATIONS                                        */
/*==============================================================*/
create table DIM_OPERATIONS 
(
   operation_id         NUMBER                         not null,
   operation_name       varchar(50)                    null,
   operation_method_id  NUMBER                         null,
   operation_method_name varchar(30)                    null,
   operation_method_type varchar(50)                    null,
   operation_method_type_id NUMBER                         null,
   operation_min_amount NUMBER                         null,
   operation_max_amount NUMBER                         null,
   insert_dt            date                           null,
   update_dt            date                           null,
   constraint PK_DIM_OPERATIONS primary key (operation_id)
);
