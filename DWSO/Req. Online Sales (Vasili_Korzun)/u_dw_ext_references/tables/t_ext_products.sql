/* Formatted on 7/29/2013 2:28:02 PM (QP5 v5.139.911.3011) */
--------------------------------------------------------
--  File created - понедельник-»юль-29-2013
--drop table t_ext_products;

CREATE TABLE t_ext_products
(
   "PROD_ID"      NUMBER ( 6, 0 )
 , "PROD_NAME"    VARCHAR2 ( 50 BYTE )
 , "PROD_DESC"    VARCHAR2 ( 4000 BYTE )
 , "PROD_SUBCATEGORY" VARCHAR2 ( 50 BYTE )
 , "PROD_SUBCATEGORY_ID" NUMBER
 , "PROD_SUBCATEGORY_DESC" VARCHAR2 ( 2000 BYTE )
 , "PROD_CATEGORY" VARCHAR2 ( 50 BYTE )
 , "PROD_CATEGORY_ID" NUMBER
 , "PROD_CATEGORY_DESC" VARCHAR2 ( 2000 BYTE )
 , "PROD_WEIGHT_CLASS" NUMBER ( 3, 0 )
 , "PROD_UNIT_OF_MEASURE" VARCHAR2 ( 20 BYTE )
 , "PROD_PACK_SIZE" VARCHAR2 ( 30 BYTE )
 , "SUPPLIER_ID"  NUMBER ( 6, 0 )
 , "PROD_STATUS"  VARCHAR2 ( 20 BYTE )
 , "PROD_LIST_PRICE" NUMBER ( 8, 2 )
 , "PROD_MIN_PRICE" NUMBER ( 8, 2 )
 , "PROD_TOTAL"   VARCHAR2 ( 13 BYTE )
 , "PROD_TOTAL_ID" NUMBER
 , "PROD_SRC_ID"  NUMBER
 , "PROD_EFF_FROM" DATE
 , "PROD_EFF_TO"  DATE
 , "PROD_VALID"   VARCHAR2 ( 1 BYTE )
);

   COMMENT ON COLUMN t_ext_products."PROD_ID" IS 'primary key';
   COMMENT ON COLUMN t_ext_products."PROD_NAME" IS 'product name';
   COMMENT ON COLUMN t_ext_products."PROD_DESC" IS 'product description';
   COMMENT ON COLUMN t_ext_products."PROD_SUBCATEGORY" IS 'product subcategory';
   COMMENT ON COLUMN t_ext_products."PROD_SUBCATEGORY_DESC" IS 'product subcategory description';
   COMMENT ON COLUMN t_ext_products."PROD_CATEGORY" IS 'product category';
   COMMENT ON COLUMN t_ext_products."PROD_CATEGORY_DESC" IS 'product category description';
   COMMENT ON COLUMN t_ext_products."PROD_WEIGHT_CLASS" IS 'product weight class';
   COMMENT ON COLUMN t_ext_products."PROD_UNIT_OF_MEASURE" IS 'product unit of measure';
   COMMENT ON COLUMN t_ext_products."PROD_PACK_SIZE" IS 'product package size';
   COMMENT ON COLUMN t_ext_products."SUPPLIER_ID" IS 'this column';
   COMMENT ON COLUMN t_ext_products."PROD_STATUS" IS 'product status';
   COMMENT ON COLUMN t_ext_products."PROD_LIST_PRICE" IS 'product list price';
   COMMENT ON COLUMN t_ext_products."PROD_MIN_PRICE" IS 'product minimum price';
   COMMENT ON TABLE t_ext_products  IS 'dimension table';
REM INSERTING into T_EXT_PRODUCTS
SET DEFINE OFF;

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 13
            , '5MP Telephoto Digital Camera'
            , '5MP Telephoto Digital Camera'
            , 'Cameras'
            , 2044
            , 'Cameras'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 899.99
            , 899.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 14
            , '17" LCD w/built-in HDTV Tuner'
            , '17" LCD w/built-in HDTV Tuner'
            , 'Monitors'
            , 2035
            , 'Monitors'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 999.99
            , 999.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 15
            , 'Envoy 256MB - 40GB'
            , 'Envoy 256MB - 40Gb'
            , 'Desktop PCs'
            , 2021
            , 'Desktop PCs'
            , 'Hardware'
            , 202
            , 'Hardware'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 999.99
            , 999.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 16
            , 'Y Box'
            , 'Y Box'
            , 'Game Consoles'
            , 2011
            , 'Game Consoles'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 299.99
            , 299.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 17
            , 'Mini DV Camcorder with 3.5" Swivel LCD'
            , 'Mini DV Camcorder with 3.5" Swivel LCD'
            , 'Camcorders'
            , 2041
            , 'Camcorders'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 1099.99
            , 1099.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 18
            , 'Envoy Ambassador'
            , 'Envoy Ambassador'
            , 'Portable PCs'
            , 2022
            , 'Portable PCs'
            , 'Hardware'
            , 202
            , 'Hardware'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 1299.99
            , 1299.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 19
            , 'Laptop carrying case'
            , 'Laptop carrying case'
            , 'Accessories'
            , 2051
            , 'Accessories'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 55.99
            , 55.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 20
            , 'Home Theatre Package with DVD-Audio/Video Play'
            , 'Home Theatre Package with DVD-Audio/Video Play'
            , 'Home Audio'
            , 2012
            , 'Home Audio'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 599.99
            , 599.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 21
            , '18" Flat Panel Graphics Monitor'
            , '18" Flat Panel Graphics Monitor'
            , 'Monitors'
            , 2035
            , 'Monitors'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 899.99
            , 899.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 22
            , 'Envoy External Keyboard'
            , 'Envoy External Keyboard'
            , 'Accessories'
            , 2031
            , 'Accessories'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 24.99
            , 24.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 23
            , 'External 101-key keyboard'
            , 'External 101-key keyboard'
            , 'Accessories'
            , 2051
            , 'Accessories'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 21.99
            , 21.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 24
            , 'PCMCIA modem/fax 28800 baud'
            , 'PCMCIA modem/fax 28800 baud'
            , 'Modems/Fax'
            , 2034
            , 'Modems/Fax'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 45.99
            , 45.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 25
            , 'SIMM- 8MB PCMCIAII card'
            , 'SIMM- 8MB PCMCIAII card'
            , 'Memory'
            , 2033
            , 'Memory'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 112.99
            , 112.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 26
            , 'SIMM- 16MB PCMCIAII card'
            , 'SIMM- 16MB PCMCIAII card'
            , 'Memory'
            , 2033
            , 'Memory'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 149.99
            , 149.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 27
            , 'Multimedia speakers- 3" cones'
            , 'Multimedia speakers- 3" cones'
            , 'Accessories'
            , 2031
            , 'Accessories'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 28
            , 'Unix/Windows 1-user pack'
            , 'Unix/Windows 1-user pack'
            , 'Operating Systems'
            , 2052
            , 'Operating Systems'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 199.99
            , 199.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 29
            , '8.3 Minitower Speaker'
            , '8.3 Minitower Speaker'
            , 'Home Audio'
            , 2012
            , 'Home Audio'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 499.99
            , 499.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 30
            , 'Mouse Pad'
            , 'Mouse Pad'
            , 'Accessories'
            , 2051
            , 'Accessories'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 9.99
            , 9.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 31
            , '1.44MB External 3.5" Diskette'
            , '1.44MB External 3.5" Diskette'
            , 'Accessories'
            , 2051
            , 'Accessories'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 8.99
            , 8.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 32
            , 'Multimedia speakers- 5" cones'
            , 'Multimedia speakers- 5" cones'
            , 'Accessories'
            , 2031
            , 'Accessories'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 67.99
            , 67.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 33
            , 'PCMCIA modem/fax 19200 baud'
            , 'PCMCIA modem/fax 19200 baud'
            , 'Modems/Fax'
            , 2034
            , 'Modems/Fax'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 34
            , 'External 6X CD-ROM'
            , 'External 6X CD-ROM'
            , 'CD-ROM'
            , 2032
            , 'CD-ROM'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 39.99
            , 39.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 35
            , 'External 8X CD-ROM'
            , 'External 8X CD-ROM'
            , 'CD-ROM'
            , 2032
            , 'CD-ROM'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 49.99
            , 49.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 36
            , 'Envoy External 6X CD-ROM'
            , 'Envoy External 6X CD-ROM'
            , 'CD-ROM'
            , 2032
            , 'CD-ROM'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 37
            , 'Envoy External 8X CD-ROM'
            , 'Envoy External 8X CD-ROM'
            , 'CD-ROM'
            , 2032
            , 'CD-ROM'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 54.99
            , 54.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 38
            , 'Internal 6X CD-ROM'
            , 'Internal 6X CD-ROM'
            , 'CD-ROM'
            , 2032
            , 'CD-ROM'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 29.99
            , 29.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 39
            , 'Internal 8X CD-ROM'
            , 'Internal 8X CD-ROM'
            , 'CD-ROM'
            , 2032
            , 'CD-ROM'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 34.99
            , 34.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 40
            , 'O/S Documentation Set - English'
            , 'O/S Documentation Set - English'
            , 'Documentation'
            , 2054
            , 'Documentation'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 41
            , 'O/S Documentation Set - German'
            , 'O/S Documentation Set - German'
            , 'Documentation'
            , 2054
            , 'Documentation'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 42
            , 'O/S Documentation Set - French'
            , 'O/S Documentation Set - French'
            , 'Documentation'
            , 2054
            , 'Documentation'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 43
            , 'O/S Documentation Set - Spanish'
            , 'O/S Documentation Set - Spanish'
            , 'Documentation'
            , 2054
            , 'Documentation'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 44
            , 'O/S Documentation Set - Italian'
            , 'O/S Documentation Set - Italian'
            , 'Documentation'
            , 2054
            , 'Documentation'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 45
            , 'O/S Documentation Set - Kanji'
            , 'O/S Documentation Set - Kanji'
            , 'Documentation'
            , 2054
            , 'Documentation'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 44.99
            , 44.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 46
            , 'Standard Mouse'
            , 'Standard Mouse'
            , 'Accessories'
            , 2031
            , 'Accessories'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 22.99
            , 22.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 47
            , 'Deluxe Mouse'
            , 'Deluxe Mouse'
            , 'Accessories'
            , 2031
            , 'Accessories'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 28.99
            , 28.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 48
            , 'Keyboard Wrist Rest'
            , 'Keyboard Wrist Rest'
            , 'Accessories'
            , 2051
            , 'Accessories'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 11.99
            , 11.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 113
            , 'CD-R Mini Discs'
            , 'CD-R Mini Discs with Jewel Case, 185MB, Pack of 5'
            , 'Recordable CDs'
            , 2055
            , 'Recordable CDs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 22.99
            , 22.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 114
            , 'Music CD-R'
            , 'Music CD-R with Spindle, 700MB, Pack of 30'
            , 'Recordable CDs'
            , 2055
            , 'Recordable CDs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 18.99
            , 18.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 115
            , 'CD-RW, High Speed, Pack of 10'
            , 'CD-RW, High Speed, Pack of 10'
            , 'Recordable CDs'
            , 2055
            , 'Recordable CDs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 8.99
            , 8.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 116
            , 'CD-RW, High Speed Pack of 5'
            , 'CD-RW, High Speed 650MB/74 Minutes, Pack of 5'
            , 'Recordable CDs'
            , 2055
            , 'Recordable CDs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 11.99
            , 11.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 117
            , 'CD-R, Professional Grade, Pack of 10'
            , 'CD-R, Professional Grade, Pack of 10'
            , 'Recordable CDs'
            , 2055
            , 'Recordable CDs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 8.99
            , 8.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 118
            , 'OraMusic CD-R, Pack of 10'
            , 'OraMusic CD-R, Pack of 10'
            , 'Recordable CDs'
            , 2055
            , 'Recordable CDs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 7.99
            , 7.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 119
            , 'CD-R with Jewel Cases, pACK OF 12'
            , 'CD-R with Jewel Cases, 700MB/80 Minutes, Pack of 12'
            , 'Recordable CDs'
            , 2055
            , 'Recordable CDs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 6.99
            , 6.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 120
            , 'DVD-R Disc with Jewel Case, 4.7 GB'
            , 'DVD-R Disc with Jewel Case, 4.7 GB'
            , 'Recordable DVD Discs'
            , 2056
            , 'Recordable DVD Discs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 6.99
            , 6.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 121
            , 'DVD-RAM Jewel Case, Double-Sided, 9.4G'
            , 'DVD-RAM Media, with Jewel Case, Double-Sided, 9.4GB'
            , 'Recordable DVD Discs'
            , 2056
            , 'Recordable DVD Discs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 10.99
            , 10.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 122
            , 'DVD-R Discs, 4.7GB, Pack of 5'
            , 'DVD-R Discs, 4.7GB, Pack of 5'
            , 'Recordable DVD Discs'
            , 2056
            , 'Recordable DVD Discs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 18.99
            , 18.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 123
            , 'DVD-R Discs, 4.7GB, Pack of 5'
            , 'DVD-R Discs, 4.7GB, Pack of 5'
            , 'Recordable DVD Discs'
            , 2056
            , 'Recordable DVD Discs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 49.99
            , 49.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 124
            , 'DVD-RW Discs, 4.7GB, Pack of 3'
            , 'DVD-RW Discs, 4.7GB, Pack of 3'
            , 'Recordable DVD Discs'
            , 2056
            , 'Recordable DVD Discs'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 18.99
            , 18.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 125
            , '3 1/2" Bulk diskettes, Box of 50'
            , '3 1/2" Bulk diskettes, Box of 50'
            , 'Bulk Pack Diskettes'
            , 2053
            , 'Bulk Pack Diskettes'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 15.99
            , 15.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 126
            , '3 1/2" Bulk diskettes, Box of 100'
            , '3 1/2" Bulk diskettes, Box of 100'
            , 'Bulk Pack Diskettes'
            , 2053
            , 'Bulk Pack Diskettes'
            , 'Software/Other'
            , 205
            , 'Software/Other'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 28.99
            , 28.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 127
            , 'Model CD13272 Tricolor Ink Cartridge'
            , 'Model CD13272 Tricolor Ink Cartridge'
            , 'Printer Supplies'
            , 2036
            , 'Printer Supplies'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 36.99
            , 36.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 128
            , 'Model SM26273 Black Ink Cartridge'
            , 'Model SM26273 Black Ink Cartridge'
            , 'Printer Supplies'
            , 2036
            , 'Printer Supplies'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 27.99
            , 27.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 129
            , 'Model NM500X High Yield Toner Cartridge'
            , 'Model NM500X High Yield Toner Cartridge'
            , 'Printer Supplies'
            , 2036
            , 'Printer Supplies'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 192.99
            , 192.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 130
            , 'Model A3827H Black Image Cartridge'
            , 'Model A3827H Black Image Cartridge'
            , 'Printer Supplies'
            , 2036
            , 'Printer Supplies'
            , 'Peripherals and Accessories'
            , 203
            , 'Peripherals and Accessories'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 89.99
            , 89.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 131
            , 'Model K3822L Cordless Phone Battery'
            , 'Model K3822L Cordless Phone Battery'
            , 'Camera Batteries'
            , 2042
            , 'Camera Batteries'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 18.99
            , 18.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 132
            , 'Model C9827B Cordless Phone Battery'
            , 'Model C9827B Cordless Phone Battery'
            , 'Camera Batteries'
            , 2042
            , 'Camera Batteries'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 24.99
            , 24.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 133
            , 'Model K8822S Cordless Phone Battery'
            , 'Model K8822S Cordless Phone Battery'
            , 'Camera Batteries'
            , 2042
            , 'Camera Batteries'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 30.99
            , 30.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 134
            , 'Model C93822D Wireless Phone Battery'
            , 'Model C93822D Wireless Phone Battery'
            , 'Camera Batteries'
            , 2042
            , 'Camera Batteries'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 20.99
            , 20.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 135
            , 'S27273M Extended Use w/l Phone Batt.'
            , 'Model S27273M Extended Use Wireless Phone Battery'
            , 'Camera Batteries'
            , 2042
            , 'Camera Batteries'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 49.99
            , 49.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 136
            , '64MB Memory Card'
            , '64MB Memory Card'
            , 'Camera Media'
            , 2043
            , 'Camera Media'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 32.99
            , 32.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 137
            , '128MB Memory Card'
            , '128MB Memory Card'
            , 'Camera Media'
            , 2043
            , 'Camera Media'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 52.99
            , 52.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 138
            , '256MB Memory Card'
            , '256MB Memory Card'
            , 'Camera Media'
            , 2043
            , 'Camera Media'
            , 'Photo'
            , 204
            , 'Photo'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 69.99
            , 69.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 139
            , 'Bounce'
            , 'Bounce'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 4
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 19.99
            , 19.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 140
            , 'Endurance Racing'
            , 'Endurance Racing'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 29.99
            , 29.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 141
            , 'Smash up Boxing'
            , 'Smash up Boxing'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 29.99
            , 29.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 142
            , 'Martial Arts Champions'
            , 'Martial Arts Champions'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 19.99
            , 19.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 143
            , 'Comic Book Heroes'
            , 'Comic Book Heroes'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 19.99
            , 19.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 144
            , 'Fly Fishing'
            , 'Fly Fishing'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 7.99
            , 7.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 145
            , 'Finding Fido'
            , 'Finding Fido'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 12.99
            , 12.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 146
            , 'Adventures with Numbers'
            , 'Adventures with Numbers'
            , 'Y Box Games'
            , 2014
            , 'Y Box Games'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 11.99
            , 11.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 147
            , 'Extension Cable'
            , 'Extension Cable'
            , 'Y Box Accessories'
            , 2013
            , 'Y Box Accessories'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 7.99
            , 7.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

INSERT INTO t_ext_products ( prod_id
                           , prod_name
                           , prod_desc
                           , prod_subcategory
                           , prod_subcategory_id
                           , prod_subcategory_desc
                           , prod_category
                           , prod_category_id
                           , prod_category_desc
                           , prod_weight_class
                           , prod_unit_of_measure
                           , prod_pack_size
                           , supplier_id
                           , prod_status
                           , prod_list_price
                           , prod_min_price
                           , prod_total
                           , prod_total_id
                           , prod_src_id
                           , prod_eff_from
                           , prod_eff_to
                           , prod_valid )
     VALUES ( 148
            , 'Xtend Memory'
            , 'Xtend Memory'
            , 'Y Box Accessories'
            , 2013
            , 'Y Box Accessories'
            , 'Electronics'
            , 201
            , 'Electronics'
            , 1
            , 'U'
            , 'P'
            , 1
            , 'STATUS'
            , 20.99
            , 20.99
            , 'TOTAL'
            , 1
            , NULL
            , TO_DATE ( '01-JAN-98'
                      , 'DD-MON-RR' )
            , NULL
            , 'A' );

--------------------------------------------------------
--  Constraints for Table PRODUCTS
--------------------------------------------------------
  ALTER TABLE t_ext_products MODIFY ("PROD_TOTAL_ID" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_TOTAL" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_MIN_PRICE" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_LIST_PRICE" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_STATUS" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("SUPPLIER_ID" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_PACK_SIZE" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_WEIGHT_CLASS" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_CATEGORY_DESC" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_CATEGORY_ID" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_CATEGORY" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_SUBCATEGORY_DESC" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_SUBCATEGORY_ID" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_SUBCATEGORY" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_DESC" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_NAME" NOT NULL ENABLE);
  ALTER TABLE t_ext_products MODIFY ("PROD_ID" NOT NULL ENABLE);

CREATE TABLE cls_products
AS
   SELECT rownum as prod_id
        , prod_name
        , prod_desc
        , prod_subcategory
        , prod_subcategory_id
        , prod_subcategory_desc
        , prod_category
        , prod_category_id
        , prod_category_desc
       from t_ext_products;
       
       
drop table t_ext_products purge;