---------------------------------------------------------------
CREATE MATERIALIZED VIEW u_dw.monthly
BUILD IMMEDIATE
AS
SELECT  customer_country
       ,  brand
       , SUM ( price - cost ) AS profit
       , COUNT ( * ) AS quantity
    FROM u_sa_data.contracts
   WHERE TRUNC ( event_dt
               , 'Month' ) = TO_DATE ( '7/1/2013'
                                     , 'MM/DD/YYYY' )
     AND cost < price
GROUP  BY brand, customer_country;



BEGIN
   dbms_mview.refresh ( 'monthly'
                      , 'c' );
END;

---------------------------------------------------------------

CREATE MATERIALIZED VIEW LOG ON u_sa_data.contracts
WITH ROWID, SEQUENCE (event_dt, customer_country, brand, price, cost )
INCLUDING NEW VALUES;
DROP MATERIALIZED VIEW u_dw.daily;
CREATE MATERIALIZED VIEW u_dw.daily
BUILD IMMEDIATE
REFRESH ON COMMIT
AS
 SELECT  customer_country
       ,  brand
       , SUM ( price - cost ) AS profit
       , COUNT(*) quantity
    FROM u_sa_data.contracts
   WHERE TRUNC ( event_dt
               , 'day' ) = TO_DATE ( '7/28/2013'
                                   , 'MM/DD/YYYY' )
     AND cost < price
GROUP BY  customer_country, brand;
---------------------------------------------------------------

  CREATE MATERIALIZED VIEW u_dw.monthly_model
  REFRESH START WITH SYSDATE NEXT  SYSDATE + 1/1440
  AS
  SELECT customer_country
       , brand
       , profit
       , quantity
    FROM u_sa_data.contracts
   WHERE TRUNC ( event_dt
               , 'Month' ) = TO_DATE ( '7/1/2013'
                                     , 'MM/DD/YYYY' )
     AND cost < price
GROUP BY customer_country
       , brand
MODEL
   DIMENSION BY ( customer_country, brand )
   MEASURES ( SUM ( price - cost ) profit, COUNT ( * ) quantity )
   RULES
      ( profit ['TOTAL FOR BRAND', FOR brand IN
                                      (SELECT DISTINCT brand
                                         FROM u_sa_data.contracts
                                        WHERE TRUNC ( event_dt
                                                    , 'Month' ) = TO_DATE ( '7/1/2013'
                                                                          , 'MM/DD/YYYY' )
                                          AND cost < price)] = SUM ( profit )[ANY, CV ( brand )],
      quantity ['TOTAL FOR BRAND', FOR brand IN
                                      (SELECT DISTINCT brand
                                         FROM u_sa_data.contracts
                                        WHERE TRUNC ( event_dt
                                                    , 'Month' ) = TO_DATE ( '7/1/2013'
                                                                          , 'MM/DD/YYYY' )
                                          AND cost < price)] = SUM ( quantity )[ANY, CV ( brand )],
      profit ['GRANT TOTAL', NULL] = SUM ( profit )['TOTAL FOR BRAND', ANY],
      quantity ['GRANT TOTAL', NULL] = SUM ( quantity )['TOTAL FOR BRAND', ANY] )
ORDER BY brand
       , profit;