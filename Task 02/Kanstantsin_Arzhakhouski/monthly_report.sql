/* Formatted on 7/30/2013 3:20:35 PM (QP5 v5.139.911.3011) */
  SELECT DECODE ( GROUPING ( v.vehicle_type ), 1, 'Grand Total', v.vehicle_type ) vehicle_type
       , DECODE ( GROUPING ( v.vehicle_desc ), 1, 'Total by Class', v.vehicle_desc ) vehicle_desc
       , SUM ( f.fct_quantity ) quantity
       , ROUND ( SUM ( f.fct_amount ) ) amount_sold
       , GROUPING ( v.vehicle_type )
       , GROUPING ( v.vehicle_desc )
    FROM tmp_vehicles v
         JOIN tmp_transactions f
            ON v.vehicle_id = f.vehicle_id
         JOIN tmp_dealers d
            ON d.dealer_id = f.dealer_id
   WHERE d.dealer_country = 'Germany'
     AND f.event_dt >= TRUNC ( TO_DATE ( '01-jan-2013'
                                       , 'dd-mon-yyyy' )
                             , 'month' )
     AND f.event_dt <= (TRUNC ( TO_DATE ( ADD_MONTHS ( TO_DATE ( '01-jan-2013'
                                                               , 'dd-mon-yyyy' )
                                                     , 1 ) )
                              , 'month' )
                        - 1)
GROUP BY ROLLUP ( v.vehicle_type, v.vehicle_desc )
;