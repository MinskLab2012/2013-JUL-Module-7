
DROP TABLE t_operations CASCADE CONSTRAINT PURGE;

--==============================================================
-- Table: t_operations
--==============================================================


CREATE TABLE u_dw_stage.t_operations
(
   operation_id   NUMBER ( 10 ) NOT NULL
 , transaction_id NUMBER ( 10 ) NOT NULL
 , event_dt       DATE NOT NULL
 , restaurant_id  NUMBER ( 10 )
 , dish_id        NUMBER ( 15 )
 , unit_price_dol NUMBER ( 20, 5 ) NOT NULL
 , unit_amount    NUMBER ( 20, 5 ) NOT NULL
 , total_price_dol NUMBER ( 20, 5 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE
)
TABLESPACE ts_dw_stage_data_01
PARTITION BY RANGE (event_dt)
   ( PARTITION part_month_1
        VALUES LESS THAN
           (TO_DATE ( '01-FEB-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_1
        NOCOMPRESS
   , PARTITION part_month_2
        VALUES LESS THAN
           (TO_DATE ( '01-MAR-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_2
        NOCOMPRESS
   , PARTITION part_month_3
        VALUES LESS THAN
           (TO_DATE ( '01-APR-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_3
        NOCOMPRESS
   , PARTITION part_month_4
        VALUES LESS THAN
           (TO_DATE ( '01-MAY-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_4
        NOCOMPRESS
   , PARTITION part_month_5
        VALUES LESS THAN
           (TO_DATE ( '01-JUN-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_5
        NOCOMPRESS
   , PARTITION part_month_6
        VALUES LESS THAN
           (TO_DATE ( '01-JUL-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_6
        NOCOMPRESS
   , PARTITION part_month_7
        VALUES LESS THAN
           (TO_DATE ( '01-AUG-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_7
        NOCOMPRESS
   , PARTITION part_month_8
        VALUES LESS THAN
           (TO_DATE ( '01-SEP-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_8
        NOCOMPRESS
   , PARTITION part_month_9
        VALUES LESS THAN
           (TO_DATE ( '01-OCT-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_9
        NOCOMPRESS
   , PARTITION part_month_10
        VALUES LESS THAN
           (TO_DATE ( '01-NOV-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_10
        NOCOMPRESS
   , PARTITION part_month_11
        VALUES LESS THAN
           (TO_DATE ( '01-DEC-2012'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_11
        NOCOMPRESS
   , PARTITION part_month_12
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2013'
                    , 'DD-MON-RR' ))
        TABLESPACE ts_data_month_12
        NOCOMPRESS );

ALTER TABLE u_dw_stage.t_operations
   ADD CONSTRAINT pk_t_operations PRIMARY KEY (operation_id) USING INDEX  TABLESPACE ts_dw_stage_idx_01;

CREATE INDEX idx_operations_dt
   ON t_operations ( event_dt )
   TABLESPACE ts_dw_stage_idx_01;