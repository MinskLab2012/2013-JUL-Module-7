CREATE TABLE contracts
AS
SELECT cont.event_dt
     , cont.contract_number
     , cont.car_id
     , cr.cat_stand_num
     , cr.brand_id
     , cr.brand
     , cr.model_id
     , cr.model
     , cr.year_of_production
     , cr.color
     , cr.date_of_purchase
     , cr.country
     , cr.cost
     , cr.status
     , cont.cust_id
     , cust.passport_number
     , cust.first_name AS customer_first_name
     , cust.last_name AS customer_last_name
     , cust.country AS customer_country
     , cust.city AS customer_city
     , cust.adress AS customer_adress
     , cust.gender AS customer_gender
     , cont.emp_id
     , emp.first_name AS emp_first_name
     , emp.last_name AS emp_last_name
     , emp.gender AS emp_gender
     , emp.position AS emp_position
     , emp.office_id
     , emp.office_country
     , emp.office_city
     , emp.adress AS office_adress
     , cont.price
  FROM tmp_contracts cont
     , tmp_cars cr
     , tmp_customers cust
     , tmp_employees emp
 WHERE cont.car_id = cr.car_id
   AND cont.cust_id = cust.cust_id
   AND cont.emp_id = emp.emp_id;
   commit;
   