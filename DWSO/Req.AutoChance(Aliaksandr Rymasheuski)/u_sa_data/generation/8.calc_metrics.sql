  SELECT TRUNC ( cont.event_dt
               , 'day' )
            event_dt
       , cont.contract_number
       , cont.car_id
       , cont.cust_id
       , cont.emp_id
       , SUM ( cont.price ) price
       , SUM ( cont.price - cr.cost ) profit
    FROM tmp_contracts cont
       , tmp_cars cr
   WHERE cont.car_id = cr.car_id
GROUP BY event_dt
       , cont.contract_number
       , cont.car_id
       , cont.cust_id
       , cont.emp_id
ORDER BY event_dt;