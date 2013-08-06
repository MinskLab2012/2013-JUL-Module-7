/* Formatted on 8/6/2013 6:49:10 PM (QP5 v5.139.911.3011) */
CREATE MATERIALIZED VIEW LOG ON u_dw_ext_references.agr_trans
WITH PRIMARY KEY
INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON u_dw_ext_references.t_trans
WITH rowid
INCLUDING NEW VALUES;


-----task3--------------------------------


create materialized view v_agr_trans_1
build immediate
refresh start with sysdate next (sysdate + 1/180)
as
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



      -------------------task2------------------
      CREATE MATERIALIZED VIEW v_agr_trans_2
BUILD IMMEDIATE
REFRESH ON COMMIT
 AS
  SELECT a_id,event_dt,
       company_name
        , AVG ( avg_pct )
                avg_pct
       , COUNT (avg_pct) avg_i
       , SUM ( sum_income ) sum_income
       , COUNT(sum_income) summ
       , COUNT ( count_trans ) count_trans
    FROM u_dw_ext_references.agr_trans
GROUP BY  a_id,event_dt, company_name;

--------task1-------------------
CREATE MATERIALIZED VIEW v_agr_trans_3
BUILD immediate as

  SELECT event_dt
       , company_name
       , ROUND ( AVG ( avg_pct )
               , 2 )
            avg_pct
       , SUM ( sum_income ) sum_income
       , COUNT ( count_trans ) count_trans
    FROM u_dw_ext_references.agr_trans
GROUP BY event_dt
       , company_name;