/* Formatted on 8/10/2013 8:17:39 PM (QP5 v5.139.911.3011) */
CREATE TABLE dim_ports
(
   port_id        NUMBER ( 20 ) NOT NULL
 , port_code      NUMBER ( 20 ) NOT NULL
 , pier_code      NUMBER ( 10 )
 , port_country   VARCHAR2 ( 60 )
 , port_city      VARCHAR2 ( 60 )
 , port_address   VARCHAR2 ( 100 )
 , contact_person VARCHAR2 ( 100 )
 , contact_tel    VARCHAR2 ( 30 )
 , last_insert_dt DATE
 , last_update_dt DATE
)
TABLESPACE dw_start_ports
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
