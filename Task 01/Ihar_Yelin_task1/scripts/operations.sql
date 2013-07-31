/* Formatted on 7/30/2013 9:33:55 PM (QP5 v5.139.911.3011) */
CREATE TABLE tranz
AS
       SELECT TO_DATE ( TRUNC ( dbms_random.VALUE ( 2452000
                                                  , 2456293 ) )
                      , 'j' )
                 AS event_date
            , ROUND ( dbms_random.VALUE ( ( SELECT MIN ( cust_id )
                                              FROM clients )
                                        , ( SELECT MAX ( cust_id )
                                              FROM clients ) ) )
                 client_id
            , ROUND ( dbms_random.VALUE ( ( SELECT MIN ( deliv_id )
                                              FROM delivery )
                                        , ( SELECT MAX ( deliv_id )
                                              FROM delivery ) ) )
                 deliv_id
            , ROUND ( dbms_random.VALUE ( ( SELECT MIN ( prod_id )
                                              FROM products )
                                        , ( SELECT MAX ( prod_id )
                                              FROM products ) ) )
                 prod_id
            , ROUND ( dbms_random.VALUE ( ( SELECT MIN ( employee_id )
                                              FROM structure )
                                        , ( SELECT MAX ( employee_id )
                                              FROM structure ) ) )
                 struct_id
            , ROUND ( dbms_random.VALUE ( ( SELECT MIN ( suppl_id )
                                              FROM suppliers )
                                        , ( SELECT MAX ( suppl_id )
                                              FROM suppliers ) ) )
                 suppl_id
         FROM DUAL
   CONNECT BY ROWNUM < 1000000;

/* Formatted on 7/30/2013 9:35:39 PM (QP5 v5.139.911.3011) */
CREATE TABLE operations
AS
   SELECT /*+NO_MERGE ORDERED */
         tr.event_date
        , cl.cust_first_name || ' ' || cl.cust_last_name client
        , cl.cust_city
        , cl.country_name client_country
        , pr.prod_name
        , pr.prod_category
        , pr.prod_list_price
        , del.deliv_category
        , del.deliv_cost
        , st.first_name || ' ' || st.last_name employee
        , st.department_name
        , st.city
        , su.des
        , su.country_name supplier_country
        , ROUND ( ( pr.prod_list_price
                   * ROUND ( dbms_random.VALUE ( 0
                                               , 1 )
                           , 2 )
                   + del.deliv_cost )
                , 2 )
             amount_sold
     FROM tranz tr
          LEFT JOIN clients cl
             ON tr.client_id = cl.cust_id
          JOIN delivery del
             ON tr.deliv_id = del.deliv_id
          JOIN prod pr
             ON tr.prod_id = pr.prod_id
          JOIN structures st
             ON tr.struct_id = st.employee_id
          JOIN suppliers su
             ON tr.suppl_id = su.suppl_id;