/* Formatted on 7/30/2013 5:09:32 PM (QP5 v5.139.911.3011) */
CREATE TABLE agr_trans
AS
     SELECT event_dt
          , prod_id
          , prod_name
          , prod_desc
          , prod_category_id
          , prod_category
          , prod_category_desc
          , ship_id
          , ins_id
          , risk_type
          , ins_cost
          , company_name
          , cust_country
          , cust_city
          , ar_port
          , ar_port_city
          , ar_port_country
          , ar_time
          , dep_port
          , dep_port_city
          , dep_port_country
          , dep_time
          , ROUND ( AVG ( pct )
                  , 2 )
               avg_pct
          , SUM ( income ) sum_income
          , COUNT ( income ) count_trans
       FROM (SELECT TRUNC ( t.tran_id
                          , 'Month' )
                       event_dt
                  , prod.prod_id
                  , prod.prod_name
                  , prod.prod_desc
                  , cat.prod_category_id
                  , cat.prod_category
                  , cat.prod_category_desc
                  , t.ship_id
                  , t.ins_id
                  , ins.risk_type
                  , ins.ins_cost
                  , cust.company_name
                  , cust.cust_country
                  , cust.cust_city
                  , t.ar_port
                  , p.cust_city ar_port_city
                  , p.cust_region ar_port_country
                  , t.ar_time
                  , t.dep_port
                  , p.cust_city dep_port_city
                  , p.cust_region dep_port_country
                  , t.dep_time
                  , t.dep_goods / t.ar_goods * 100 pct
                  , t.dep_goods * prod.income_coef income
               FROM t_trans t
                    JOIN ext_products prod
                       ON ( t.prod_id = prod.prod_id )
                    JOIN ext_prod_categories cat
                       ON ( prod.prod_category_id = cat.prod_category_id )
                    JOIN ext_ship sh
                       ON ( t.ship_id = sh.ship_unique_identifier )
                    JOIN ports p
                       ON ( t.dep_port = p.port_identifier )
                    JOIN ports s
                       ON ( t.ar_port = s.port_identifier )
                    JOIN ext_insurances ins
                       ON ( t.ins_id = ins.unique_identifier )
                    JOIN ext_customers cust
                       ON ( t.cust_id = cust.customer_identifier ))
   GROUP BY event_dt
          , prod_id
          , prod_name
          , prod_desc
          , prod_category_id
          , prod_category
          , prod_category_desc
          , ship_id
          , ins_id
          , risk_type
          , ins_cost
          , company_name
          , cust_country
          , cust_city
          , ar_port
          , ar_port_city
          , ar_port_country
          , ar_time
          , dep_port
          , dep_port_city
          , dep_port_country
          , dep_time;