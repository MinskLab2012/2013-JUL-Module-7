ALTER TABLE DW_OPERATIONS
add CONSTRAINT PK_OPERATIO PRIMARY KEY (operation_id);


alter table DW_CURRENCY
   drop constraint FK_CURRENCY_REFERENCE_CURRENCY;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_CURRENCY;

alter table currency_actions
   drop constraint FK_CURRENCY_REFERENCE_CURRENCY;

drop table DW_CURRENCY cascade constraints;

/*==============================================================*/
/* Table: DW_CURRENCY                                              */
/*==============================================================*/
create table DW_CURRENCY 
(
   currency_id        NUMBER               not null,
   currency_type_id   NUMBER,
   currency_to_dollar NUMBER,
   currency_name      VARCHAR2(20),
   currency_code      NUMBER,
   currency_desc      varchar(20),
   constraint PK_CURRENCY primary key (currency_id)
);

alter table DW_CURRENCY
   add constraint FK_CURRENCY_REFERENCE_CURRENC foreign key (currency_type_id)
      references DW_CURRENCY_TYPES (currency_type_id);


alter table  dw_CURRENCY
   add constraint FK_CURRENCY_ACTION_TYPES foreign key (CURRENCY_TYPE_ID)
      references DW_CURRENCY_TYPES (CURRENCY_TYPE_ID);