/* Formatted on 10.08.2013 15:46:18 (QP5 v5.139.911.3011) */
--DROP TABLE dim_fin_sources CASCADE CONSTRAINTS PURGE;

CREATE TABLE dim_fin_sources
(
   fin_source_id  NUMBER NOT NULL
 , fin_source_code NUMBER NOT NULL
 , fin_source_desc VARCHAR2 ( 100 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , update_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_fin_sources PRIMARY KEY ( fin_source_id )
);

INSERT INTO dim_fin_sources ( fin_source_id
                            , fin_source_code
                            , fin_source_desc
                            , insert_dt
                            , update_dt )
     VALUES ( -98
            , -98
            , 'not available'
            , SYSDATE
            , SYSDATE );

INSERT INTO dim_fin_sources ( fin_source_id
                            , fin_source_code
                            , fin_source_desc
                            , insert_dt
                            , update_dt )
     VALUES ( -99
            , -99
            , 'not defined'
            , SYSDATE
            , SYSDATE );

COMMIT;