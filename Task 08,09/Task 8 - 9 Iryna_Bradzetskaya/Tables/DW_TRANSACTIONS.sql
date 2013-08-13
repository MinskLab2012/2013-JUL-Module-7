alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_CUSTOMER;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_CUST_REC;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REF_T_GEO_OB_SEND;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REF_T_GEO_OB_SEND;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_CURRENCY;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_TARIFFS;

alter table DW_TRANSACTIONS
   drop constraint FK_TRANSACT_REFERENCE_OPERATIO;

drop table DW_TRANSACTIONS cascade constraints;

/*==============================================================*/
/* Table: DW_TRANSACTIONS                                          */
/*==============================================================*/
create table DW_TRANSACTIONS 
(
   transaction_id     NUMBER,
   trans_code     NUMBER,
   event_dt           DATE,
   currency_id        NUMBER,
   tariff_id          NUMBER,
   operation_id       NUMBER,
   cust_send_geo_id   NUMBER(22,0),
   cust_rec_geo_id    NUMBER(22,0),
   cust_send_id       NUMBER,
   cust_rec_id        NUMBER,
   payment_sum        NUMBER,
   insert_dt          DATE,
   constraint PK_TRANSACTIONS primary key (transaction_id)
);

comment on column DW_TRANSACTIONS.cust_send_geo_id is
'Unique ID for All Geography objects';

comment on column DW_TRANSACTIONS.cust_rec_geo_id is
'Unique ID for All Geography objects';

alter table DW_TRANSACTIONS
   add constraint FK_TRANSACT_REFERENCE_CUSTOMER foreign key (cust_send_id)
      references DW_CUSTOMERS (cust_id);

alter table DW_TRANSACTIONS
   add constraint FK_TRANSACT_REFERENCE_CUST_REC foreign key (cust_rec_id)
      references DW_CUSTOMERS (cust_id);

alter table DW_TRANSACTIONS
   add constraint FK_TRANSACT_REF_T_GEO_OB_SEND foreign key (cust_send_geo_id)
      references u_dw_references.t_geo_objects (geo_id);

alter table DW_TRANSACTIONS
   add constraint FK_TRANSACT_REF_T_GEO_OB_REC foreign key (cust_rec_geo_id)
      references u_dw_references.t_geo_objects (geo_id);

alter table DW_TRANSACTIONS
   add constraint FK_TRANSACT_REFERENCE_CURRENCY foreign key (currency_id)
      references DW_CURRENCY (currency_id);

alter table DW_TRANSACTIONS
   add constraint FK_TRANSACT_REFERENCE_TARIFFS foreign key (tariff_id)
      references DW_TARIFFS (tariff_id);

alter table DW_TRANSACTIONS
   add constraint FK_TRANSACT_REFERENCE_OPERATIO foreign key (operation_id)
      references DW_OPERATIONS (OPERATION_ID);
