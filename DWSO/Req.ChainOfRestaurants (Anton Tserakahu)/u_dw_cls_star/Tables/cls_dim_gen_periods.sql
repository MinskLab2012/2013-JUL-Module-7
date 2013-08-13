
DROP TABLE u_dw_cls_star.cls_dim_gen_periods CASCADE CONSTRAINT;

/*==============================================================*/

/* Table: DIM_GEN_PERIODS                                       */

/*==============================================================*/

CREATE TABLE u_dw_cls_star.cls_dim_gen_periods
(
   period_id      NUMBER ( 10 )  NOT NULL
 , period_code    VARCHAR2 ( 50 ) NOT NULL
 , period_desc    VARCHAR2 ( 500 ) NOT NULL
 , start_dt       DATE NOT NULL
 , end_dt         DATE NOT NULL
 , period_type_id NUMBER ( 10 ) NOT NULL
 , period_type_name VARCHAR2 ( 150 ) NOT NULL
 , period_type_desc VARCHAR2 ( 50 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_gen_periods PRIMARY KEY ( period_id )
);