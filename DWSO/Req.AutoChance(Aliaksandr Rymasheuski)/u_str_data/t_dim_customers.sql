/* Formatted on 12.08.2013 13:13:07 (QP5 v5.139.911.3011) */
--DROP TABLE DIM_CUSTOMERS CASCADE CONSTRAINTS;

CREATE TABLE dim_customers
(
   cust_id        NUMBER ( 8 ) NOT NULL
 , passport_number VARCHAR2 ( 50 )
 , first_name     VARCHAR2 ( 50 )
 , last_name      VARCHAR2 ( 50 )
 , country        VARCHAR2 ( 60 )
 , city           VARCHAR2 ( 50 )
 , adress         VARCHAR2 ( 50 )
 , gender         VARCHAR2 ( 10 )
 , insert_dt      DATE
 , update_dt      DATE
)
PARTITION BY HASH (cust_id)
   ( PARTITION part1
        TABLESPACE ts_customers_part_1
   , PARTITION part2
        TABLESPACE ts_customers_part_2
   , PARTITION part3
        TABLESPACE ts_customers_part_3
   , PARTITION part4
        TABLESPACE ts_customers_part_4 );



INSERT INTO dim_customers
     VALUES ( -99
            , 'not available'
            , 'not available'
            , 'not available'
            , 'not available'
            , 'not available'
            , 'not available'
            , 'n.a.'
            , NULL
            , NULL );

COMMIT;
GRANT DELETE,INSERT,UPDATE,SELECT ON dim_customers TO u_sal_cl;