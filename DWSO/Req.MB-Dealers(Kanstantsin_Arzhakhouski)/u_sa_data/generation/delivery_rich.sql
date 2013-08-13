CREATE TABLE delivery AS
SELECT del.event_dt,
  del.delivery_id,
  d.dealer_id,
  d.dealer_name,
  d.dealer_country,
  d.dealer_city,
  d.dealer_address,
  v.vehicle_id,
  vt.vehicle_type_desc,
  v.vehicle_desc,
  v.vehicle_price,
  del.fct_quantity,
  del.fct_amount
FROM tmp_dealers d
JOIN tmp_delivery del
ON del.dealer_id = d.dealer_id
JOIN tmp_vehicles v
ON v.vehicle_id = del.vehicle_id
join tmp_vehicle_types vt on vt.vehicle_type_id = v.vehicle_type_id;