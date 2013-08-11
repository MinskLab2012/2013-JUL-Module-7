   PROCEDURE ins_upd
   AS
      TYPE t_code IS TABLE OF t_orders.measure_code%TYPE;

      TYPE t_name IS TABLE OF t_orders.measure%TYPE;

      TYPE t_quant IS TABLE OF t_orders.quantity%TYPE;



      tab_code       t_code;
      tab_name       t_name;
      tab_quant      t_quant;

      CURSOR ins
      IS
         SELECT DISTINCT tor.measure_code
                       , tor.measure
                       , tor.quantity
           FROM t_orders tor
         MINUS
         SELECT measure_code
              , measure_desc
              , quantity
           FROM u_stg.t_measures;
   BEGIN
      OPEN ins;


      LOOP
         FETCH ins
         BULK COLLECT INTO tab_code, tab_name, tab_quant;


         FORALL i IN 1 .. tab_code.COUNT
         MERGE INTO u_stg.t_measures USING (SELECT tab_code(i), tab_name(i), tab_quant(i) FROM DUAL)
         ON (t_measures.measure_code = tab_code(i))
         WHEN NOT MATCHED THEN
         INSERT VALUES (u_stg.sq_prod_id.NEXTVAL, tab_code(i), tab_name(i), SYSDATE, '', tab_quant(i))
         WHEN MATCHED THEN
         UPDATE SET measure_desc = tab_name(i), update_dt = SYSDATE, quantity = tab_quant(i) WHERE t_measures.measure_code = tab_code(i);

         COMMIT;
         EXIT WHEN ins%NOTFOUND;
      END LOOP;

      COMMIT;

      CLOSE ins;
   END ins_upd;