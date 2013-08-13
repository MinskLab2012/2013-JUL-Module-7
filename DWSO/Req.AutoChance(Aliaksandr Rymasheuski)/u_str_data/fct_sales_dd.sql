/* Formatted on 13.08.2013 11:39:55 (QP5 v5.139.911.3011) */
DROP TABLE fct_sales_dd CASCADE CONSTRAINTS;


CREATE TABLE fct_sales_dd
(
   event_dt       DATE NOT NULL
 , periods_surr_id NUMBER ( 8 )
 , contract_number VARCHAR2 ( 50 )
 , car_id         NUMBER ( 20 )
 , geo_surr_id    NUMBER ( 20 )
 , ta_geo_id      NUMBER ( 20 )
 , cust_id        NUMBER ( 8 )
 , emp_surr_id    NUMBER ( 20 )
 , amount_sold    NUMBER ( 20 )
 , profit         NUMBER ( 20 )
 , insert_dt      DATE
)
PARTITION BY RANGE (event_dt)
   ( PARTITION sales1999
        VALUES LESS THAN
           (TO_DATE ( '01/01/2000'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2000
        VALUES LESS THAN
           (TO_DATE ( '01/01/2001'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2001
        VALUES LESS THAN
           (TO_DATE ( '01/01/2002'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2002
        VALUES LESS THAN
           (TO_DATE ( '01/01/2003'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2003
        VALUES LESS THAN
           (TO_DATE ( '01/01/2004'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2004
        VALUES LESS THAN
           (TO_DATE ( '01/01/2005'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2005
        VALUES LESS THAN
           (TO_DATE ( '01/01/2006'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2006
        VALUES LESS THAN
           (TO_DATE ( '01/01/2007'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2007
        VALUES LESS THAN
           (TO_DATE ( '01/01/2008'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2008
        VALUES LESS THAN
           (TO_DATE ( '01/01/2009'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2009
        VALUES LESS THAN
           (TO_DATE ( '01/01/2010'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2010
        VALUES LESS THAN
           (TO_DATE ( '01/01/2011'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2011
        VALUES LESS THAN
           (TO_DATE ( '01/01/2012'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2012
        VALUES LESS THAN
           (TO_DATE ( '01/01/2013'
                    , 'mm/dd/yyyy' ))
   , PARTITION sales2013
        VALUES LESS THAN
           (TO_DATE ( '01/01/2014'
                    , 'mm/dd/yyyy' )) );



GRANT ALTER, DELETE,INSERT,UPDATE,SELECT ON fct_sales_dd TO u_sal_cl;


