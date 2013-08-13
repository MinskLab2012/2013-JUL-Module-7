/* Formatted on 8/10/2013 8:06:34 PM (QP5 v5.139.911.3011) */
CREATE SEQUENCE dim_prod_seq
   START WITH 1
   INCREMENT BY 1;

CREATE TABLE dim_products_scd
(
   prod_sur_id    NUMBER ( 10 ) DEFAULT dim_prod_seq.NEXTVAL
 , prod_id        NUMBER ( 20 )
 , prod_code      NUMBER ( 20 )
 , prod_name      VARCHAR2 ( 100 )
 , prod_desc      VARCHAR2 ( 200 )
 , income_coef    NUMBER ( 5, 2 )
 , prod_category_id NUMBER ( 20 )
 , prod_category_name VARCHAR2 ( 100 )
 , prod_category_desc VARCHAR2 ( 200 )
 , actual_from    DATE
 , actual_to      DATE
)
PARTITION BY HASH (prod_category_id)
   ( PARTITION prod_par_1
        TABLESPACE dw_start_products_partition_1
   , PARTITION prod_par_2
        TABLESPACE dw_start_products_partition_2
   , PARTITION prod_par_3
        TABLESPACE dw_start_products_partition_3
   , PARTITION prod_par_4
        TABLESPACE dw_start_products_partition_4
   , PARTITION prod_par_5
        TABLESPACE dw_start_products_partition_5 );