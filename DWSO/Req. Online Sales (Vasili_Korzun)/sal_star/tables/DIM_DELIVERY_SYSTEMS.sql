/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.08.2013 22:49:24                          */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_DELIVERY_SYSTEMS                                  */
/*==============================================================*/
drop table DIM_DELIVERY_SYSTEMS cascade constraints purge;
create table DIM_DELIVERY_SYSTEMS 
(
   delivery_system_id NUMBER(4,0)          not null,
   delivery_system_code VARCHAR(36),
   delivery_system_desc VARCHAR(100),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_DIM_DELIVERY_SYSTEMS primary key (delivery_system_id)
);
 grant insert on DIM_DELIVERY_SYSTEMS to st_data;
  grant select on DIM_DELIVERY_SYSTEMS to st_data;

