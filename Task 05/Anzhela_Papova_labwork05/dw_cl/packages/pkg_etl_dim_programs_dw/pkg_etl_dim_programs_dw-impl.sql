/* Formatted on 03.08.2013 20:18:51 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_programs_dw
AS
   -- Procedure Reload Data about Managers From Source table Programs
   PROCEDURE load_managers
   AS
      tmp_sql        VARCHAR ( 300 );

      CURSOR c_mng
      IS
         SELECT DISTINCT manager_fn || ' ' || manager_ln AS man_name
           FROM sa_finance.programs
          WHERE manager_fn || ' ' || manager_ln NOT IN (SELECT manager_desc
                                                          FROM dw.t_managers);
   BEGIN
      --Insert Source data
      tmp_sql     := 'INSERT INTO dw.t_managers (manager_id, manager_desc
      , insert_dt, update_dt ) VALUES ( :a, :d, :b, :c )';

      FOR i IN c_mng LOOP
         EXECUTE IMMEDIATE tmp_sql
            USING mng_seq.NEXTVAL
                , i.man_name
                , SYSDATE
                , SYSDATE;
      END LOOP;

      --Commit Result
      COMMIT;
   END load_managers;

   -- Procedure load Data about programs From Source table Programs
   PROCEDURE load_programs
   AS
      TYPE var_cur IS REF CURSOR;

      TYPE tmp_rec IS RECORD
   (
      program_code   VARCHAR2 ( 10 )
    , program_name   VARCHAR2 ( 100 )
    , program_purpose VARCHAR2 ( 200 )
   );

      c_prg          var_cur;
      c_tmp          tmp_rec;
      curid          NUMBER;
      sql_stmt       VARCHAR2 ( 200 );
      ret            NUMBER;
   BEGIN
      sql_stmt    := ' SELECT DISTINCT program_code
                       , program_name
                       , program_purpose
           FROM sa_finance.programs';

      --Open SQL cursor number:
      curid       := dbms_sql.open_cursor;

      -- Parse SQL cursor number:
      dbms_sql.parse ( curid
                     , sql_stmt
                     , dbms_sql.native );

      -- Run SQL cursor number:
      ret         := dbms_sql.execute ( curid );

      c_prg       := dbms_sql.to_refcursor ( curid );

      OPEN c_prg FOR
         SELECT DISTINCT program_code
                       , program_name
                       , program_purpose
           FROM sa_finance.programs;

      --Insert Source data
      LOOP
         FETCH c_prg
         INTO c_tmp;

         INSERT INTO dw.t_programs trg ( program_id
                                       , program_code
                                       , program_desc
                                       , program_purpose
                                       , insert_dt )
            SELECT prg_seq.NEXTVAL
                 , cls.program_code
                 , cls.program_name
                 , cls.program_purpose
                 , SYSDATE
              FROM (SELECT c_tmp.program_code program_code
                         , c_tmp.program_name program_name
                         , c_tmp.program_purpose program_purpose
                      FROM DUAL) cls
             WHERE cls.program_name NOT IN (SELECT program_desc
                                              FROM dw.t_programs
                                             WHERE dw.t_programs.program_code = cls.program_code)
                OR  cls.program_purpose NOT IN (SELECT program_purpose
                                                  FROM dw.t_programs
                                                 WHERE dw.t_programs.program_code = cls.program_code);

         EXIT WHEN c_prg%NOTFOUND;
      END LOOP;

      CLOSE c_prg;

      --Commit Result
      COMMIT;
   END load_programs;


   -- Procedure load Data about programs' managers From Source table Programs
   PROCEDURE load_program_manager
   AS
      TYPE var_cur IS REF CURSOR;

      curid          NUMBER;
      c_prg_man      var_cur;
      tmp_rec        dw.t_program_manager%ROWTYPE;
   BEGIN
      OPEN c_prg_man FOR
         SELECT p.program_id
              , m.manager_id
              , s.start_date
              , SYSDATE
           FROM dw.t_programs p
              , dw.t_managers m
              , sa_finance.programs s
          WHERE s.program_code = p.program_code
            AND s.manager_fn || ' ' || s.manager_ln = m.manager_desc
            AND p.program_id || m.manager_id || s.start_date NOT IN (SELECT program_id || manager_id || valid_from
                                                                       FROM dw.t_program_manager);

      --Insert Source data
      LOOP
         FETCH c_prg_man
         INTO tmp_rec;

         EXIT WHEN c_prg_man%NOTFOUND;

         INSERT INTO dw.t_program_manager
              VALUES tmp_rec;
      END LOOP;

      curid       := dbms_sql.to_cursor_number ( c_prg_man );
      dbms_sql.close_cursor ( curid );
      --Commit Result
      COMMIT;
   END load_program_manager;
END pkg_etl_dim_programs_dw;
/