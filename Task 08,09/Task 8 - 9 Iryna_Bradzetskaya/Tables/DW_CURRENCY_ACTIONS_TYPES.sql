alter table dw_currency_actions
   drop constraint FK_CURRENCY_REFERENCE_CURRENCY;

drop table dw_currency_action_types cascade constraints;

/*==============================================================*/
/* Table: "currency_action_types"                               */
/*==============================================================*/
create table dw_currency_action_types 
(
  action_type_id     NUMBER(4,0)          not null,
  action_type_desc   VARCHAR(36),
   constraint PK_CURRENCY_ACTION_TYPES primary key (action_type_id)
);