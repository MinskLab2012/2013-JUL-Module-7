/* Formatted on 10.08.2013 16:56:07 (QP5 v5.139.911.3011) */
--DROP TABLE dim_gen_periods CASCADE CONSTRAINTS PURGE;

CREATE TABLE dim_gen_periods
(
   period_surr_id NUMBER NOT NULL
 , period_id      NUMBER NOT NULL
 , period_code    VARCHAR2 ( 30 ) NOT NULL
 , period_desc    VARCHAR2 ( 50 ) NOT NULL
 , value_from_num NUMBER NOT NULL
 , value_to_num   NUMBER NOT NULL
 , value_from_dt  DATE NOT NULL
 , value_to_dt    DATE NOT NULL
 , value_from_char VARCHAR2 ( 20 ) NOT NULL
 , value_to_char  VARCHAR2 ( 20 ) NOT NULL
 , level_code     VARCHAR2 ( 20 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_gen_periods PRIMARY KEY ( period_surr_id )
);

INSERT INTO dim_gen_periods ( period_surr_id
                            , period_id
                            , period_code
                            , period_desc
                            , value_from_num
                            , value_to_num
                            , value_from_dt
                            , value_to_dt
                            , value_from_char
                            , value_to_char
                            , level_code
                            , insert_dt
                            , update_dt )
     VALUES ( -98
            , -98
            , 'n.a.'
            , 'not available'
            , -98
            , -98
            , TO_DATE ( '01/01/1900'
                      , 'dd/mm/yyyy' )
            , TO_DATE ( '01/01/1900'
                      , 'dd/mm/yyyy' )
            , 'n.a.'
            , 'n.a.'
            , 'n.a.'
            , SYSDATE
            , SYSDATE );

INSERT INTO dim_gen_periods ( period_surr_id
                            , period_id
                            , period_code
                            , period_desc
                            , value_from_num
                            , value_to_num
                            , value_from_dt
                            , value_to_dt
                            , value_from_char
                            , value_to_char
                            , level_code
                            , insert_dt
                            , update_dt )
     VALUES ( -99
            , -99
            , 'n.d.'
            , 'not defined'
            , -99
            , -99
            , TO_DATE ( '01/01/1800'
                      , 'dd/mm/yyyy' )
            , TO_DATE ( '01/01/1800'
                      , 'dd/mm/yyyy' )
            , 'n.d.'
            , 'n.d.'
            , 'n.d.'
            , SYSDATE
            , SYSDATE );

COMMIT;