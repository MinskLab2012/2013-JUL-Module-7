CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_tar
AS
   -- Load Data From Sources table to DataBase

   PROCEDURE load_tmp_tar
   AS
      CURSOR c1
      IS
         SELECT DISTINCT dw_t.tariff_id
                       , sa_t.tariff_code
                       , sa_t.tariff_name
                       , sa_t.tariff_payment_sum
                       , sa_t.tariff_type
                       , sa_t.tariff_min_payment
                       , sa_t.tariff_max_payment
           FROM    u_sa_data.tmp_tariffs sa_t
                LEFT OUTER JOIN
                   u_dw.dw_tariffs dw_t
                ON ( dw_t.tariff_code = sa_t.tariff_code )
          WHERE sa_t.tariff_code NOT IN (SELECT DISTINCT tariff_code
                                           FROM u_dw.dw_tariffs);

      CURSOR c2
      IS
         SELECT DISTINCT sa_t.tariff_code
                       , sa_t.tariff_name
                       , sa_t.tariff_payment_sum
                       , sa_t.tariff_type
                       , sa_t.tariff_min_payment
                       , sa_t.tariff_max_payment
           FROM u_sa_data.tmp_tariffs sa_t
         MINUS
         SELECT DISTINCT tariff_code
                       , tariff_name
                       , tariff_payment_sum
                       , tariff_type
                       , tariff_min_payment
                       , tariff_max_payment
           FROM u_dw.dw_tariffs;

      TYPE t_ins IS TABLE OF c1%ROWTYPE;

      TYPE t_upd IS TABLE OF c2%ROWTYPE;

      nt_ins         t_ins;
      nt_upd         t_upd;
      sql_ins        VARCHAR2 ( 500 );
      sql_upd        VARCHAR2 ( 500 );
   BEGIN
      sql_ins     := 'INSERT INTO u_dw.dw_tariffs (tariff_id
                                  , tariff_code
                                  , tariff_name
                                  , tariff_payment_sum 
                                  , tariff_type
                                  , tariff_min_payment
                                  , tariff_max_payment
                                  , insert_dt)
         VALUES (SEQ_TARIFFS.NEXTVAL, :code, :name, :sum, :type, :min, :max, SYSDATE)';
      sql_upd     := 'UPDATE u_dw.dw_tariffs tar SET tar.tariff_payment_sum=:sum,
      tar.tariff_min_payment=:min, tar.tariff_max_payment=:max,
      update_dt=SYSDATE
        WHERE tar.tariff_code=:code';

      OPEN c1;

      FETCH c1
      BULK COLLECT INTO nt_ins;



      FORALL i IN INDICES OF nt_ins
         EXECUTE IMMEDIATE sql_ins
            USING nt_ins ( i ).tariff_code
                , nt_ins ( i ).tariff_name
                , nt_ins ( i ).tariff_payment_sum
                , nt_ins ( i ).tariff_type
                , nt_ins ( i ).tariff_min_payment
                , nt_ins ( i ).tariff_max_payment;

      OPEN c2;

      FETCH c2
      BULK COLLECT INTO nt_upd;

      FORALL j IN INDICES OF nt_upd
         EXECUTE IMMEDIATE sql_upd
            USING nt_upd ( j ).tariff_payment_sum
                , nt_upd ( j ).tariff_min_payment
                , nt_upd ( j ).tariff_max_payment
                , nt_upd ( j ).tariff_code;

      COMMIT;
   END load_tmp_tar;
END pkg_etl_dim_tar; 
