/* Formatted on 7/29/2013 6:38:01 PM (QP5 v5.139.911.3011) */
-- select * from tmp_dealers;

CREATE TABLE tmp_dealers
AS
     SELECT ROWNUM AS dealer_id
          , UPPER (   SUBSTR ( country
                             , 1
                             , 4 )
                   || ' '
                   || SUBSTR ( country
                             , 15
                             , 1 ) )
            || ' MB-Cars'
               AS dealer_name
          , country AS dealer_country
          , capital AS dealer_city
          ,    SUBSTR ( SUBSTR ( capital
                               , 1
                               , 3 )
                        || SUBSTR ( country
                                  , 3 )
                      , 1
                      , 6 )
            || ' Str. '
            || ROUND ( dbms_random.VALUE ( 1
                                         , 241 ) )
               AS dealer_address
       FROM lc_countries2
   ORDER BY 1;