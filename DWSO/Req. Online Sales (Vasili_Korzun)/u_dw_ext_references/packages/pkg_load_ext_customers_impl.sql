create or replace package body pkg_load_ext_customers
as 
PROCEDURE load_to_refcursor_customers
AS
   TYPE curtype IS REF CURSOR;

   srs_cur        curtype;
   cur_c          curtype;
   curid          NUMBER;
   ret            NUMBER;
   sql_statement  VARCHAR ( 1000 )
                     DEFAULT 'SELECT /*+ USE_HASH(cls, st) parallel(cls, 2)*/
            DISTINCT st.customer_id AS p_id
                   , cls.first_name
                   , cls.last_name
                   , cls.birth_day
                   ,    SUBSTR ( cls.first_name
                               , 1
                               , 1 )
                     || cls.last_name
                     || ''@cust.st''
                        AS email
        FROM    tmp_orders cls
             LEFT JOIN
                st_data.customers st
             ON cls.first_name || cls.last_name = st.first_name || st.last_name
            AND cls.birth_day = st.birth_date';
   col_num        NUMBER;

   TYPE cust IS RECORD
   (
      p_id           NUMBER ( 6, 0 )
    , first_name     VARCHAR2 ( 50 )
    , last_name      VARCHAR2 ( 50 )
    , birth_day      DATE
    , email          VARCHAR2 ( 50 )
   );

   pc             cust;
BEGIN
   curid       := dbms_sql.open_cursor;
   dbms_sql.parse ( curid                 , sql_statement                  , dbms_sql.native );
   ret         := dbms_sql.execute ( curid );
   cur_c       := dbms_sql.to_refcursor ( curid );

   LOOP
      FETCH cur_c     INTO pc;

      IF cur_c%NOTFOUND THEN
         EXIT;
      END IF;

      IF pc.p_id IS NULL THEN
         INSERT INTO st_data.customers ( customer_id
                                       , first_name
                                       , last_name
                                       , birth_date
                                       , email
                                       , insert_dt )
              VALUES ( st_data.customers_seq.NEXTVAL
                     , pc.first_name
                     , pc.last_name
                     , pc.birth_day
                     , pc.email
                     , SYSDATE );
      ELSIF pc.p_id IS NOT NULL THEN
         UPDATE st_data.customers st
            SET st.email     = pc.email
              , st.update_dt = SYSDATE
          WHERE st.customer_id = pc.p_id
            AND st.email != pc.email;
      ELSE
         EXIT;
      END IF;
   END LOOP;

   COMMIT;
END load_to_refcursor_customers;

PROCEDURE load_to_cursor_num_customers
AS
   TYPE curtype IS REF CURSOR;
   cur_c          curtype;
   curid          NUMBER;
   ret            NUMBER;
   sql_statement  VARCHAR ( 1000 )
                     DEFAULT 'SELECT /*+ USE_HASH(cls, st) parallel(cls, 2)*/
            DISTINCT st.customer_id AS p_id
                   , cls.first_name
                   , cls.last_name
                   , cls.birth_day
                   ,    SUBSTR ( cls.first_name
                               , 1
                               , 1 )
                     || cls.last_name
                     || ''@cust.st''
                        AS email
        FROM    tmp_orders cls
             LEFT JOIN
                st_data.customers st
             ON cls.first_name || cls.last_name = st.first_name || st.last_name
            AND cls.birth_day = st.birth_date';
   colcnt      NUMBER;
   desctab dbms_sql.desc_tab;

   TYPE cust IS RECORD
   (
      p_id           NUMBER ( 6, 0 )
    , first_name     VARCHAR2 ( 50 )
    , last_name      VARCHAR2 ( 50 )
    , birth_day      DATE
    , email          VARCHAR2 ( 50 )
   );
   pc             cust;
   rows_processed number default 0;
BEGIN
open cur_c for sql_statement;
curid := DBMS_SQL.TO_CURSOR_NUMBER(cur_c);
DBMS_SQL.DESCRIBE_COLUMNS(curid, colcnt, desctab);

dbms_sql.define_column(curid, 1, pc.p_id);
dbms_sql.define_column(curid, 2, pc.first_name, 50);
dbms_sql.define_column(curid, 3, pc.last_name, 50);
dbms_sql.define_column(curid, 4, pc.birth_day);
dbms_sql.define_column(curid, 5, pc.email, 50);

while dbms_sql.fetch_rows(curid)>0
loop
rows_processed := rows_processed + 1;
dbms_sql.column_value(curid, 1, pc.p_id);
dbms_sql.column_value(curid, 2, pc.first_name);
dbms_sql.column_value(curid, 3, pc.last_name);
dbms_sql.column_value(curid, 4, pc.birth_day);
dbms_sql.column_value(curid, 5, pc.email);
      IF pc.p_id IS NULL THEN
         INSERT INTO st_data.customers ( customer_id
                                       , first_name
                                       , last_name
                                       , birth_date
                                       , email
                                       , insert_dt )
              VALUES ( st_data.customers_seq.NEXTVAL
                     , pc.first_name
                     , pc.last_name
                     , pc.birth_day
                     , pc.email
                     , SYSDATE );
      ELSIF pc.p_id IS NOT NULL THEN
         UPDATE st_data.customers st
            SET st.email     = pc.email
              , st.update_dt = SYSDATE
          WHERE st.customer_id = pc.p_id
            AND st.email != pc.email;
      ELSE
         raise_application_error(-20123, 'Something wrong with procedure routine');
      END IF;
end loop;
commit;
exception
when others then
rollback;

END load_to_cursor_num_customers;
end pkg_load_ext_customers;