
DROP TABLE u_dw_cls_star.cls_fct_operations_dd CASCADE CONSTRAINT;

/*==============================================================*/

/* Table: FCT_OPERATIONS_DD                                     */

/*==============================================================*/


CREATE TABLE u_dw_cls_star.cls_fct_operations_dd
(
   event_dt       DATE
 , restaurant_id  NUMBER ( 10 )
 , dish_sur_id    NUMBER ( 15 )
 , period_id      NUMBER ( 10 )
 , geo_id         NUMBER ( 20 )
 , fct_unit_amount NUMBER ( 20, 5 )
 , fct_total_sales_dol NUMBER ( 20, 5 )
 , insert_dt      DATE NOT NULL
)
PARTITION BY RANGE (event_dt)
   ( PARTITION part_month_cls_star_1
        VALUES LESS THAN
           (TO_DATE ( '01-FEB-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_1
        NOCOMPRESS
   , PARTITION part_month_cls_star_2
        VALUES LESS THAN
           (TO_DATE ( '01-MAR-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_2
        NOCOMPRESS
   , PARTITION part_month_cls_star_3
        VALUES LESS THAN
           (TO_DATE ( '01-APR-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_3
        NOCOMPRESS
   , PARTITION part_month_cls_star_4
        VALUES LESS THAN
           (TO_DATE ( '01-MAY-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_4
        NOCOMPRESS
   , PARTITION part_month_cls_star_5
        VALUES LESS THAN
           (TO_DATE ( '01-JUN-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_5
        NOCOMPRESS
   , PARTITION part_month_cls_star_6
        VALUES LESS THAN
           (TO_DATE ( '01-JUL-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_6
        NOCOMPRESS
   , PARTITION part_month_cls_star_7
        VALUES LESS THAN
           (TO_DATE ( '01-AUG-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_7
        NOCOMPRESS
   , PARTITION part_month_cls_star_8
        VALUES LESS THAN
           (TO_DATE ( '01-SEP-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_8
        NOCOMPRESS
   , PARTITION part_month_cls_star_9
        VALUES LESS THAN
           (TO_DATE ( '01-OCT-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_9
        NOCOMPRESS
   , PARTITION part_month_cls_star_10
        VALUES LESS THAN
           (TO_DATE ( '01-NOV-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_10
        NOCOMPRESS
   , PARTITION part_month_cls_star_11
        VALUES LESS THAN
           (TO_DATE ( '01-DEC-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_11
        NOCOMPRESS
   , PARTITION part_month_cls_star_12
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2013'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_cls_star_data_month_12
        NOCOMPRESS );