/* Formatted on 8/12/2013 3:05:56 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_insurances
AS
   PROCEDURE load_dim_insurances
   AS
      CURSOR cur_c1
      IS
         SELECT t.insurance_id, t.insurance_code, lc.company_name, ty.insurance_type, t.insurence_cost, dw.insurance_id ins
           FROM st.t_insurance t
                JOIN st.lc_insurances lc
                   ON t.insurance_id = lc.insurance_id
                   join st.t_insurance_type ty
                   on t.insurence_type_id = ty.insurance_type_id
                LEFT JOIN dw_star.dim_insurances dw
                   ON t.insurance_id = dw.insurance_id;


      TYPE ins_tab IS TABLE OF cur_c1%ROWTYPE;

      teb            ins_tab;
   BEGIN
      OPEN cur_c1;

      FETCH cur_c1
      BULK COLLECT INTO teb;

      FOR i IN teb.FIRST .. teb.LAST LOOP
         IF teb ( i ).ins IS NULL THEN
            INSERT INTO dw_star.dim_insurances ( insurance_id
                                              , insurance_code
                                              , company_name
                                              , insurance_type
                                              , insurance_cost
                                              , last_insert_dt )
                 VALUES ( teb ( i ).insurance_id
                        , teb ( i ).insurance_code
                        , teb ( i ).company_name
                        , teb ( i ).insurance_type
                        , teb ( i ).insurence_cost
                        , SYSDATE );
            COMMIT;
         ELSE
            UPDATE dw_star.dim_insurances
               SET insurance_code    = teb ( i ).insurance_code
                 , company_name  = teb ( i ).company_name
                 , insurance_type  = teb ( i ).insurance_type
                 , insurance_cost = teb ( i ).insurence_cost
                 , last_update_dt = SYSDATE
             WHERE insurance_id = teb ( i ).insurance_id
               AND ( insurance_code    = teb ( i ).insurance_code
                 or company_name  = teb ( i ).company_name
                 or insurance_type  = teb ( i ).insurance_type
                 or insurance_cost = teb ( i ).insurence_cost );
         END IF;
      END LOOP;

      COMMIT;
   END load_dim_insurances;
END;