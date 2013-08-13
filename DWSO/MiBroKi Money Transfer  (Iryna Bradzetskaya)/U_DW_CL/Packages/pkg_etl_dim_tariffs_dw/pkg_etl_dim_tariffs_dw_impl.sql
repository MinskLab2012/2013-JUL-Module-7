CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_tariffs_dw
AS
   -- Load Data From Sources table to DataBase
   PROCEDURE load_tmp_tariffs
   AS
      TYPE tariff IS RECORD
   (
      tariff_code    VARCHAR2 ( 5 )
    , tariff_name    VARCHAR2 ( 50 )
    , tariff_payment_sum NUMBER
    , tariff_type    VARCHAR2 ( 50 )
    , tariff_min_payment NUMBER
    , tariff_max_payment NUMBER
   );

      t_cv           SYS_REFCURSOR;

      TYPE tariffs IS TABLE OF tariff;

      tar_ins        tariffs;
      tar_up         tariffs;
      sql_str        CLOB;
      cur_ins        NUMBER;
      cur_up         NUMBER;
      get_value      NUMBER;
   BEGIN
      sql_str     := 'SELECT DISTINCT 
               sa_t.TARIFF_CODE
               , sa_t.TARIFF_NAME
                , sa_t.TARIFF_PAYMENT_SUM
                 , sa_t.TARIFF_TYPE
                  , sa_t.TARIFF_MIN_PAYMENT
                   , sa_t.TARIFF_MAX_PAYMENT
  FROM u_sa_data.tmp_tariffs sa_t 
 WHERE sa_t.TARIFF_CODE NOT IN (SELECT DISTINCT TARIFF_CODE
                              FROM u_dw.dw_tariffs)';
      cur_ins     := dbms_sql.open_cursor;
      dbms_sql.parse ( cur_ins
                     , sql_str
                     , dbms_sql.native );
      get_value   := dbms_sql.execute ( cur_ins );
      t_cv        := dbms_sql.to_refcursor ( cur_ins );

      FETCH t_cv
      BULK COLLECT INTO tar_ins;



      FORALL i IN INDICES OF tar_ins
         INSERT INTO u_dw.dw_tariffs ( tariff_id
                                     , tariff_code
                                     , tariff_name
                                     , tariff_payment_sum
                                     , tariff_type
                                     , tariff_min_payment
                                     , tariff_max_payment
                                     , insert_dt )
              VALUES ( seq_tariffs.NEXTVAL
                     , tar_ins ( i ).tariff_code
                     , tar_ins ( i ).tariff_name
                     , tar_ins ( i ).tariff_payment_sum
                     , tar_ins ( i ).tariff_type
                     , tar_ins ( i ).tariff_min_payment
                     , tar_ins ( i ).tariff_max_payment
                     , SYSDATE );

      sql_str     := 'SELECT DISTINCT 
               sa_t.TARIFF_CODE
               , sa_t.TARIFF_NAME
                , sa_t.TARIFF_PAYMENT_SUM
                 , sa_t.TARIFF_TYPE
                  , sa_t.TARIFF_MIN_PAYMENT
                   , sa_t.TARIFF_MAX_PAYMENT
  FROM u_sa_data.tmp_tariffs sa_t 
MINUS
SELECT DISTINCT   
                                  tariff_code
                                  , tariff_name
                                  , tariff_payment_sum 
                                  , tariff_type
                                  , tariff_min_payment
                                  , tariff_max_payment
  FROM u_dw.dw_tariffs';
      cur_up      := dbms_sql.open_cursor;
      dbms_sql.parse ( cur_up
                     , sql_str
                     , dbms_sql.native );
      get_value   := dbms_sql.execute ( cur_up );
      t_cv        := dbms_sql.to_refcursor ( cur_up );

      FETCH t_cv
      BULK COLLECT INTO tar_up;

      FORALL j IN INDICES OF tar_up
         UPDATE u_dw.dw_tariffs
            SET tariff_min_payment = tar_up ( j ).tariff_min_payment
              , tariff_max_payment = tar_up ( j ).tariff_max_payment
              , tariff_payment_sum = tar_up ( j ).tariff_payment_sum
              , update_dt    = SYSDATE;

      COMMIT;
   END load_tmp_tariffs;
END pkg_etl_dim_tariffs_dw;