--daily
  SELECT customer_country
       , brand
       , TO_CHAR ( profit
                 , '$999,999,999,999' )
            AS profit
       , quantity
    FROM contracts
   WHERE TRUNC ( event_dt
               , 'day' ) = TO_DATE ( '7/28/2013'
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
                                         FROM contracts
                                        WHERE TRUNC ( event_dt
                                                    , 'day' ) = TO_DATE ( '7/28/2013'
                                                                        , 'MM/DD/YYYY' )
                                          AND cost < price)] = SUM ( profit )[ANY, CV ( brand )],
      quantity ['TOTAL FOR BRAND', FOR brand IN
                                      (SELECT DISTINCT brand
                                         FROM contracts
                                        WHERE TRUNC ( event_dt
                                                    , 'day' ) = TO_DATE ( '7/28/2013'
                                                                        , 'MM/DD/YYYY' )
                                          AND cost < price)] = SUM ( quantity )[ANY, CV ( brand )],
      profit ['GRANT TOTAL', NULL] = SUM ( profit )['TOTAL FOR BRAND', ANY],
      quantity ['GRANT TOTAL', NULL] = SUM ( quantity )['TOTAL FOR BRAND', ANY] )
ORDER BY brand
       , profit;


--monthly
  SELECT customer_country
       , brand
       , TO_CHAR ( profit
                 , '$999,999,999,999' )
            AS profit
       , quantity
    FROM contracts
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
                                         FROM contracts
                                        WHERE TRUNC ( event_dt
                                                    , 'Month' ) = TO_DATE ( '7/1/2013'
                                                                          , 'MM/DD/YYYY' )
                                          AND cost < price)] = SUM ( profit )[ANY, CV ( brand )],
      quantity ['TOTAL FOR BRAND', FOR brand IN
                                      (SELECT DISTINCT brand
                                         FROM contracts
                                        WHERE TRUNC ( event_dt
                                                    , 'Month' ) = TO_DATE ( '7/1/2013'
                                                                          , 'MM/DD/YYYY' )
                                          AND cost < price)] = SUM ( quantity )[ANY, CV ( brand )],
      profit ['GRANT TOTAL', NULL] = SUM ( profit )['TOTAL FOR BRAND', ANY],
      quantity ['GRANT TOTAL', NULL] = SUM ( quantity )['TOTAL FOR BRAND', ANY] )
ORDER BY brand
       , profit;