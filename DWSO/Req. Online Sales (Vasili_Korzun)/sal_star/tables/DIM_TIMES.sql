/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.08.2013 22:49:24                          */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_TIMES                                             */
/*==============================================================*/
drop table DIM_TIMES cascade constraints;
create table DIM_TIMES 
(
   time_id            DATE                 not null,
   day_name           VARCHAR(36),
   day_number_in_week NUMBER(3,0),
   day_number_in_month NUMBER(3,0),
   day_number_in_year NUMBER(4,0),
   calendar_week_number NUMBER,
   week_ending_date   DATE,
   calendar_month_number NUMBER(3,0),
   days_in_cal_month  NUMBER(3,0),
   end_of_cal_month   DATE,
   calendar_month_name VARCHAR(36),
   calendar_quarter_number NUMBER(2,0),
   days_in_cal_quarter NUMBER(4,0),
   beg_of_calendar_quarter DATE,
    end_of_calendar_quarter DATE,
   calendar_year      NUMBER(5,0),
   days_in_cal_year   NUMBER(4,0),
   beg_of_cal_year    DATE,
   end_of_cal_year    DATE,
   constraint PK_DIM_TIMES primary key (time_id)
);
grant insert, update on dim_times to st_data;

