/*==============================================================*/
/* Table: DW_currency_actions                                   */
/*==============================================================*/
alter table DW_currency_actions
   drop constraint FK_CURRENCY_REFERENCE_CURRENCY;

alter table DW_currency_actions
   drop constraint FK_CURRENCY_REFERENCE_CURRENCY;

drop table DW_currency_actions cascade constraints;

/*==============================================================*/
/* Table: DW_currency_actions                                 */
/*==============================================================*/
create table DW_currency_actions 
(
   currency_action_id NUMBER               not null,
   currency_action_type_id NUMBER(4,0),
   currency_id        NUMBER,
   action_date        DATE,
   value_old          NUMBER,
   value_new          NUMBER,
   constraint PK_CURRENCY_ACTIONS primary key (currency_action_id)
);


alter table dw_currency_actions
   add constraint FK_CURRENCY_REFERENCE foreign key (currency_action_type_id)
      references dw_currency_action_types (action_type_id);

alter table dw_currency_actions
   add constraint FK_CURRENCY_REFERENCE_CURRENCY foreign key (currency_id)
      references dw_CURRENCY (currency_id);