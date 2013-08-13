CREATE OR REPLACE PACKAGE pkg_etl_geo_actions
--
AS
   PROCEDURE load_geo_actions;
END;

BEGIN
   pkg_etl_geo_actions.load_geo_actions;
END;

CREATE OR REPLACE PACKAGE BODY pkg_etl_geo_actions
AS
   -- Load Data From Sources table to DataBase
   PROCEDURE load_geo_actions
   AS
      cur_id         NUMBER;
      column_var     NUMBER;
      describe_table dbms_sql.desc_tab;
      numvar         NUMBER;
      sql_str        VARCHAR2 ( 10000 );
      c1             SYS_REFCURSOR;
      link_type_id   NUMBER;
      child_geo_id   NUMBER;
      parent_geo_id  NUMBER;
   BEGIN
      sql_str     := 'SELECT child_geo_id
              , parent_geo_id
              , link_type_id
           FROM u_dw_references.t_geo_object_links
         MINUS
         SELECT child_id
              , parent_new_id
              , link_type
           FROM u_dw.geo_links_actions
          WHERE ( child_id, link_type, action_date ) IN (  SELECT child_id, link_type
                                                       , MAX ( action_date )
                                                    FROM u_dw.geo_links_actions
                                                   WHERE action_type_id = 1
                                                GROUP BY child_id,link_type)
                   ';

      OPEN c1 FOR sql_str;

      cur_id      := dbms_sql.to_cursor_number ( c1 );
      dbms_sql.describe_columns ( cur_id
                                , column_var
                                , describe_table );

      dbms_sql.define_column ( cur_id
                             , 1
                             , child_geo_id );
      dbms_sql.define_column ( cur_id
                             , 2
                             , parent_geo_id );
      dbms_sql.define_column ( cur_id
                             , 3
                             , link_type_id );

      WHILE dbms_sql.fetch_rows ( cur_id ) > 0 LOOP
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 1
                               , child_geo_id );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 2
                               , parent_geo_id );
         dbms_sql.COLUMN_VALUE ( cur_id
                               , 3
                               , link_type_id );


         INSERT INTO u_dw.geo_links_actions g_a ( g_a.link_type
                                                , g_a.child_id
                                                , g_a.parent_new_id
                                                , g_a.action_date
                                                , g_a.action_type_id )
              VALUES ( link_type_id
                     , child_geo_id
                     , parent_geo_id
                     , SYSDATE
                     , 1 );
      END LOOP;

      COMMIT;
   END load_geo_actions;
END pkg_etl_geo_actions;