/* Formatted on 8/11/2013 3:36:48 PM (QP5 v5.139.911.3011) */
CREATE TABLE dim_times
(
   event_dt       date NOT NULL
 , day_of_week    VARCHAR2 ( 50 )
 , day_num_cal_month varchar2 ( 20 )
 , day_num_cal_year varchar2 (20 )
 , cal_week_num   varchar2 ( 20 )
 , end_of_week    VARCHAR2(20)
 , month_name     VARCHAR2 ( 20 )
 , days_in_month  VARCHAR2 ( 20 )
 , year_cal       VARCHAR2 (20)
 , year_ends      VARCHAR2 (20)
)
TABLESPACE dw_star_gen_per
PCTUSED 0
PCTFREE 10
INITRANS 1
MAXTRANS 255
STORAGE ( INITIAL 64 K NEXT 1 M MINEXTENTS 1 MAXEXTENTS UNLIMITED PCTINCREASE 0 BUFFER_POOL DEFAULT )
LOGGING
NOCOMPRESS
NOCACHE
PARALLEL
MONITORING
PARTITION BY HASH (year_cal)
   ( PARTITION par_1
        TABLESPACE dw_star_times_2008
   , PARTITION par_2
        TABLESPACE dw_star_times_2009
   , PARTITION par_3
        TABLESPACE dw_star_times_2010
   , PARTITION par_4
        TABLESPACE dw_star_times_2011
   , PARTITION par_5
        TABLESPACE dw_star_times_2012
   , PARTITION par_6
        TABLESPACE dw_star_times_2013 );
