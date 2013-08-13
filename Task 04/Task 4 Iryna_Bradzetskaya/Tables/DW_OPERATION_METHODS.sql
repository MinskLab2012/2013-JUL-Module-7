alter table DW_OPERATIONS
   drop constraint FK_OPERATIO_REFERENCE_OPERATIO;

drop table DW_OPERATION_METHODS cascade constraints;

/*==============================================================*/
/* Table: OPERATION_METHODS                                     */
/*==============================================================*/
create table DW_OPERATION_METHODS 
(
   operation_method_id NUMBER               not null,
   operation_method_name varchar(50),
   operation_method_type varchar(50),
   operation_method_type_id NUMBER,
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_OPERATION_METHODS primary key (operation_method_id)
);