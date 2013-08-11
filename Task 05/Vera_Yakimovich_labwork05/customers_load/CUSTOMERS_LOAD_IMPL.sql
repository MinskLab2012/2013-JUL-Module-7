/* Formatted on 05.08.2013 14:42:51 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY customers_load
AS
   PROCEDURE ins_upd
   AS
      TYPE t_code IS TABLE OF t_orders.company_code%TYPE;

      TYPE t_name IS TABLE OF t_orders.company_name%TYPE;

      TYPE t_geo IS TABLE OF u_stg.lc_countries.geo_id%TYPE;

      TYPE t_stat IS TABLE OF u_stg.lc_cust_status.status_id%TYPE;


      tab_code       t_code;
      tab_name       t_name;
      tab_geo        t_geo;
      tab_stat       t_stat;



      stmt           VARCHAR ( 300 );
      run_ex         NUMBER;
      cur_id         NUMBER;



      TYPE type_cur IS REF CURSOR;

      ref_cur        type_cur;
      upd            type_cur;
   BEGIN
      OPEN ref_cur FOR
         SELECT /*+ parallel(tor, 4)*/
               DISTINCT tor.company_code
                      , tor.company_name
                      , geo_id
                      , lcs.status_id
           FROM t_orders tor
                INNER JOIN u_stg.lc_countries lc
                   ON lc.country_code_a3 = tor.comp_country_code
                INNER JOIN u_stg.lc_cust_status lcs
                   ON lcs.status_code = tor.comp_status_code
                LEFT JOIN u_stg.t_cust_status tcs
                   ON tcs.status_code = tor.company_code
          WHERE company_code IS NOT NULL;


      LOOP
         FETCH ref_cur
         BULK COLLECT INTO tab_code, tab_name, tab_geo, tab_stat
         LIMIT 1000;

         FORALL i IN 1 .. tab_code.COUNT
            INSERT ALL
              INTO u_stg.t_customers
            VALUES ( u_stg.sq_cust_id.NEXTVAL
                   , tab_code ( i )
                   , tab_geo ( i )
                   , tab_stat ( i )
                   , SYSDATE
                   , '' )
              INTO u_stg.lc_customers
            VALUES ( u_stg.sq_prod_id.CURRVAL
                   , tab_code ( i )
                   , tab_name ( i )
                   , 1
                   , SYSDATE
                   , '' )
               SELECT tab_code ( i )
                    , tab_name ( i )
                    , tab_geo ( i )
                    , tab_stat ( i )
                 FROM DUAL;

         COMMIT;
         EXIT WHEN ref_cur%NOTFOUND;
      END LOOP;

      COMMIT;

      CLOSE ref_cur;

      stmt        := 'SELECT  cust_code
              , lc.cust_desc
           FROM u_stg.lc_customers lc
         MINUS
         SELECT /*+ parallel(tor, 4)*/  DISTINCT TOR.COMPANY_CODE
                       ,  TOR.COMPANY_NAME
           FROM t_orders tor';
      cur_id      := dbms_sql.open_cursor;
      dbms_sql.parse ( cur_id
                     , stmt
                     , dbms_sql.native );
      run_ex      := dbms_sql.execute ( cur_id );
      upd         := dbms_sql.to_refcursor ( cur_id );

      LOOP
         FETCH upd
         BULK COLLECT INTO tab_code, tab_name
         LIMIT 1000;

         FORALL j IN 1 .. tab_code.COUNT
            UPDATE u_stg.lc_products
               SET product_name = tab_name ( j )
                 , update_dt    = SYSDATE
             WHERE product_code = tab_code ( j );

         EXIT WHEN upd%NOTFOUND;
      END LOOP;

      CLOSE upd;
      
      COMMIT;
   END ins_upd;
END customers_load;
/