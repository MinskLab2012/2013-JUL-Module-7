CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_tariffs_sal
AS
   -- Load Data From Stage table to Star
PROCEDURE load_dim_tarrifs
   AS
 
   BEGIN
      --Merge Source data
      MERGE INTO u_sal.dim_tariffs sal_t
           USING (SELECT DISTINCT dw_t.TARIFF_ID
                         , dw_t.TARIFF_CODE
                         , dw_t.TARIFF_NAME
                         , dw_t.TARIFF_PAYMENT_SUM
                         , dw_t.TARIFF_TYPE
                         , dw_t.TARIFF_MIN_PAYMENT
                         , dw_t.TARIFF_MAX_PAYMENT
             FROM u_dw.dw_tariffs dw_t) dw_t
              ON ( sal_t.TARIFF_CODE = dw_t.TARIFF_CODE )
      WHEN NOT MATCHED THEN
        INSERT  ( tariff_id
                                     , tariff_code
                                     , tariff_name
                                     , tariff_payment_sum
                                     , tariff_type
                                     , tariff_min_payment
                                     , tariff_max_payment
                                     , insert_dt )
              VALUES ( dw_t.tariff_id
                     , dw_t.tariff_code
                     , dw_t.tariff_name
                     , dw_t.tariff_payment_sum
                     , dw_t.tariff_type
                     , dw_t.tariff_min_payment
                     , dw_t.tariff_max_payment
                     , SYSDATE )
      WHEN MATCHED THEN
         UPDATE SET  sal_t.TARIFF_MIN_PAYMENT = dw_t.TARIFF_MIN_PAYMENT
                 , sal_t.TARIFF_MAX_PAYMENT = dw_t.TARIFF_MAX_PAYMENT
                 , sal_t.TARIFF_PAYMENT_SUM = dw_t.TARIFF_PAYMENT_SUM
                  , sal_t.update_dt = SYSDATE
                  WHERE sal_t.TARIFF_MIN_PAYMENT != dw_t.TARIFF_MIN_PAYMENT
                 or sal_t.TARIFF_MAX_PAYMENT != dw_t.TARIFF_MAX_PAYMENT
                 or sal_t.TARIFF_PAYMENT_SUM != dw_t.TARIFF_PAYMENT_SUM
                  ;

      --Commit Result
      COMMIT;
   END load_dim_tarrifs;
END pkg_etl_dim_tariffs_sal;



INSERT INTO u_sal.dim_tariffs (tariff_id, tariff_code, tariff_name) VALUES ( -99, 'n/d', 'n/d');
commit;