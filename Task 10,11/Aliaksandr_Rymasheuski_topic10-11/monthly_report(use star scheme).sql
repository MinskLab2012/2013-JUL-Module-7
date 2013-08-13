  SELECT DECODE ( GROUPING_ID ( cr.brand
                              , geo.country_desc )
                , 1, ''
                , 3, 'Grant total'
                , geo.country_desc )
            ascustomer_country
       , DECODE ( GROUPING_ID ( cr.brand
                              , geo.country_desc )
                , 1, 'Total for ' || cr.brand
                , cr.brand )
            AS brand
       , TO_CHAR ( SUM ( sal.profit )
                 , '$999,999,999,999' )
            AS profit
       , SUM ( amount_sold )
    FROM fct_sales_dd sal
         JOIN dim_cars cr
            ON ( sal.car_id = cr.car_id )
         JOIN dim_geo_locations_scd geo
            ON ( sal.geo_surr_id = geo.geo_surr_id )
   WHERE TRUNC ( sal.event_dt
               , 'Month' ) = TO_DATE ( '7/1/2013'
                                     , 'MM/DD/YYYY' )
     AND sal.profit > 0
GROUP BY ROLLUP ( cr.brand, geo.country_desc );