select vehicle_type_desc
, vehicle_desc
, sum(fct_quantity)
, sum(fct_amount)
, dense_rank() OVER (PARTITION BY vehicle_type_desc order by sum(fct_amount) desc) "Rank"
  from delivery
  where extract (year from event_dt) = 2013
group by vehicle_type_desc, vehicle_desc
order by vehicle_type_desc, sum(fct_amount) desc
;
