/* Formatted on 12.08.2013 21:18:57 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_periods
AS
   PROCEDURE load_dim_gen_periods
   AS
      CURSOR c1
      IS
         SELECT *
           FROM u_dw.periods
         MINUS
         SELECT per_id
              , per_desc
              , per_begin
              , per_end
           FROM u_str_data.dim_gen_periods;
   BEGIN
      FOR i IN c1 LOOP
         INSERT INTO u_str_data.dim_gen_periods
              VALUES ( u_str_data.sq_per_id.NEXTVAL
                     , i.per_id
                     , i.per_desc
                     , i.per_begin
                     , i.per_end
                     , 'seasons'
                     , SYSDATE );
      END LOOP;

      COMMIT;
   END load_dim_gen_periods;
END pkg_load_dim_periods;