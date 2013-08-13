alter table DW_OPERATIONS
   drop constraint FK_OPERATIO_REFERENCE_OPERATIO;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_OPERATIO;

drop table DW_OPERATIONS cascade constraints;

/*==============================================================*/
/* Table: OPERATIONS                                            */
/*==============================================================*/
CREATE TABLE dw_operations
(
   operation_id   NUMBER
 , operation_code NUMBER
 , operation_name VARCHAR2 ( 50 )
 , operation_method_id NUMBER
 , operation_max_amount NUMBER
 , operation_min_amount NUMBER
 , insert_dt      DATE
 , update_dt      DATE
);

alter table DW_OPERATIONS
   add constraint FK_OPERATIO_REFERENCE_OPERATIO foreign key (operation_method_id)
      references DW_OPERATION_METHODS (operation_method_id);



ALTER TABLE DW_OPERATIONS
add CONSTRAINT PK_OPERATIO PRIMARY KEY (operation_id);