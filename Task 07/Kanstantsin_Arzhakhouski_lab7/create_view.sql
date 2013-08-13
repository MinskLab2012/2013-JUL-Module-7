CREATE MATERIALIZED VIEW u_dw.monthly
BUILD IMMEDIATE
AS
SELECT DECODE ( GROUPING ( vt.vehicle_type_desc ), 1, 'Grand Total', vt.vehicle_type_desc ) vehicle_type_desc
       , DECODE ( GROUPING ( v.vehicle_desc ), 1, 'Total by Class', v.vehicle_desc ) vehicle_desc
       , SUM ( f.fct_quantity ) quantity
       , ROUND ( SUM ( f.fct_amount ) ) amount_sold
    FROM tmp_vehicles v
         JOIN tmp_delivery f
            ON v.vehicle_id = f.vehicle_id
         JOIN tmp_dealers d
            ON d.dealer_id = f.dealer_id
         JOIN tmp_vehicle_types vt
            ON v.vehicle_type_id = vt.vehicle_type_id
   WHERE d.dealer_country = 'Germany'
     AND f.event_dt >= TRUNC ( TO_DATE ( '01-jan-2013'
                                       , 'dd-mon-yyyy' )
                             , 'month' )
     AND f.event_dt <= (TRUNC ( TO_DATE ( ADD_MONTHS ( TO_DATE ( '01-jan-2013'
                                                               , 'dd-mon-yyyy' )
                                                     , 1 ) )
                              , 'month' )
                        - 1)
GROUP BY ROLLUP ( vt.vehicle_type_desc, v.vehicle_desc );