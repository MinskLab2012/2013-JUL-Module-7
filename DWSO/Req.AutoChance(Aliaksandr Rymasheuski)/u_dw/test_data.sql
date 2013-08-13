/* Formatted on 8/6/2013 2:09:08 PM (QP5 v5.139.911.3011) */
--brands

( SELECT brand_code
       , brand_desc
    FROM u_dw.brands
 MINUS
 SELECT id
      , mark
   FROM u_sa_data.tmp_brands )
UNION ALL
( SELECT id
       , mark
    FROM u_sa_data.tmp_brands
 MINUS
 SELECT brand_code
      , brand_desc
   FROM u_dw.brands );


--models

( SELECT model_code
       , brand_id
       , model_desc
    FROM u_dw.models
 MINUS
 SELECT mb.id
      , br.brand_id
      , mb.model
   FROM u_sa_data.tmp_models mb JOIN u_dw.brands br ON ( mb.mark_id = br.brand_code ) )
UNION ALL
( SELECT mb.id
       , br.brand_id
       , mb.model
    FROM u_sa_data.tmp_models mb JOIN u_dw.brands br ON ( mb.mark_id = br.brand_code )
 MINUS
 SELECT model_code
      , brand_id
      , model_desc
   FROM u_dw.models );

--cars

( SELECT car_code
       , car_stand_number
       , year_of_production
       , model_id
       , color
       , date_of_purchase
       , country
       , cost
       , status
    FROM u_dw.cars
 MINUS
 SELECT cr.car_id
      , cr.cat_stand_num
      , cr.year_of_production
      , md.model_id
      , cr.color
      , cr.date_of_purchase
      , cr.country
      , cr.cost
      , cr.status
   FROM u_sa_data.tmp_cars cr JOIN u_dw.models md ON ( cr.model_id = md.model_code ) )
UNION ALL
( SELECT cr.car_id
       , cr.cat_stand_num
       , cr.year_of_production
       , md.model_id
       , cr.color
       , cr.date_of_purchase
       , cr.country
       , cr.cost
       , cr.status
    FROM u_sa_data.tmp_cars cr JOIN u_dw.models md ON ( cr.model_id = md.model_code )
 MINUS
 SELECT car_code
      , car_stand_number
      , year_of_production
      , model_id
      , color
      , date_of_purchase
      , country
      , cost
      , status
   FROM u_dw.cars );


--cities

( SELECT city_desc
       , country_geo_id
    FROM u_dw.cities
 MINUS
 SELECT cc.capital
      , geo.geo_id
   FROM u_sa_data.tmp_countries_city cc JOIN u_dw_references.lc_countries geo ON ( cc.country = geo.country_desc ) )
UNION ALL
( SELECT cc.capital
       , geo.geo_id
    FROM u_sa_data.tmp_countries_city cc JOIN u_dw_references.lc_countries geo ON ( cc.country = geo.country_desc )
 MINUS
 SELECT city_desc
      , country_geo_id
   FROM u_dw.cities );



   --offices

( SELECT office_code
       , city_id
       , office_adress
    FROM u_dw.offices
 MINUS
 SELECT DISTINCT emp.office_id
               , ct.city_id
               , emp.adress
   FROM u_sa_data.tmp_employees emp JOIN u_dw.cities ct ON ( emp.office_city = ct.city_desc ) )
UNION ALL
( SELECT DISTINCT emp.office_id
                , ct.city_id
                , emp.adress
    FROM u_sa_data.tmp_employees emp JOIN u_dw.cities ct ON ( emp.office_city = ct.city_desc )
 MINUS
 SELECT office_code
      , city_id
      , office_adress
   FROM u_dw.offices );

   --employees

( SELECT emp_code
       , first_name
       , last_name
       , position
       , office_id
       , gender
       , salary
    FROM u_dw.employees
 MINUS
 SELECT emp.emp_id
      , emp.first_name
      , emp.last_name
      , emp.position
      , o.office_id
      , emp.gender
      , emp.salary
   FROM u_sa_data.tmp_employees emp JOIN u_dw.offices o ON ( emp.office_id = o.office_code ) )
UNION ALL
( SELECT emp.emp_id
       , emp.first_name
       , emp.last_name
       , emp.position
       , o.office_id
       , emp.gender
       , emp.salary
    FROM u_sa_data.tmp_employees emp JOIN u_dw.offices o ON ( emp.office_id = o.office_code )
 MINUS
 SELECT emp_code
      , first_name
      , last_name
      , position
      , office_id
      , gender
      , salary
   FROM u_dw.employees );

   --customers

( SELECT cust_code
       , passport_number
       , first_name
       , last_name
       , city_id
       , adress
       , gender
    FROM u_dw.customers
 MINUS
 SELECT cust.cust_id
      , cust.passport_number
      , cust.first_name
      , cust.last_name
      , ct.city_id
      , cust.adress
      , cust.gender
   FROM u_sa_data.tmp_customers cust JOIN u_dw.cities ct ON ( cust.city = ct.city_desc ) )
UNION ALL
( SELECT cust.cust_id
       , cust.passport_number
       , cust.first_name
       , cust.last_name
       , ct.city_id
       , cust.adress
       , cust.gender
    FROM u_sa_data.tmp_customers cust JOIN u_dw.cities ct ON ( cust.city = ct.city_desc )
 MINUS
 SELECT cust_code
      , passport_number
      , first_name
      , last_name
      , city_id
      , adress
      , gender
   FROM u_dw.customers );