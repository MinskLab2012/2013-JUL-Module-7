/* Formatted on 03.08.2013 23:46:43 (QP5 v5.139.911.3011) */
DECLARE
   CURSOR cust_ins
   IS
      SELECT DISTINCT  comp_status_code
        FROM t_orders
      MINUS
      SELECT trim(status_code)
        FROM u_stg.t_cust_status;

   CURSOR cust_upd
   IS
      SELECT status_code AS code
           ,  status_desc
        FROM u_stg.lc_cust_status
      MINUS
      SELECT  comp_status_code 
           , comp_status 
        FROM t_orders;

   CURSOR cur_order ( status_code VARCHAR )
   IS
      SELECT DISTINCT comp_status_code AS code
                    , comp_status
        FROM t_orders
       WHERE comp_status_code = status_code;

   rec_stat_ins   t_orders.comp_status_code%TYPE;
   rec_stat_upd   cust_upd%ROWTYPE;
BEGIN
   OPEN cust_ins;


   LOOP
      FETCH cust_ins
      INTO rec_stat_ins;

      EXIT WHEN cust_ins%NOTFOUND;

      FOR rec_cur_odrer IN cur_order ( rec_stat_ins ) LOOP
         INSERT INTO u_stg.t_cust_status
            SELECT u_stg.sq_cust_stat_id.NEXTVAL
                 , rec_cur_odrer.code
                 , SYSDATE
                 , NULL
              FROM DUAL;

         INSERT INTO u_stg.lc_cust_status
            SELECT u_stg.sq_cust_stat_id.CURRVAL
                 , rec_cur_odrer.code
                 , rec_cur_odrer.comp_status
                 , 1
              FROM DUAL;
      END LOOP;

   END LOOP;
   
   COMMIT;
   
   CLOSE cust_ins;   

   OPEN cust_upd;

   LOOP
      FETCH cust_upd
      INTO rec_stat_upd;

      EXIT WHEN cust_upd%NOTFOUND;

      FOR rec_cur_odrer IN cur_order ( rec_stat_upd.code ) LOOP
         UPDATE u_stg.t_cust_status
            SET update_dt    = SYSDATE
          WHERE trim(status_code) = rec_stat_upd.code;

         UPDATE u_stg.lc_cust_status
            SET status_desc  = rec_cur_odrer.comp_status
          WHERE status_code = rec_stat_upd.code;
      END LOOP;
   END LOOP;



   COMMIT;

   CLOSE cust_upd;
END;