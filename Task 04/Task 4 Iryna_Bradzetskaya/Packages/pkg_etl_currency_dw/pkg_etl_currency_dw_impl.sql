CREATE OR REPLACE PACKAGE BODY pkg_etl_currency_dw
AS
   -- Reload Data From Sources table to DataBase

   PROCEDURE load_currency_types
   AS
      CURSOR c1
      IS
         SELECT DISTINCT sa_t.currency_type_id
                       , sa_t.currency_type_name
                       , dw_t.currency_type_desc
                       , dw_t.currency_type_code
           FROM    u_sa_data.tmp_currency sa_t
                LEFT JOIN
                   u_dw.dw_currency_types dw_t
                ON ( dw_t.currency_type_code = sa_t.currency_type_id );

      TYPE cur_type IS TABLE OF c1%ROWTYPE;

      curr           cur_type;
   BEGIN
      OPEN c1;

      FETCH c1
      BULK COLLECT INTO curr;

      FOR i IN curr.FIRST .. curr.LAST LOOP
         IF curr ( i ).currency_type_id = curr ( i ).currency_type_code THEN
            UPDATE u_dw.dw_currency_types ct
               SET ct.currency_type_desc = curr ( i ).currency_type_name
                 , update_dt    = SYSDATE
             WHERE curr ( i ).currency_type_id = ct.currency_type_code
               AND curr ( i ).currency_type_name != ct.currency_type_desc;
         ELSIF curr ( i ).currency_type_id != NVL ( curr ( i ).currency_type_code, -99 ) THEN
            INSERT INTO u_dw.dw_currency_types ( currency_type_id
                                               , currency_type_code
                                               , currency_type_desc
                                               , insert_dt )
                 VALUES ( seq_currency_type.NEXTVAL
                        , curr ( i ).currency_type_id
                        , curr ( i ).currency_type_name
                        , SYSDATE );
         END IF;
      END LOOP;

      COMMIT;
   END load_currency_types;
END pkg_etl_currency_dw;