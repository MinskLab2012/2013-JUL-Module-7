create table DIM_CUSTOMERS
(
customer_id number(20) not null,
customer_code number(20) not null,
company_name varchar2(100),
customer_country varchar2(60),
customer_city varchar2(60),
customer_address varchar2(60),
customer_fax varchar2(50),
customer_tel varchar2(50),
customer_email varchar2(50),
contact_person varchar2(50),
last_insert_dt date,
last_update_dt date)
TABLESPACE dw_star_customers
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