/* Formatted on 12.08.2013 21:30:36 (QP5 v5.139.911.3011) */
DECLARE
   stmt           VARCHAR2 ( 400 );

   TYPE empcurtyp IS REF CURSOR;

   v_cursor       empcurtyp;

   CURSOR cust_ins
   IS
      SELECT DISTINCT comp_status_code
        FROM t_orders
      MINUS
      SELECT TRIM ( status_code )
        FROM u_stg.t_cust_status;

   CURSOR cust_upd
   IS
      SELECT status_code AS code
           , status_desc
        FROM u_stg.lc_cust_status
      MINUS
      SELECT comp_status_code
           , comp_status
        FROM t_orders;

   TYPE rec_st IS TABLE OF t_orders.comp_status%TYPE;

   rec_stat       rec_st;
   rec_stat_ins   t_orders.comp_status_code%TYPE;
   rec_stat_upd   cust_upd%ROWTYPE;
BEGIN
   stmt        := 'SELECT DISTINCT comp_status
        FROM t_orders
       WHERE comp_status_code = status_code';

   OPEN cust_ins;

   LOOP
      FETCH cust_ins
      INTO rec_stat_ins;

      EXIT WHEN cust_ins%NOTFOUND;

      OPEN v_cursor FOR stmt USING rec_stat_ins;

      FETCH v_cursor
      BULK COLLECT INTO rec_stat;

      FORALL i IN 1 .. rec_stat.COUNT
         INSERT ALL
           INTO u_stg.t_cust_status
         VALUES ( u_stg.sq_cust_stat_id.NEXTVAL
                , rec_stat_ins
                , SYSDATE
                , NULL )
           INTO u_stg.lc_cust_status
         VALUES ( u_stg.sq_cust_stat_id.CURRVAL
                , rec_stat_ins
                , rec_stat ( i )
                , 1 )
            SELECT rec_stat ( i )
              FROM DUAL;

      CLOSE v_cursor;
   END LOOP;

   COMMIT;

   CLOSE cust_ins;

   OPEN cust_upd;

   LOOP
      FETCH cust_upd
      INTO rec_stat_upd;

      EXIT WHEN cust_upd%NOTFOUND;
     
         UPDATE u_stg.t_cust_status
            SET update_dt    = SYSDATE
          WHERE TRIM ( status_code ) = rec_stat_upd.code;
      OPEN v_cursor FOR stmt USING rec_stat_upd.code;

      FETCH v_cursor
      BULK COLLECT INTO rec_stat;



      FORALL i IN 1 .. rec_stat.COUNT
         UPDATE u_stg.lc_cust_status
            SET status_desc  = rec_stat(i)
          WHERE status_code = rec_stat_upd.code;

      CLOSE v_cursor;
   END LOOP;

   COMMIT;

   CLOSE cust_upd;
END;