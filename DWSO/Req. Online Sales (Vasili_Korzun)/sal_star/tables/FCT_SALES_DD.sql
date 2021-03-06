/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.08.2013 22:49:24                          */
/*==============================================================*/


/*==============================================================*/
/* Table: FCT_SALES_DD                                          */
/*==============================================================*/





alter table FCT_SALES_DD
   drop constraint FK_FCT_SALES_PERIODS;


alter table FCT_SALES_DD
   drop constraint FK_FCT_SALES_DS;

alter table FCT_SALES_DD
   drop constraint FK_FCT_SALES_PS;

alter table FCT_SALES_DD
   drop constraint FK_FCT_SALES_PRODS;

alter table FCT_SALES_DD
   drop constraint FK_FCT_SALES_GEO;
   
   drop table FCT_SALES_DD cascade constraints;
   drop sequence seq_fct_sales_dd;
create table FCT_SALES_DD 
(
   transaction_id     NUMBER(20)           not null,
   event_dt           DATE                 not null,
   geo_surr_id        NUMBER(6,0)          not null,
   prod_id            NUMBER(7,0)          not null,
   delivery_system_id NUMBER(4,0)          not null,
   period_surr_id     NUMBER(4,0),
   payment_system_surr_id NUMBER(5,0),
   quantity_sold      NUMBER(4,0)          not null,
   amount_sold        NUMBER(7,0)          not null,
   ta_geo_id          NUMBER(5,0),
   ta_payment_system_id NUMBER(4,0),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_FCT_SALES_DD primary key (transaction_id)
);

alter table FCT_SALES_DD
   add constraint FK_FCT_SALES_PERIODS foreign key (period_surr_id)
      references DIM_GEN_PERIODS (period_surr_id);

/
alter table FCT_SALES_DD
   add constraint FK_FCT_SALES_DS foreign key (delivery_system_id)
      references DIM_DELIVERY_SYSTEMS (delivery_system_id);
/
alter table FCT_SALES_DD
   add constraint FK_FCT_SALES_PS foreign key (payment_system_surr_id)
      references DIM_PAYMENT_SYSTEMS_SCD (payment_system_surr_id);
/
alter table FCT_SALES_DD
   add constraint FK_FCT_SALES_PRODS foreign key (prod_id)
      references DIM_PRODUCTS (prod_id);
/
alter table FCT_SALES_DD
   add constraint FK_FCT_SALES_GEO foreign key (geo_surr_id)
      references DIM_GEO_LOCATIONS_SCD (geo_surr_id);
   /   
create sequence seq_fct_sales_dd
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
 grant insert on FCT_SALES_DD to st_data;
  grant select on FCT_SALES_DD to st_data;
   grant select on seq_fct_sales_dd to st_data;
