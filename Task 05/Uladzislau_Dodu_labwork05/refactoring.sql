/* Formatted on 8/6/2013 12:30:09 PM (QP5 v5.139.911.3011) */
WITH temp AS (  SELECT TO_CHAR ( TRUNC ( t.tran_id
                                       , 'MM' )
                               , 'Month' )
                          tran_id
                     , prod.prod_name
                     , cust.company_name
                     , AVG ( t.dep_goods / t.ar_goods ) * 100 pct
                     , SUM ( t.dep_goods * prod.income_coef ) income
                  FROM u_dw_ext_references.t_trans t
                       JOIN u_dw_ext_references.ext_products prod
                          ON ( t.prod_id = prod.prod_id )
                       JOIN u_dw_ext_references.ext_prod_categories cat
                          ON ( prod.prod_category_id = cat.prod_category_id )
                       JOIN u_dw_ext_references.ext_ship sh
                          ON ( t.ship_id = sh.ship_unique_identifier )
                       JOIN u_dw_ext_references.ports p
                          ON ( t.dep_port = p.port_identifier )
                       JOIN u_dw_ext_references.ports s
                          ON ( t.ar_port = s.port_identifier )
                       JOIN u_dw_ext_references.ext_insurances ins
                          ON ( t.ins_id = ins.unique_identifier )
                       JOIN u_dw_ext_references.ext_customers cust
                          ON ( t.cust_id = cust.customer_identifier )
              GROUP BY t.tran_id
                     , prod.prod_name
                     , cust.company_name)
SELECT *
  FROM temp
MODEL
   DIMENSION BY ( tran_id, company_name )
   MEASURES ( pct pct, income income )
   RULES
      ( pct [FOR tran_id IN
                (SELECT DISTINCT tran_id
                   FROM temp), NULL] = AVG ( pct )[CV ( tran_id ), ANY],
      pct ['TOTAL', NULL] = AVG ( pct )[ANY, ANY],
      income [FOR tran_id IN
                 (SELECT DISTINCT tran_id
                    FROM temp), NULL] = SUM ( income )[CV ( tran_id ), ANY],
      income ['TOTAL', NULL] = SUM ( income )[ANY, ANY] );