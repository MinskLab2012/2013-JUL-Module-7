/* Formatted on 12.08.2013 6:38:59 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_orders_load

AS
   PROCEDURE orders_load
   AS
      TYPE rec IS RECORD
   (
      event          DATE
    , code           VARCHAR2 ( 50 )
    , geo            NUMBER ( 20 )
    , cust_id        NUMBER ( 20 )
   );

      rec_str        rec;

      TYPE t_rec IS TABLE OF rec;

      ord_rec        t_rec;


      stmt           VARCHAR ( 300 );


      TYPE type_cur IS REF CURSOR;

      ref_cur        type_cur;
   BEGIN
      stmt        :=
         'SELECT /*+ parallel(tor, 4)*/  DISTINCT TOR.EVENT_DT, TOR.ORDER_CODE, lc.geo_id, lcs.customer_id
      FROM t_orders tor INNER JOIN u_stg.vl_countries lc ON lc.country_code_a3 = TOR.COUNTRY_CODE INNER JOIN u_stg.t_customers lcs  ON LCS.CUST_CODE = TOR.COMPANY_CODE ';

      OPEN ref_cur FOR stmt;

      LOOP
         FETCH ref_cur
         BULK COLLECT INTO ord_rec
         LIMIT 1000;

         FORALL i IN 1 .. ord_rec.COUNT
            INSERT /* APPEND PARALLEL (u_stg.t_orders,2) */
                   ALL
              INTO u_stg.t_orders
            VALUES ( ord_rec ( i ).event
                   , u_stg.sq_order_id.NEXTVAL
                   , ord_rec ( i ).code
                   , ord_rec ( i ).geo
                   , ord_rec ( i ).cust_id
                   , SYSDATE )
               SELECT ord_rec ( i ).code
                    , ord_rec ( i ).geo
                    , ord_rec ( i ).cust_id
                 FROM DUAL;



         COMMIT;
         EXIT WHEN ref_cur%NOTFOUND;
      END LOOP;

      --
      CLOSE ref_cur;
   END orders_load;

   PROCEDURE order_items_load
   AS
      TYPE rec IS RECORD
   (
      event          DATE
    , ord_id         VARCHAR2 ( 50 )
    , prod_id        NUMBER ( 20 )
    , quant          NUMBER ( 10 )
    , total_price    NUMBER ( 20, 2 )
   );

      rec_str        rec;

      TYPE t_rec IS TABLE OF rec;

      ord_rec        t_rec;


      stmt           VARCHAR ( 400 );


      TYPE type_cur IS REF CURSOR;

      ref_cur        type_cur;
   BEGIN
      stmt        :=
         'select /*+ parallel(tor, 2)*/    tor.event_dt, order_id, product_id, tor.set_quantity, tor.total_price
            from t_orders tor left join u_stg.t_products tp on tp.product_code = tor.product_code left join u_stg.t_orders tord on tord.order_code = tor.order_code
      where order_id is NOT NULL and product_id is NOT NULL';

      OPEN ref_cur FOR stmt;

      LOOP
         FETCH ref_cur
         BULK COLLECT INTO ord_rec
         LIMIT 1000;

         FORALL i IN 1 .. ord_rec.COUNT
            INSERT /* APPEND PARALLEL (u_stg.t_orders,2) */
                   ALL
              INTO u_stg.t_order_items
            VALUES ( ord_rec ( i ).event
                   , u_stg.sq_order_item_id.NEXTVAL
                   , ord_rec ( i ).ord_id
                   , ord_rec ( i ).prod_id
                   , ord_rec ( i ).quant
                   , SYSDATE
                   , ord_rec ( i ).total_price )
               SELECT ord_rec ( i ).event
                    , ord_rec ( i ).ord_id
                    , ord_rec ( i ).prod_id
                    , ord_rec ( i ).quant
                    , ord_rec ( i ).total_price
                 FROM DUAL;



         COMMIT;
         EXIT WHEN ref_cur%NOTFOUND;
      END LOOP;


      CLOSE ref_cur;
   END order_items_load;
END pkg_orders_load;
/