/* Formatted on 7/29/2013 3:43:28 PM (QP5 v5.139.911.3011) */
CREATE TABLE temp_ext_customers
(
   cust_identifier VARCHAR ( 10 CHAR )
 , cust_surname   VARCHAR2 ( 40 CHAR )
 , cust_name      VARCHAR2 ( 20 CHAR )
 , cust_street    VARCHAR2 ( 40 CHAR )
 , cust_fax       VARCHAR2 ( 10 CHAR )
 , cust_city      VARCHAR2 ( 20 CHAR )
 , cust_tel       VARCHAR2 ( 20 CHAR )
 , cust_email     VARCHAR2 ( 40 CHAR )
 , cust_country   VARCHAR2 ( 20 CHAR )
 , cust_region    VARCHAR2 ( 20 CHAR )
)
ORGANIZATION EXTERNAL
(TYPE oracle_loader
DEFAULT DIRECTORY ext_references
ACCESS PARAMETERS
(RECORDS DELIMITED BY NEWLINE NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL
(
cust_identifier CHAR (10),
cust_surname CHAR(40),
cust_name CHAR(20),
cust_street CHAR(40),
cust_fax CHAR(10),
cust_cox CHAR(20),
cust_city CHAR(20),
cust_tel CHAR (20),
cust_email CHAR(40),
cust_country CHAR(20),
cust_region CHAR(20))
)
LOCATION ('export.csv')
)
REJECT LIMIT UNLIMITED;
        

CREATE TABLE ext_customers
AS
   SELECT rownum as customer_identifier
        , cust_surname || ' ' || cust_name || ' ' || 'Inc' company_name
        , cust_region
        , cust_country
        , cust_city
        , cust_street
        , cust_fax
        , cust_tel
        , cust_email
        , cust_surname || ' ' || cust_name contact_person
     FROM temp_ext_customers;

CREATE TABLE ports
AS
   SELECT ROWNUM port_identifier
        , dbms_random.VALUE ( 1
                            , 50 )
             pier_num
        , cust_surname || ' ' || cust_name contact_person
        , cust_tel
        , cust_region
        , cust_country
        , cust_city
        , cust_street
     FROM temp_ext_customers