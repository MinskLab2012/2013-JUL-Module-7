select vehicle_type_desc
, vehicle_desc
, sum(fct_quantity)

, rank() OVER (PARTITION BY vehicle_type_desc order by sum(fct_quantity) desc) "Rank"
  from delivery
  where extract (year from event_dt) = 2013 and vehicle_type_desc = 'CLS-Class'
group by vehicle_type_desc, vehicle_desc
order by vehicle_type_desc, sum(fct_quantity) desc
;
