CREATE MATERIALIZED VIEW LOG ON u_sa_data.tmp_transactions_info
   WITH PRIMARY KEY
   INCLUDING NEW VALUES;



CREATE MATERIALIZED VIEW monthly_rep_model
  REFRESH START WITH SYSDATE NEXT SYSDATE + 1/1440
  AS
  SELECT event_dt
                 , tariff_type
                 , tariff_name
                 , am_sum
                 , count_tr
                 , profit
                 , prg
              FROM (  SELECT TRUNC ( TO_DATE ( event_dt
                                             , 'dd-mon-yy' )
                                   , 'month' )
                                event_dt
                           , tariff_type
                           , tariff_name
                           , tariff_payment_sum
                           , SUM ( SUM ( payment_sum / currency_to_dollar ) ) OVER (PARTITION BY tariff_type) par_sum
                           ,  SUM ( payment_sum / currency_to_dollar )
                                am_sum
                           , COUNT ( payment_sum / currency_to_dollar ) count_tr
                        FROM u_sa_data.tmp_transactions_info
                       WHERE tariff_type IN ('Local Transfer', 'International Transfer')
                         AND tariff_name IN ('Small Transfer', 'Temperate Transfer')
                         AND TO_CHAR ( TRUNC ( event_dt
                                             , 'YYYY' )
                                     , 'YYYY' ) IN ('2012')
                    GROUP BY (tariff_type, tariff_name, TRUNC ( TO_DATE ( event_dt
                                                                        , 'dd-mon-yy' )
                                                              , 'month' ), tariff_payment_sum))
          MODEL RETURN UPDATED ROWS
             PARTITION BY ( tariff_type, tariff_name )
             DIMENSION BY ( event_dt )
             MEASURES ( 0 prg, 0 profit, am_sum, par_sum, count_tr, tariff_payment_sum )
             RULES AUTOMATIC ORDER
                ( prg [event_dt] = ROUND ( ( 100 * am_sum[CV ( event_dt )] / par_sum[CV ( event_dt )] )
                                         , 5 ),
                profit [event_dt] = ROUND ( ( count_tr[CV ( event_dt )] * tariff_payment_sum[CV ( event_dt )] / 100 )
                                          , 2 ) );
