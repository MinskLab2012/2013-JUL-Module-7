--TO CURSOR_NUMBER
CREATE OR REPLACE PACKAGE BODY orders_load
AS
   PROCEDURE ins_upd
   AS
      TYPE REC IS RECORD (event  DATE
                      , code VARCHAR2(50)
                      , geo NUMBER (20)
                      , cust_id NUMBER (20)
                      , sold NUMBER (20,2));
      rec_str rec;
      TYPE t_rec IS TABLE OF rec;
      
      ord_rec t_rec; 


      stmt           VARCHAR ( 300 );
      run_ex         NUMBER;
      cur_id         NUMBER;
      col_cnt NUMBER;
      desctab DBMS_SQL.DESC_TAB;


      TYPE type_cur IS REF CURSOR;

      ref_cur        type_cur;

   BEGIN
      stmt := 'SELECT /*+ parallel(tor, 4)*/  DISTINCT TOR.EVENT_DT, TOR.ORDER_CODE, lc.geo_id, lcs.customer_id,TOR.TOTAL_PRICE 
      FROM t_orders tor INNER JOIN u_stg.lc_countries lc ON lc.country_code_a3 = TOR.COUNTRY_CODE INNER JOIN u_stg.t_customers lcs  ON LCS.CUST_CODE = TOR.COMPANY_CODE '        ;
      
      OPEN ref_cur FOR stmt;
      
      cur_id := DBMS_SQL.TO_CURSOR_NUMBER (ref_cur);
--      DBMS_SQL.DESCRIBE_COLUMNS (cur_id, col_cnt, desctab);
      DBMS_SQL.DEFINE_COLUMN (cur_id, 1, rec_str.event);
      DBMS_SQL.DEFINE_COLUMN (cur_id, 2, rec_str.code, 50);
      DBMS_SQL.DEFINE_COLUMN (cur_id, 3, rec_str.geo); 
      DBMS_SQL.DEFINE_COLUMN (cur_id, 4, rec_str.cust_id);
      DBMS_SQL.DEFINE_COLUMN (cur_id, 5, rec_str.sold);     
      
      WHILE DBMS_SQL.FETCH_ROWS(cur_id) > 0 LOOP
           
                    DBMS_SQL.COLUMN_VALUE (cur_id, 1, rec_str.event );
                    DBMS_SQL.COLUMN_VALUE (cur_id, 2, rec_str.code );
                    DBMS_SQL.COLUMN_VALUE (cur_id, 3, rec_str.geo );
                    DBMS_SQL.COLUMN_VALUE (cur_id, 4, rec_str.cust_id );
                    DBMS_SQL.COLUMN_VALUE (cur_id, 5, rec_str.sold );
            
            INSERT INTO u_stg.t_orders
            VALUES ( rec_str.event
            ,u_stg.SQ_ORDER_ID.NEXTVAL
                   , rec_str.code
                   , rec_str.geo
                   , rec_str.cust_id
                   , SYSDATE
                   , rec_str.sold);
      END LOOP;
      commit;
DBMS_SQL.CLOSE_CURSOR (cur_id);


   END ins_upd;
END orders_load;
/