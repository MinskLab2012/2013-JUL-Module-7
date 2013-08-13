/* Formatted on 8/6/2013 9:32:56 AM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_cust_emp
AS
   --load cities (Variable Cursor and FORALL Bulk Insertion )
   PROCEDURE load_cities
   AS
      TYPE cityrectyp IS RECORD
   (
      customer_city  VARCHAR2 ( 50 )
    , geo_id         NUMBER ( 22 )
   );

      city_cv        SYS_REFCURSOR;

      TYPE cityset IS TABLE OF cityrectyp;

      citycoll1      cityset;
      citycoll2      cityset;
   BEGIN
      OPEN city_cv FOR --dataset with brand new cities (should insert)
         SELECT DISTINCT cc.capital AS customer_city
                       , geo.geo_id
           FROM    u_sa_data.tmp_countries_city cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.country = geo.country_desc )
          WHERE cc.capital NOT IN (SELECT DISTINCT city_desc
                                     FROM u_dw.cities);

      FETCH city_cv
      BULK COLLECT INTO citycoll1;

      FORALL i IN INDICES OF citycoll1
         INSERT INTO u_dw.cities ( city_id
                                 , city_desc
                                 , country_geo_id
                                 , insert_dt )
              VALUES ( u_dw.sq_cities_id.NEXTVAL
                     , citycoll1 ( i ).customer_city
                     , citycoll1 ( i ).geo_id
                     , SYSDATE );

      OPEN city_cv FOR --dataset with the same cities names (should  update if geo_id was changed)
         SELECT DISTINCT cc.capital AS customer_city
                       , geo.geo_id
           FROM    u_sa_data.tmp_countries_city cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.country = geo.country_desc )
          WHERE cc.capital IN (SELECT DISTINCT city_desc
                                 FROM u_dw.cities);

      FETCH city_cv
      BULK COLLECT INTO citycoll2;



      FORALL j IN INDICES OF citycoll2
         UPDATE u_dw.cities ct
            SET ct.country_geo_id = citycoll2 ( j ).geo_id
              , ct.update_dt = SYSDATE
          WHERE citycoll2 ( j ).geo_id != ct.country_geo_id
            AND citycoll2 ( j ).customer_city = ct.city_desc;

      COMMIT;
   END load_cities;

   --load customers (Execute Immediate with Bind Parameters)
   PROCEDURE load_customers
   AS
      CURSOR c1
      IS
         SELECT DISTINCT cn.cust_id
                       , cn.passport_number
                       , cn.first_name AS customer_first_name
                       , cn.last_name AS customer_last_name
                       , ct.city_id
                       , cn.adress AS customer_adress
                       , cn.gender AS customer_gender
           FROM u_sa_data.tmp_customers cn JOIN u_dw.cities ct ON ( cn.city = ct.city_desc )
          WHERE ( cn.cust_id, cn.passport_number ) NOT IN (SELECT DISTINCT cust_code
                                                                         , passport_number
                                                             FROM u_dw.customers);

      CURSOR c2
      IS
         SELECT DISTINCT cn.cust_id
                       , cn.passport_number
                       , cn.adress AS customer_adress
           FROM u_sa_data.tmp_customers cn
         MINUS
         SELECT DISTINCT cust_code
                       , passport_number
                       , adress
           FROM u_dw.customers;

      TYPE custset1 IS TABLE OF c1%ROWTYPE;

      TYPE custset2 IS TABLE OF c2%ROWTYPE;

      custcoll1      custset1; -- nested table of records
      custcoll2      custset2;
      sql_stm_inst   VARCHAR2 ( 500 );
      sql_stm_updt   VARCHAR2 ( 500 );
   BEGIN
      sql_stm_inst :=
         'INSERT INTO u_dw.customers (cust_id, cust_code, passport_number, first_name, last_name, city_id, adress, gender, insert_dt)
         VALUES (u_dw.sq_customers_id.NEXTVAL, :a, :b, :c, :d, :e, :f, :g, SYSDATE)';
      sql_stm_updt := 'UPDATE u_dw.customers cust SET cust.adress=:a, update_dt=SYSDATE
        WHERE cust.cust_code=:b AND cust.passport_number=:c';

      OPEN c1;



      FETCH c1
      BULK COLLECT INTO custcoll1;



      FORALL i IN INDICES OF custcoll1
         EXECUTE IMMEDIATE sql_stm_inst
            USING custcoll1 ( i ).cust_id
                , custcoll1 ( i ).passport_number
                , custcoll1 ( i ).customer_first_name
                , custcoll1 ( i ).customer_last_name
                , custcoll1 ( i ).city_id
                , custcoll1 ( i ).customer_adress
                , custcoll1 ( i ).customer_gender;

      OPEN c2;

      FETCH c2
      BULK COLLECT INTO custcoll2;

      FORALL j IN INDICES OF custcoll2
         EXECUTE IMMEDIATE sql_stm_updt
            USING custcoll2 ( j ).customer_adress
                , custcoll2 ( j ).cust_id
                , custcoll2 ( j ).passport_number;

      COMMIT;
   END load_customers;


   --load offices
   PROCEDURE load_offices
   AS
      TYPE officerectyp IS RECORD
   (
      office_id      NUMBER ( 20 )
    , city_id        NUMBER ( 20 )
    , office_adress  VARCHAR2 ( 50 )
   );

      off_cv         SYS_REFCURSOR;

      TYPE offset IS TABLE OF officerectyp;

      offcoll1       offset;
      offcoll2       offset;
      sql_str        CLOB;
      curid1         NUMBER;
      curid2         NUMBER;
      get_value      NUMBER;
   BEGIN
      sql_str     := 'SELECT DISTINCT cn.office_id
              , ct.city_id
              , cn.adress AS office_adress
  FROM u_sa_data.tmp_employees cn JOIN u_dw.cities ct ON ( cn.office_city = ct.city_desc )
 WHERE cn.office_id  NOT IN (SELECT DISTINCT office_code
                              FROM u_dw.offices)';
      curid1      := dbms_sql.open_cursor;
      dbms_sql.parse ( curid1
                     , sql_str
                     , dbms_sql.native );
      get_value   := dbms_sql.execute ( curid1 );
      off_cv      := dbms_sql.to_refcursor ( curid1 );

      FETCH off_cv
      BULK COLLECT INTO offcoll1;



      FORALL i IN INDICES OF offcoll1
         INSERT INTO u_dw.offices ( office_id
                                  , office_code
                                  , city_id
                                  , office_adress
                                  , insert_dt )
              VALUES ( u_dw.sq_offices_id.NEXTVAL
                     , offcoll1 ( i ).office_id
                     , offcoll1 ( i ).city_id
                     , offcoll1 ( i ).office_adress
                     , SYSDATE );

      sql_str     := 'SELECT DISTINCT cn.office_id
              , ct.city_id
              , cn.adress office_adress
  FROM u_sa_data.tmp_employees cn JOIN u_dw.cities ct ON ( cn.office_city = ct.city_desc )
MINUS
SELECT DISTINCT office_code
              , city_id
              , office_adress
  FROM u_dw.offices';
      curid2      := dbms_sql.open_cursor;
      dbms_sql.parse ( curid2
                     , sql_str
                     , dbms_sql.native );
      get_value   := dbms_sql.execute ( curid2 );
      off_cv      := dbms_sql.to_refcursor ( curid2 );

      FETCH off_cv
      BULK COLLECT INTO offcoll2;

      FORALL j IN INDICES OF offcoll2
         UPDATE u_dw.offices
            SET city_id      = offcoll2 ( j ).city_id
              , office_adress = offcoll2 ( j ).office_adress
              , update_dt    = SYSDATE;

      COMMIT;
   END load_offices;

   --load employees
   PROCEDURE load_employees
   AS
      cur_id         NUMBER;
      column_var     NUMBER;
      describe_table dbms_sql.desc_tab;
      numvar         NUMBER;
      sql_str        VARCHAR2 ( 10000 );
      c1             SYS_REFCURSOR;
      e_id           NUMBER;
      f_name         VARCHAR2 ( 50 );
      l_name         VARCHAR2 ( 50 );
      pos            VARCHAR2 ( 50 );
      of_id          NUMBER;
      gend           VARCHAR ( 10 );
      sal            NUMBER;
      eid            NUMBER;
      e_code         NUMBER;
      old_pos        VARCHAR2 ( 50 );
      old_sal        NUMBER;
   BEGIN
      sql_str     := 'SELECT DISTINCT emp.emp_id
                       , emp.first_name
                       , emp.last_name
                       , emp.position
                       , o.office_id
                       , emp.gender
                       , emp.salary
                       , demp.emp_id as ei
                       , demp.emp_code
                       , demp.position AS old_position
                       , demp.salary AS old_salary
           FROM u_sa_data.tmp_employees emp
                JOIN u_dw.offices o
                   ON ( emp.office_id = o.office_code )
                LEFT JOIN u_dw.employees demp
                   ON ( emp.emp_id = demp.emp_code )';

      OPEN c1 FOR sql_str;

      cur_id      := dbms_sql.to_cursor_number ( c1 );
      dbms_sql.describe_columns ( cur_id
                                , column_var
                                , describe_table );

      dbms_sql.define_column ( cur_id
                             , 1
                             , e_id );
      dbms_sql.define_column ( cur_id
                             , 2
                             , f_name
                             , 50 );
      dbms_sql.define_column ( cur_id
                             , 3
                             , l_name
                             , 50 );
      dbms_sql.define_column ( cur_id
                             , 4
                             , pos
                             , 50 );
      dbms_sql.define_column ( cur_id
                             , 5
                             , of_id );
      dbms_sql.define_column ( cur_id
                             , 6
                             , gend
                             , 10 );
      dbms_sql.define_column ( cur_id
                             , 7
                             , sal );
      dbms_sql.define_column ( cur_id
                             , 8
                             , eid );
      dbms_sql.define_column ( cur_id
                             , 9
                             , e_code );
      dbms_sql.define_column ( cur_id
                             , 10
                             , old_pos
                             , 50 );
      dbms_sql.define_column ( cur_id
                             , 11
                             , old_sal );

      WHILE dbms_sql.fetch_rows ( cur_id ) > 0 LOOP
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 1
                               , e_id );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 2
                               , f_name );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 3
                               , l_name );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 4
                               , pos );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 5
                               , of_id );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 6
                               , gend );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 7
                               , sal );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 8
                               , eid );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 9
                               , e_code );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 10
                               , old_pos );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 11
                               , old_sal );

         IF e_code IS NULL THEN
            INSERT INTO u_dw.employees emp ( emp.emp_id
                                           , emp.emp_code
                                           , emp.first_name
                                           , emp.last_name
                                           , emp.position
                                           , emp.office_id
                                           , emp.gender
                                           , emp.salary )
                 VALUES ( u_dw.sq_employees_id.NEXTVAL
                        , e_id
                        , f_name
                        , l_name
                        , pos
                        , of_id
                        , gend
                        , sal );
         ELSIF sal != old_sal THEN
            UPDATE u_dw.employees
               SET salary       = sal;

            INSERT INTO u_dw.employees_actions ea ( ea.emp_id
                                                  , ea.action_date
                                                  , ea.action_type_id
                                                  , ea.old_salary
                                                  , ea.new_salary )
                 VALUES ( eid
                        , SYSDATE
                        , 1
                        , old_sal
                        , sal );
         ELSIF pos != old_pos THEN
            UPDATE u_dw.employees
               SET position     = pos;

            INSERT INTO u_dw.employees_actions ea ( ea.emp_id
                                                  , ea.action_date
                                                  , ea.action_type_id
                                                  , ea.old_possition
                                                  , ea.new_possition )
                 VALUES ( eid
                        , SYSDATE
                        , 2
                        , old_pos
                        , pos );
         END IF;
      END LOOP;

      COMMIT;
   END load_employees;
END pkg_load_ext_ref_cust_emp;