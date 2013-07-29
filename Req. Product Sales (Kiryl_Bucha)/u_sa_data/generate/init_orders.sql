create table ORDERS as 
SELECT --+ORDERED
      i.event_dt
     , i.oper_num
     , cntr.cntr_desc
     , prd.product_name
     , prd.product_brand
     , prd.product_group
     , cust.first_name
     , cust.last_name
     , cust.birth_day
     , cust.cntr_desc AS address
     , i.costs
  FROM tmp_opers i
     , (SELECT ROWNUM AS rn
             , i.cntr_desc
          FROM (  SELECT cntr.region_desc cntr_desc
                    FROM u_dw_references.cu_countries cntr
                ORDER BY region_desc) i) cntr
     , (SELECT ROWNUM AS rn
             , product_name
             , product_brand
             , product_group
          FROM (SELECT product_name
                     , product_brand
                     , product_group
                  FROM tmp_products) i) prd
     , (SELECT ROWNUM AS rn
             , first_name
             , last_name
             , birth_day
             , cntr_desc
          FROM (SELECT first_name
                     , last_name
                     , birth_day
                     , cntr_desc
                  FROM tmp_customers) i) cust
 WHERE cntr.rn = i.cntr_num
   AND prd.rn = i.product_num
   AND cust.rn = i.people_num