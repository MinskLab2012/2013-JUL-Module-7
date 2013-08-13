DROP TABLE TMP_TRANSACTIONS_DAILY ;

create table TMP_TRANSACTIONS_DAILY 
(
   event_dt             DATE                           null,
   cust_send_id         NUMBER                         null,
   cus_rec_id           NUMBER                         null,
   geo_send_sur_id      NUMBER                         null,
   geo_rec_sur_id       NUMBER                         null,
   currency_sur_id      NUMBER                         null,
   operation_id         NUMBER                         null,
   tariff_id            NUMBER                         null,
   period_id            NUMBER                         null,
   amount_payment       NUMBER                         null,
   count_payment        NUMBER                         null,
   ta_country_send_id   NUMBER                         null,
   ta_country_rec_id    NUMBER                         null,
   insert_dt            date                           null
)