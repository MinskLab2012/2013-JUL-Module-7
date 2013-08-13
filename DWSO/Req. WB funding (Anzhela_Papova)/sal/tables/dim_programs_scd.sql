/* Formatted on 10.08.2013 18:02:32 (QP5 v5.139.911.3011) */
--DROP TABLE dim_programs_scd CASCADE CONSTRAINTS PURGE;

CREATE TABLE dim_programs_scd
(
   program_surr_id NUMBER NOT NULL
 , program_id     NUMBER NOT NULL
 , program_code   VARCHAR2 ( 10 ) NOT NULL
 , program_desc   VARCHAR2 ( 100 ) NOT NULL
 , manager_id     NUMBER NOT NULL
 , manager_desc   VARCHAR2 ( 100 ) NOT NULL
 , valid_from     DATE NOT NULL
 , valid_to       DATE NOT NULL
 , is_active      VARCHAR2 ( 4 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_programs_scd PRIMARY KEY ( program_surr_id )
);


INSERT INTO dim_programs_scd ( program_surr_id
                             , program_id
                             , program_code
                             , program_desc
                             , manager_id
                             , manager_desc
                             , valid_from
                             , valid_to
                             , is_active
                             , insert_dt )
     VALUES ( -98
            , -98
            , 'n.a.'
            , 'not available'
            , -98
            , 'not available'
            , TO_DATE ( '01/01/1900'
                      , 'dd/mm/yyyy' )
            , TO_DATE ( '31/12/9999'
                      , 'dd/mm/yyyy' )
            , 'Y'
            , SYSDATE );

INSERT INTO dim_programs_scd (program_surr_id
                             , program_id
                             , program_code
                             , program_desc
                             , manager_id
                             , manager_desc
                             , valid_from
                             , valid_to
                             , is_active
                             , insert_dt )
     VALUES ( -99
            , -99
            , 'n.d.'
            , 'not defined'
            , -99
            , 'not defined'
            , TO_DATE ( '01/01/1900'
                      , 'dd/mm/yyyy' )
            , TO_DATE ( '31/12/9999'
                      , 'dd/mm/yyyy' )
            , 'Y'
            , SYSDATE );

COMMIT;