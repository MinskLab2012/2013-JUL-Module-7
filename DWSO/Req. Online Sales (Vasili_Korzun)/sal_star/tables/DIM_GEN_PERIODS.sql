/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.08.2013 22:49:24                          */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_GEN_PERIODS                                       */
/*==============================================================*/
drop table DIM_GEN_PERIODS cascade constraints;
create table DIM_GEN_PERIODS 
(
   period_surr_id     NUMBER(4,0)          not null,
   period_id          NUMBER(3,0),
   period_desc        VARCHAR(100),
   start_dt           DATE,
   end_dt             DATE,
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_DIM_GEN_PERIODS primary key (period_surr_id)
);

