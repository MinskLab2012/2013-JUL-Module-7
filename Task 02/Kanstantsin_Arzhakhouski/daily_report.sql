/* Formatted on 7/30/2013 3:32:03 PM (QP5 v5.139.911.3011) */
  SELECT DECODE ( GROUPING ( v.vehicle_type ), 1, 'Grand Total', v.vehicle_type ) vehicle_type
       , DECODE ( GROUPING ( v.vehicle_desc ), 1, 'Total by Class', v.vehicle_desc ) vehicle_desc
       , SUM ( f.fct_quantity ) quantity
       , ROUND ( SUM ( f.fct_amount ) ) amount_sold
    --   , GROUPING ( v.vehicle_type )
    --   , GROUPING ( v.vehicle_desc )
    FROM tmp_vehicles v
         JOIN tmp_transactions f
            ON v.vehicle_id = f.vehicle_id
         JOIN tmp_dealers d
            ON d.dealer_id = f.dealer_id
   WHERE d.dealer_country = 'Germany'
     AND TRUNC ( TO_DATE ( event_dt )
               , 'DDD' ) = TO_DATE ( '12-jan-2010'
                                   , 'dd-mon-yyyy' )
GROUP BY CUBE ( v.vehicle_type, v.vehicle_desc )
  HAVING GROUPING_ID ( v.vehicle_type
                     , v.vehicle_desc ) IN (0, 1, 3);