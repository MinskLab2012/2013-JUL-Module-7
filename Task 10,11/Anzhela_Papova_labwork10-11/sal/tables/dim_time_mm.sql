/* Formatted on 10.08.2013 17:34:10 (QP5 v5.139.911.3011) */
--DROP TABLE dim_time_mm CASCADE CONSTRAINTS PURGE;

CREATE TABLE dim_time_mm
(
   time_id        DATE NOT NULL
 , calendar_month_number VARCHAR2 ( 10 ) NOT NULL
 , days_in_cal_month VARCHAR2 ( 10 ) NOT NULL
 , end_of_cal_month DATE NOT NULL
 , calendar_month_name VARCHAR2 ( 40 ) NOT NULL
 , days_in_cal_quarter NUMBER NOT NULL
 , beg_of_cal_quarter DATE NOT NULL
 , end_of_cal_quarter DATE NOT NULL
 , calendar_quarter_number VARCHAR2 ( 10 ) NOT NULL
 , calendar_year  VARCHAR2 ( 10 ) NOT NULL
 , days_in_cal_year NUMBER NOT NULL
 , beg_of_cal_year DATE NOT NULL
 , end_of_cal_year DATE NOT NULL
 , CONSTRAINT pk_dim_time_mm PRIMARY KEY ( time_id )
);