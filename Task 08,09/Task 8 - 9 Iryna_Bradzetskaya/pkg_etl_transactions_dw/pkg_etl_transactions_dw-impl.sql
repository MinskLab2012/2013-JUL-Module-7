CREATE OR REPLACE PACKAGE BODY pkg_etl_transactions_dw
AS
   -- Reload Data From Sources table to DataBase

   PROCEDURE load_transactions
   AS
      CURSOR c1
      IS
         SELECT tr.event_dt
              , tr.trans_code sa_code
              , dw_tr.trans_code dw_code
              , c_send.cust_id cust_send_id
              , c_rec.cust_id cust_rec_id
              , cntr_send.geo_id cust_send_geo_id
              , cntr_rec.geo_id cust_rec_geo_id
              , curr.currency_id
              , tar.tariff_id
              , op.operation_id
              , tr.payment_sum
           FROM u_sa_data.tmp_transactions_info tr
                LEFT OUTER JOIN u_dw.dw_customers c_send
                   ON ( tr.cust_send_pass_num = c_send.cust_pass_number )
                LEFT OUTER JOIN u_dw.dw_customers c_rec
                   ON ( tr.cust_rec_pass_num = c_rec.cust_pass_number )
                LEFT OUTER JOIN u_dw_references.cu_countries cntr_send
                   ON ( tr.cntr_send_desc = cntr_send.country_id )
                LEFT OUTER JOIN u_dw_references.cu_countries cntr_rec
                   ON ( tr.cntr_rec_desc = cntr_rec.country_id )
                LEFT OUTER JOIN u_dw.dw_currency curr
                   ON ( tr.currency_code = curr.currency_code )
                LEFT OUTER JOIN u_dw.dw_tariffs tar
                   ON ( tr.tariff_code = tar.tariff_code )
                LEFT OUTER JOIN u_dw.dw_operations op
                   ON ( tr.operation_id = op.operation_code )
                LEFT OUTER JOIN u_dw.dw_transactions dw_tr
                   ON ( dw_tr.trans_code = tr.trans_code );

      TYPE cur_type IS TABLE OF c1%ROWTYPE;

      curr           cur_type;
   BEGIN
      OPEN c1;

      FETCH c1
      BULK COLLECT INTO curr;

      FOR i IN curr.FIRST .. curr.LAST LOOP
         IF curr ( i ).sa_code != NVL ( curr ( i ).dw_code, -99 ) THEN
            INSERT INTO u_dw.dw_transactions ( transaction_id
                                             , trans_code
                                             , event_dt
                                             , currency_id
                                             , tariff_id
                                             , operation_id
                                             , cust_send_geo_id
                                             , cust_rec_geo_id
                                             , cust_send_id
                                             , cust_rec_id
                                             , payment_sum
                                             , insert_dt )
                 VALUES ( seq_transactions.NEXTVAL
                        , curr ( i ).sa_code
                        , curr ( i ).event_dt
                        , curr ( i ).currency_id
                        , curr ( i ).tariff_id
                        , curr ( i ).operation_id
                        , curr ( i ).cust_send_geo_id
                        , curr ( i ).cust_rec_geo_id
                        , curr ( i ).cust_send_id
                        , curr ( i ).cust_rec_id
                        , curr ( i ).payment_sum
                        , SYSDATE );
         END IF;
      END LOOP;

      COMMIT;
   END load_transactions;
END pkg_etl_transactions_dw;