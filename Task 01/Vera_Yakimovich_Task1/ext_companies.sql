/* Formatted on 02.08.2013 21:11:19 (QP5 v5.139.911.3011) */
DROP TABLE ext_company;

CREATE TABLE ext_company
(
   company_name   VARCHAR2 ( 70 CHAR )
 , pct1           CHAR ( 7 )
 , pct2           CHAR ( 7 )
 , pct3           CHAR ( 7 )
 , pct4           CHAR ( 7 )
)
ORGANIZATION EXTERNAL
                       ( TYPE oracle_loader DEFAULT DIRECTORY ext_references
 ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ','
 MISSING FIELD VALUES ARE NULL( company_name CHAR ( 70 ), pct1 CHAR (7), pct2 CHAR (7),  pct3 CHAR (7), pct4 CHAR (7) )  )
 LOCATION ('companies.csv'))REJECT LIMIT UNLIMITED;