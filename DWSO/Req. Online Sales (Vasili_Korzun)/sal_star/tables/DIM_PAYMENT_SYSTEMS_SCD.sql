/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.08.2013 22:49:24                          */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_PAYMENT_SYSTEMS_SCD                               */
/*==============================================================*/
drop table DIM_PAYMENT_SYSTEMS_SCD cascade constraints purge;
drop sequence seq_dim_payment_systems;
create table DIM_PAYMENT_SYSTEMS_SCD 
(
   payment_system_surr_id NUMBER(5,0)          not null,
   payment_system_id  NUMBER(4,0)          not null,
   payment_system_code VARCHAR(100),
   payment_system_desc VARCHAR(100),
   payment_system_type_id NUMBER(3,0),
   payment_system_type_desc VARCHAR(100),
   valid_from DATE,
   valid_to DATE,
   is_actual          VARCHAR(1),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_DIM_PAYMENT_SYSTEMS_SCD primary key (payment_system_surr_id)
);
create sequence seq_dim_payment_systems
minvalue 1
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
 /
 
 grant insert on DIM_PAYMENT_SYSTEMS_SCD to st_data;
  grant select on DIM_PAYMENT_SYSTEMS_SCD to st_data;
    grant update on DIM_PAYMENT_SYSTEMS_SCD to st_data;
   grant select on seq_dim_payment_systems to st_data;
