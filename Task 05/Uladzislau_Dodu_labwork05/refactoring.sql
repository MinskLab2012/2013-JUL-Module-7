/* Formatted on 8/6/2013 1:22:21 PM (QP5 v5.139.911.3011) */
WITH temp AS (  SELECT TO_CHAR ( TRUNC ( t.tran_id
                                       , 'MM' )
                               , 'Month' )
                          tran_id
                     , cust.company_name
                     , cust.cust_city
                     , p.port_identifier port_id
                     , AVG ( t.dep_goods / t.ar_goods ) * 100 pct
                     , SUM ( t.dep_goods * prod.income_coef ) income
                     , COUNT ( t.dep_goods ) cnt
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
                 WHERE TO_CHAR ( TRUNC ( t.tran_id
                                       , 'YYYY' )
                               , 'YYYY' ) = '2011'
                   AND TO_CHAR ( TRUNC ( t.tran_id
                                       , 'MM' )
                               , 'MM' ) = '01'
              GROUP BY t.tran_id
                     , cust.cust_city
                     , p.port_identifier
                     , cust.company_name)
SELECT tran_id month
     , company_name
     , pct
     , income
     , cnt
  FROM temp
MODEL
   DIMENSION BY ( tran_id, company_name, cust_city, port_id )
   MEASURES ( pct pct, income income, cnt cnt )
   RULES
      ( pct [FOR tran_id IN
                (SELECT tran_id
                   FROM temp), 'ALL_COMPANIES', NULL, NULL] = AVG ( pct )[CV ( tran_id ), company_name, ANY, ANY],
      pct ['TOTAL', NULL, NULL, NULL] = AVG ( pct )[ANY, ANY, ANY, ANY],
      income [FOR tran_id IN
                 (SELECT tran_id
                    FROM temp), 'ALL_COMPANIES', NULL, NULL] = SUM ( income )[CV ( tran_id ), company_name, ANY, ANY],
      income ['TOTAL', NULL, NULL, NULL] = SUM ( income )[ANY, ANY, ANY, ANY],
      cnt [FOR tran_id IN
              (SELECT tran_id
                 FROM temp), 'ALL_COMPANIES', NULL, NULL] = SUM ( pct )[CV ( tran_id ), company_name, ANY, ANY],
      cnt ['TOTAL', NULL, NULL, NULL] = COUNT ( pct )[ANY, ANY, ANY, ANY] );