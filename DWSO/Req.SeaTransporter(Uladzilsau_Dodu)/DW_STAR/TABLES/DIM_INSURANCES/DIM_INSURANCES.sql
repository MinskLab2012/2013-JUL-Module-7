/* Formatted on 8/11/2013 2:13:35 PM (QP5 v5.139.911.3011) */
CREATE TABLE dim_insurances
(
   insurance_id   NUMBER ( 20 ) NOT NULL
 , insurance_code NUMBER ( 20 ) NOT NULL
 , company_name   VARCHAR2 ( 50 )
 , insurance_type VARCHAR2 ( 60 )
 , insurance_cost NUMBER ( 10 )
 , last_insert_dt DATE
 , last_update_dt DATE
)
TABLESPACE dw_star_insurances
PCTUSED 0
PCTFREE 10
INITRANS 1
MAXTRANS 255
STORAGE ( INITIAL 64 K NEXT 1 M MINEXTENTS 1 MAXEXTENTS UNLIMITED PCTINCREASE 0 BUFFER_POOL DEFAULT )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;