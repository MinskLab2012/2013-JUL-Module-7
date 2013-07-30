  SELECT event_dt
       , transaction_id
       , cust_send_id
       , cust_rec_id
       , cntr_send_id
       , cntr_rec_id
       , currency_code
       , tariff_code
       , operation_id
       , operation_method_id
       , SUM ( payment_sum )
       , COUNT ( payment_sum )
    FROM u_dw_ext_references.tmp_transactions
GROUP BY event_dt
       , transaction_id
       , cust_send_id
       , cust_rec_id
       , cntr_send_id
       , cntr_rec_id
       , currency_code
       , tariff_code
       , operation_id
       , operation_method_id