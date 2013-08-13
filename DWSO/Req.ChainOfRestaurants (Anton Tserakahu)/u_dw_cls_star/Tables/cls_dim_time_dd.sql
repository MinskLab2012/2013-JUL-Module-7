
DROP TABLE u_dw_cls_star.cls_dim_time_dd CASCADE CONSTRAINT;

/*==============================================================*/

/* Table: DIM_TIME_DD                                           */

/*==============================================================*/

CREATE TABLE u_dw_cls_star.cls_dim_time_dd
(
   event_dt       DATE NOT NULL
 , day_name       VARCHAR2 ( 15 ) NOT NULL
 , day_number_in_week VARCHAR2 ( 4 ) NOT NULL
 , day_number_in_month VARCHAR2 ( 4 ) NOT NULL
 , day_number_in_year VARCHAR2 ( 4 ) NOT NULL
 , calendar_week_number VARCHAR2 ( 4 ) NOT NULL
 , week_ending_date DATE NOT NULL
 , calendar_month_number VARCHAR2 ( 4 ) NOT NULL
 , days_in_cal_month VARCHAR2 ( 4 ) NOT NULL
 , end_of_cal_month DATE NOT NULL
 , calendar_month_name VARCHAR2 ( 15 ) NOT NULL
 , days_in_cal_quarter VARCHAR2 ( 4 ) NOT NULL
 , beg_of_cal_quarter DATE NOT NULL
 , end_of_cal_quarter DATE NOT NULL
 , calendar_quarter_number VARCHAR2 ( 4 ) NOT NULL
 , calendar_year  VARCHAR2 ( 6 ) NOT NULL
 , days_in_cal_year VARCHAR2 ( 4 ) NOT NULL
 , beg_of_cal_year DATE NOT NULL
 , end_of_cal_year DATE NOT NULL
 , insert_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_time_dd PRIMARY KEY ( event_dt )
);