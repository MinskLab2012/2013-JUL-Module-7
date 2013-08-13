INSERT INTO U_DW.DW_CURRENCY_ACTION_TYPES VALUES (1, 'CURRENCY_TO_DOLLAR');


CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_currensy_dw
AS
   -- Load Data From Sources table to DataBase
   PROCEDURE load_tmp_currensy
   AS
      cur_id         NUMBER;
      column_var     NUMBER;
      describe_table dbms_sql.desc_tab;
      numvar         NUMBER;
      sql_str        VARCHAR2 ( 10000 );
      c1             SYS_REFCURSOR;
      c_id           NUMBER;
      c_t_id         NUMBER;
      c_t_dol        NUMBER;
      c_name         VARCHAR2 ( 5 BYTE );
      c_code         NUMBER;
      c_desc         VARCHAR2 ( 50 BYTE );
      old_val        NUMBER;
   BEGIN
      sql_str     := 'SELECT DISTINCT DW_T.CURRENCY_ID
                       , SA_T.CURRENCY_TYPE_ID
                       , SA_T.CURRENCY_TO_DOLLAR
                       , SA_T.CURRENCY_NAME
                       , SA_T.CURRENCY_CODE
                       , SA_T.CURRENCY_DESC
                       , DW_T.CURRENCY_TO_DOLLAR old_value
           FROM u_sa_data.TMP_CURRENCY SA_T
                LEFT JOIN u_dw.DW_CURRENCY DW_T
                   ON ( SA_T.CURRENCY_CODE = DW_T.CURRENCY_CODE )';

      OPEN c1 FOR sql_str;

      cur_id      := dbms_sql.to_cursor_number ( c1 );
      dbms_sql.describe_columns ( cur_id
                                , column_var
                                , describe_table );

      dbms_sql.define_column ( cur_id
                             , 1
                             , c_id );
      dbms_sql.define_column ( cur_id
                             , 2
                             , c_t_id );
      dbms_sql.define_column ( cur_id
                             , 3
                             , c_t_dol );
      dbms_sql.define_column ( cur_id
                             , 4
                             , c_name
                             , 5 );
      dbms_sql.define_column ( cur_id
                             , 5
                             , c_code );
      dbms_sql.define_column ( cur_id
                             , 6
                             , c_desc
                             , 50 );
      dbms_sql.define_column ( cur_id
                             , 7
                             , old_val );


      WHILE dbms_sql.fetch_rows ( cur_id ) > 0 LOOP
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 1
                               , c_id );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 2
                               , c_t_id );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 3
                               , c_t_dol );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 4
                               , c_name );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 5
                               , c_code );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 6
                               , c_desc );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 7
                               , old_val );


         IF c_id IS NULL THEN
            INSERT INTO u_dw.dw_currency cu ( cu.currency_id
                                            , cu.currency_type_id
                                            , cu.currency_to_dollar
                                            , cu.currency_name
                                            , cu.currency_code
                                            , cu.currency_desc )
                 VALUES ( seq_currensy.NEXTVAL
                        , c_t_id
                        , c_t_dol
                        , c_name
                        , c_code
                        , c_desc );
         ELSIF c_t_dol != old_val THEN
            UPDATE u_dw.dw_currency
               SET currency_to_dollar = c_t_dol;

            INSERT INTO u_dw.dw_currency_actions ca ( ca.currency_action_id
                                                    , ca.currency_id
                                                    , ca.action_date
                                                    , ca.currency_action_type_id
                                                    , ca.value_old
                                                    , ca.value_new )
                 VALUES ( seq_currensy_action.NEXTVAL
                        , c_id
                        , SYSDATE
                        , 1
                        , old_val
                        , c_t_dol );
         END IF;
      END LOOP;

      COMMIT;
   END load_tmp_currensy;
END pkg_etl_dim_currensy_dw;