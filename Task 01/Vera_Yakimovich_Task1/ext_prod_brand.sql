/* Formatted on 02.08.2013 21:11:52 (QP5 v5.139.911.3011) */
DROP TABLE ext_prod_brand;

CREATE TABLE ext_prod_brand ( brand_name VARCHAR2 ( 70 CHAR ) )
ORGANIZATION EXTERNAL
                       ( TYPE oracle_loader DEFAULT DIRECTORY ext_references
 ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE NOBADFILE NODISCARDFILE NOLOGFILE FIELDS
 MISSING FIELD VALUES ARE NULL(  brand_name CHAR ( 70 ) )  )
 LOCATION ('beer_brand.csv'))REJECT LIMIT UNLIMITED;