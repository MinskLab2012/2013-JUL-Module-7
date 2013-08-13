/* Formatted on 13.08.2013 16:35:53 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_star_load
AS
   PROCEDURE cls_dim_times_load_first
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_times';

      INSERT INTO cls_dim_times
         SELECT *
           FROM (SELECT TRUNC ( sd + rn ) time_id
                      , TO_CHAR ( sd + rn
                                , 'fmDay' )
                           day_name
                      , TO_CHAR ( sd + rn
                                , 'D' )
                           day_number_in_week
                      , TO_CHAR ( sd + rn
                                , 'DD' )
                           day_number_in_month
                      , TO_CHAR ( sd + rn
                                , 'DDD' )
                           day_number_in_year
                      , TO_CHAR ( sd + rn
                                , 'W' )
                           calendar_week_number
                      , ( CASE
                            WHEN TO_CHAR ( sd + rn
                                         , 'D' ) IN (1, 2, 3, 4, 5, 6) THEN
                               NEXT_DAY ( sd + rn
                                        , 'SATURDAY' )
                            ELSE
                               ( sd + rn )
                         END )
                           week_ending_date
                      , TO_CHAR ( sd + rn
                                , 'MM' )
                           calendar_month_number
                      , TO_CHAR ( LAST_DAY ( sd + rn )
                                , 'DD' )
                           days_in_cal_month
                      , LAST_DAY ( sd + rn ) end_of_cal_month
                      , TO_CHAR ( sd + rn
                                , 'FMMonth' )
                           calendar_month_name
                      , (  ( CASE
                               WHEN TO_CHAR ( sd + rn
                                            , 'Q' ) = 1 THEN
                                  TO_DATE ( '03/31/'
                                            || TO_CHAR ( sd + rn
                                                       , 'YYYY' )
                                          , 'MM/DD/YYYY' )
                               WHEN TO_CHAR ( sd + rn
                                            , 'Q' ) = 2 THEN
                                  TO_DATE ( '06/30/'
                                            || TO_CHAR ( sd + rn
                                                       , 'YYYY' )
                                          , 'MM/DD/YYYY' )
                               WHEN TO_CHAR ( sd + rn
                                            , 'Q' ) = 3 THEN
                                  TO_DATE ( '09/30/'
                                            || TO_CHAR ( sd + rn
                                                       , 'YYYY' )
                                          , 'MM/DD/YYYY' )
                               WHEN TO_CHAR ( sd + rn
                                            , 'Q' ) = 4 THEN
                                  TO_DATE ( '12/31/'
                                            || TO_CHAR ( sd + rn
                                                       , 'YYYY' )
                                          , 'MM/DD/YYYY' )
                            END )
                         - TRUNC ( sd + rn
                                 , 'Q' )
                         + 1 )
                           days_in_cal_quarter
                      , TRUNC ( sd + rn
                              , 'Q' )
                           beg_of_cal_quarter
                      , ( CASE
                            WHEN TO_CHAR ( sd + rn
                                         , 'Q' ) = 1 THEN
                               TO_DATE ( '03/31/'
                                         || TO_CHAR ( sd + rn
                                                    , 'YYYY' )
                                       , 'MM/DD/YYYY' )
                            WHEN TO_CHAR ( sd + rn
                                         , 'Q' ) = 2 THEN
                               TO_DATE ( '06/30/'
                                         || TO_CHAR ( sd + rn
                                                    , 'YYYY' )
                                       , 'MM/DD/YYYY' )
                            WHEN TO_CHAR ( sd + rn
                                         , 'Q' ) = 3 THEN
                               TO_DATE ( '09/30/'
                                         || TO_CHAR ( sd + rn
                                                    , 'YYYY' )
                                       , 'MM/DD/YYYY' )
                            WHEN TO_CHAR ( sd + rn
                                         , 'Q' ) = 4 THEN
                               TO_DATE ( '12/31/'
                                         || TO_CHAR ( sd + rn
                                                    , 'YYYY' )
                                       , 'MM/DD/YYYY' )
                         END )
                           end_of_cal_quarter
                      , TO_CHAR ( sd + rn
                                , 'Q' )
                           calendar_quarter_number
                      , TO_CHAR ( sd + rn
                                , 'YYYY' )
                           calendar_year
                      , ( TO_DATE ( '12/31/'
                                    || TO_CHAR ( sd + rn
                                               , 'YYYY' )
                                  , 'MM/DD/YYYY' )
                         - TRUNC ( sd + rn
                                 , 'YEAR' ) )
                           days_in_cal_year
                      , TRUNC ( sd + rn
                              , 'YEAR' )
                           beg_of_cal_year
                      , TO_DATE ( '12/31/'
                                  || TO_CHAR ( sd + rn
                                             , 'YYYY' )
                                , 'MM/DD/YYYY' )
                           end_of_cal_year
                   FROM (    SELECT TO_DATE ( '12/31/1995'
                                            , 'MM/DD/YYYY' )
                                       sd
                                  , ROWNUM rn
                               FROM DUAL
                         CONNECT BY LEVEL <= 10000))
          WHERE time_id < TO_DATE ( '01/01/2014'
                                  , 'MM/DD/YYYY' );

      COMMIT;
   END cls_dim_times_load_first;

   PROCEDURE dim_times_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE u_sal.dim_times';

      INSERT INTO u_sal.dim_times
         SELECT *
           FROM cls_dim_times;

      COMMIT;
   END dim_times_load;

   PROCEDURE cls_dim_customers_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_customers';

      INSERT INTO cls_dim_customers
         SELECT tc.customer_id
              , cust_desc
              , status_desc
              , country_desc
           FROM u_stg.t_customers tc
                INNER JOIN u_stg.lc_customers lcc
                   ON tc.customer_id = lcc.customer_id
                INNER JOIN u_stg.lc_cust_status lccs
                   ON lccs.status_id = tc.cust_status_id
                INNER JOIN u_stg.lc_countries tco
                   ON tco.geo_id = tc.geo_id;

      COMMIT;
   END cls_dim_customers_load;

   PROCEDURE dim_customers_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE u_sal.dim_customers';

      INSERT INTO u_sal.dim_customers
         SELECT *
           FROM cls_dim_customers;

      COMMIT;
   END dim_customers_load;

   PROCEDURE cls_dim_products_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_products';

      INSERT INTO cls_dim_products
         SELECT tp.product_id
              , product_name category_desc
              , measure_desc
              , cost
           FROM u_stg.t_products tp
                INNER JOIN u_stg.lc_products lcp
                   ON tp.product_id = lcp.product_id
                INNER JOIN u_stg.t_prod_category tpc
                   ON tp.prod_category_id = tpc.prod_category_id
                INNER JOIN u_stg.lc_prod_categories lpc
                   ON tp.prod_category_id = lpc.prod_category_id
                INNER JOIN u_stg.t_measures tm
                   ON tm.measure_id = tp.measure_id
          WHERE lpc.localization_id = 1
            AND t_l_localization_id = 1;

      COMMIT;
   END cls_dim_products_load;

   PROCEDURE dim_products_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE u_sal.dim_products';

      INSERT INTO u_sal.dim_products
         SELECT *
           FROM cls_dim_products;

      COMMIT;
   END dim_products_load;

   PROCEDURE cls_dim_geo_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_dim_geo';

      INSERT INTO cls_dim_geo
         WITH piv AS (SELECT *
                        FROM (    SELECT parent_geo_id AS geo_id
                                       , CONNECT_BY_ROOT child_geo_id AS roo
                                       , link_type_id
                                    FROM u_stg.t_geo_object_links gol
                              START WITH child_geo_id IN (SELECT geo_id
                                                            FROM u_stg.lc_countries)
                              CONNECT BY PRIOR parent_geo_id = child_geo_id) PIVOT (SUM ( geo_id )
                                                                             FOR link_type_id
                                                                             IN (2 AS l_2, 3 AS l_3)))
         SELECT lcc.geo_id AS country_geo_id
              , lcc.country_id
              , lcc.country_code_a3
              , lcc.country_desc AS country_desc
              , NVL ( lcr.geo_id, -99 ) AS region_geo_id
              , NVL ( lcr.region_id, -99 ) AS region_id
              , NVL ( lcr.region_desc, 'n.d.' ) AS region_desc
              , NVL ( lcp.geo_id, -99 ) AS part_geo_id
              , NVL ( lcp.part_id, -99 ) AS part_id
              , NVL ( lcp.part_desc, 'n.d.' ) AS part_desc
              , TO_CHAR ( TRUNC ( ( SELECT MAX ( action_dt )
                                      FROM u_stg.t_geo_object_actions tac
                                     WHERE tac.geo_id = piv.roo ) )
                        , 'DD-MON-YY' )
                   AS valid_from
              , TO_CHAR ( TRUNC ( SYSDATE )
                        , 'DD-MON-YY' )
                   AS valid_to
              , 'Y' AS is_actual
           FROM piv
                LEFT JOIN u_stg.lc_countries lcc
                   ON piv.roo = lcc.geo_id
                  AND lcc.localization_id = 1
                LEFT JOIN u_stg.lc_geo_regions lcr
                   ON lcr.geo_id = piv.l_3
                  AND lcr.localization_id = 1
                LEFT JOIN u_stg.lc_geo_parts lcp
                   ON lcp.geo_id = piv.l_2
                  AND lcp.localization_id = 1
                LEFT JOIN u_stg.t_geo_object_links gol
                   ON gol.child_geo_id = lcc.geo_id
                LEFT JOIN u_stg.t_geo_object_actions ta
                   ON ta.geo_id = lcc.geo_id
         UNION ALL
         SELECT lcc.geo_id AS country_geo_id
              , lcc.country_id
              , lcc.country_code_a3
              , lcc.country_desc AS country_desc
              , NVL ( lcr.geo_id, -99 ) AS region_geo_id
              , NVL ( lcr.region_id, -99 ) AS region_id
              , NVL ( lcr.region_desc, 'n.d.' ) AS region_desc
              , NVL ( lcp.geo_id, -99 ) AS part_geo_id
              , NVL ( lcp.part_id, -99 ) AS part_id
              , NVL ( lcp.part_desc, 'n.d.' ) AS part_desc
              , TO_CHAR ( TRUNC ( action_dt )
                        , 'DD-MON-YY' )
                   AS valid_from
              , TO_CHAR ( TRUNC ( action_dt )
                        , 'DD-MON-YY' )
                   AS valid_to
              , 'N' AS is_actual
           FROM piv
                INNER JOIN u_stg.t_geo_object_actions ta
                   ON ta.geo_id = piv.roo
                LEFT JOIN u_stg.lc_countries lcc
                   ON piv.roo = lcc.geo_id
                  AND lcc.localization_id = 1
                LEFT JOIN u_stg.t_geo_object_links gol
                   ON gol.child_geo_id = lcc.geo_id
                LEFT JOIN u_stg.lc_geo_regions lcr
                   ON lcr.geo_id = ta.v_old_int
                  AND lcr.localization_id = 1
                LEFT JOIN u_stg.lc_geo_parts lcp
                   ON lcp.geo_id = piv.l_2
                  AND lcp.localization_id = 1
          WHERE action_type != 'insert'
         ORDER BY country_geo_id
                , valid_from;

      COMMIT;
   END cls_dim_geo_load;

   PROCEDURE dim_geo_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE u_sal.dim_geo';

      INSERT INTO u_sal.dim_geo
         SELECT *
           FROM cls_dim_geo;

      COMMIT;
   END dim_geo_load;

   PROCEDURE cls_fct_daily_load_first
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_fct_daily';

      INSERT INTO cls_fct_daily
           SELECT TRUNC ( tor.event_dt ) AS event_dt
                , product_id
                , ord_geo_id
                , customer_id
                , SUM ( quantity ) AS quantity
                , SUM ( total_price ) AS amount_sold
             FROM u_stg.t_orders tor INNER JOIN u_stg.t_order_items toi ON tor.order_id = toi.order_id
            WHERE TRUNC ( tor.event_dt ) < TO_DATE ( '01/01/2013'
                                                   , 'dd/mm/yyyy' )
         GROUP BY TRUNC ( tor.event_dt )
                , product_id
                , ord_geo_id
                , customer_id;

      COMMIT;

      EXECUTE IMMEDIATE 'ALTER TABLE       
       U_SAL.FCT_INCOME_PRODUCTS_DAILY
       EXCHANGE PARTITION ARCH
       WITH TABLE cls_fct_daily';
   END cls_fct_daily_load_first;


   PROCEDURE cls_fct_daily_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_fct_daily';

      INSERT INTO cls_fct_daily
           SELECT TRUNC ( tor.event_dt ) AS event_dt
                , product_id
                , ord_geo_id
                , customer_id
                , SUM ( quantity ) AS quantity
                , SUM ( total_price ) AS amount_sold
             FROM u_stg.t_orders tor INNER JOIN u_stg.t_order_items toi ON tor.order_id = toi.order_id
            WHERE TRUNC ( tor.event_dt ) > TO_DATE ( '01/01/2013'
                                                   , 'dd/mm/yyyy' )
         GROUP BY TRUNC ( tor.event_dt )
                , product_id
                , ord_geo_id
                , customer_id;

      COMMIT;

      EXECUTE IMMEDIATE 'ALTER TABLE       
       U_SAL.FCT_INCOME_PRODUCTS_DAILY
       EXCHANGE PARTITION Y2013
       WITH TABLE cls_fct_daily';
   END cls_fct_daily_load;

   PROCEDURE cls_fct_monthly_load_first
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_fct_monthly';

      INSERT INTO cls_fct_monthly
           SELECT TRUNC ( tor.event_dt
                        , 'MONTH' )
                     AS event_dt
                , product_id
                , ord_geo_id
                , customer_id
                , SUM ( quantity ) AS quantity
                , SUM ( total_price ) AS amount_sold
             FROM u_stg.t_orders tor INNER JOIN u_stg.t_order_items toi ON tor.order_id = toi.order_id
            WHERE TRUNC ( tor.event_dt
                        , 'MONTH' ) < TO_DATE ( '01/01/2013'
                                              , 'dd/mm/yyyy' )
         GROUP BY TRUNC ( tor.event_dt
                        , 'MONTH' )
                , product_id
                , ord_geo_id
                , customer_id;

      COMMIT;

      EXECUTE IMMEDIATE 'ALTER TABLE       
       U_SAL.FCT_INCOME_PRODUCTS_MONTHLY
       EXCHANGE PARTITION ARCH
       WITH TABLE cls_fct_monthly';
   END cls_fct_monthly_load_first;

   PROCEDURE cls_fct_monthly_load
   AS
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_fct_monthly';

      INSERT INTO cls_fct_monthly
           SELECT TRUNC ( tor.event_dt
                        , 'MONTH' )
                     AS event_dt
                , product_id
                , ord_geo_id
                , customer_id
                , SUM ( quantity ) AS quantity
                , SUM ( total_price ) AS amount_sold
             FROM u_stg.t_orders tor INNER JOIN u_stg.t_order_items toi ON tor.order_id = toi.order_id
            WHERE TRUNC ( tor.event_dt
                        , 'MONTH' ) > TO_DATE ( '01/01/2013'
                                              , 'dd/mm/yyyy' )
         GROUP BY TRUNC ( tor.event_dt
                        , 'MONTH' )
                , product_id
                , ord_geo_id
                , customer_id;

      COMMIT;

      EXECUTE IMMEDIATE 'ALTER TABLE       
       u_sal.FCT_INCOME_PRODUCTS_MONTHLY
       EXCHANGE PARTITION Y2013
       WITH TABLE cls_fct_monthly';
   END cls_fct_monthly_load;
END pkg_star_load;