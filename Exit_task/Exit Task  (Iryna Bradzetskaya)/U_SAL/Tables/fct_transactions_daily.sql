DROP TABLE fct_transactions_daily;


CREATE TABLE fct_transactions_daily
(
   event_dt       DATE NULL
 , cust_send_id   NUMBER NULL
 , cus_rec_id     NUMBER NULL
 , geo_send_sur_id NUMBER NULL
 , geo_rec_sur_id NUMBER NULL
 , currency_sur_id NUMBER NULL
 , operation_id   NUMBER NULL
 , tariff_id      NUMBER NULL
 , period_id      NUMBER NULL
 , amount_payment NUMBER NULL
 , count_payment  NUMBER NULL
 , ta_country_send_id NUMBER NULL
 , ta_country_rec_id NUMBER NULL
 , insert_dt      DATE NULL
)
PARTITION BY RANGE (event_dt)
   ( PARTITION part1999
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2000'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2000
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2001'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2001
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2002'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2002
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2003'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2003
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2004'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2004
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2005'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2005
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2006'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2006
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2007'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2007
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2008'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2008
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2009'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2009
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2010'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2010
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2011'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2011
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2012'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2012
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2013'
                    , 'dd-mon-yyyy' ))
   , PARTITION part2013
        VALUES LESS THAN
           (TO_DATE ( '01-JAN-2014'
                    , 'dd-mon-yyyy' )) );