CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_etl_clients_dw
AS
   PROCEDURE load_cls_clients
   AS
   BEGIN
      EXECUTE IMMEDIATE 'truncate table cls_clients';

      INSERT INTO cls_clients
         SELECT --+PARALLEL(ord 4) FULL(ord)
               DISTINCT first_name
                      , last_name
                      , birth_day
                      , address
           FROM u_sa_data.orders ord;

      COMMIT;
   END;

   PROCEDURE load_dim_merge_clients
   AS
   BEGIN
      EXECUTE IMMEDIATE 'alter session enable parallel dml';

      DELETE --+PARALLEL(t_clients 4)
            FROM  u_dw_data.t_clients t
            WHERE ( t.client_first_name, t.client_last_name, t.country_id, t.date_of_birth ) IN
                     (SELECT --+PARALLEL(tt 4)
                            tt.client_first_name
                           , tt.client_last_name
                           , tt.country_id
                           , tt.date_of_birth
                        FROM u_dw_data.t_clients tt
                      MINUS
                      SELECT --+USE_HASH(cls cntr) full(cls) PARALLEL(cls 4)
                            first_name
                           , last_name
                           , cntr.country_id
                           , birth_day
                        FROM cls_clients cls
                           , u_dw_references.cu_countries cntr
                       WHERE UPPER ( cntr.region_desc ) = UPPER ( TRIM ( cls.address ) ));

      MERGE INTO u_dw_data.t_clients dw
           USING (SELECT --+USE_HASH(cls cntr) full(cls) PARALLEL(cls 4)
                        first_name
                       , last_name
                       , NVL ( cntr.country_id, -1 ) AS country_id
                       , birth_day
                       , ROWNUM AS rn
                    FROM cls_clients cls
                       , u_dw_references.cu_countries cntr
                   WHERE UPPER ( cntr.region_desc ) = UPPER ( TRIM ( cls.address ) )) cls
              ON ( cls.first_name = dw.client_first_name
              AND cls.last_name = dw.client_last_name
              AND cls.country_id = dw.country_id
              AND cls.birth_day = dw.date_of_birth )
      WHEN NOT MATCHED THEN
         INSERT            ( client_id
                           , client_code
                           , client_desc
                           , client_first_name
                           , client_last_name
                           , country_id
                           , date_of_birth )
             VALUES ( u_dw_data.sq_client_id.NEXTVAL
                    , cls.rn
                    , cls.first_name || ' ' || cls.last_name
                    , cls.first_name
                    , cls.last_name
                    , cls.country_id
                    , cls.birth_day )
      WHEN MATCHED THEN
         UPDATE SET client_code  = cls.rn
                  , client_desc  = cls.first_name || ' ' || cls.last_name;

      COMMIT;
   END;

   PROCEDURE load_cls_clients_actions ( p_start_dt      DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE )
                                                                                , -3 )
                                      , p_end_dt        DATE DEFAULT TRUNC ( SYSDATE ) )
   AS
   BEGIN
      EXECUTE IMMEDIATE 'truncate table cls_client_actions';

      EXECUTE IMMEDIATE 'alter session enable parallel dml';

      INSERT --+APPEND PARALLEL(cls_client_actions 4)
            INTO  cls_client_actions
           SELECT --+PARALLEL(i 4) USE_HASH(i dw cntr_s)
                 i.event_dt
                , COUNT ( i.oper_num ) AS cnt_opers
                , NVL ( cntr_s.country_id, -98 ) AS country_id
                , NVL ( dw.client_id, -98 ) AS client_id
             FROM (SELECT TRUNC ( event_dt ) AS event_dt
                        , oper_num
                        , NVL ( cntr.country_id, -98 ) AS country_id
                        , ord.address
                        , UPPER ( ord.cntr_desc ) AS cntr_desc
                        , ord.first_name
                        , ord.last_name
                        , ord.birth_day
                     FROM u_sa_data.orders ord
                        , (SELECT country_id
                                , UPPER ( region_desc ) AS region_desc
                             FROM u_dw_references.cu_countries) cntr
                    WHERE cntr.region_desc = UPPER ( TRIM ( ord.address ) )
                      AND TRUNC ( event_dt ) >= p_start_dt
                      AND TRUNC ( event_dt ) <= p_end_dt) i
                , u_dw_data.t_clients dw
                , (SELECT country_id
                        , UPPER ( region_desc ) AS region_desc
                     FROM u_dw_references.cu_countries) cntr_s
            WHERE dw.client_first_name(+) = i.first_name
              AND dw.client_last_name(+) = i.last_name
              AND dw.country_id(+) = i.country_id
              AND dw.date_of_birth(+) = i.birth_day
              AND cntr_s.region_desc(+) = i.cntr_desc
         GROUP BY i.event_dt
                , NVL ( cntr_s.country_id, -98 )
                , NVL ( i.country_id, -98 )
                , NVL ( dw.client_id, -98 );

      COMMIT;
   END;

   PROCEDURE load_client_geo_sales_init ( p_end_dt DATE DEFAULT TRUNC ( SYSDATE ) )
   AS
   BEGIN
      EXECUTE IMMEDIATE 'truncate table u_dw_data.t_client_geo_sales ';

      EXECUTE IMMEDIATE 'alter session enable parallel dml';

      INSERT --+APPEND PARALLEL(t_client_geo_sales 4)
            INTO  u_dw_data.t_client_geo_sales ( client_id
                                               , geo_id
                                               , country_id
                                               , geo_sale_type_id
                                               , is_actual
                                               , start_dt
                                               , end_dt )
         SELECT --+PARALLEL(cls_i 4)
               cls_i.client_id
              , cls_i.geo_id
              , cls_i.country_id
              , 1 AS geo_sale_type_id
              , CASE
                   WHEN cls_i.all_end_dt = end_dt
                    AND all_end_country_id = country_id THEN
                      'Y'
                   ELSE
                      'N'
                END
                   AS is_actual
              , CASE
                   WHEN rank_1 = 1 THEN
                      TO_DATE ( '01.01.1900'
                              , 'dd.mm.yyyy' )
                   ELSE
                      start_dt
                END
                   AS start_dt
              , CASE
                   WHEN ( cls_i.all_end_dt = end_dt
                     AND all_end_country_id = country_id ) THEN
                      TO_DATE ( '31.12.9999'
                              , 'dd.mm.yyyy' )
                   ELSE
                      end_dt - 1
                END
                   AS end_dt
           FROM (SELECT cls.event_dt
                      , cls.client_id
                      , cntr.geo_id
                      , cntr.country_id
                      , DENSE_RANK ( ) OVER (PARTITION BY client_id ORDER BY event_dt) AS rank_1
                      , MIN ( event_dt )
                           OVER (PARTITION BY client_id ORDER BY event_dt ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
                           AS start_dt
                      , MAX ( event_dt ) OVER (PARTITION BY client_id ORDER BY event_dt) AS end_dt
                      , MAX (
                              event_dt
                        )
                        OVER ( PARTITION BY client_id
                               ORDER BY event_dt
                               ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
                           AS all_end_dt
                      , LAST_VALUE (
                                     cls.country_id
                        )
                        OVER ( PARTITION BY client_id
                               ORDER BY event_dt
                               ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
                           AS all_end_country_id
                   FROM cls_client_actions cls
                      , u_dw_references.w_countries cntr
                  WHERE cntr.country_id(+) = cls.country_id
                    AND cls.event_dt <= p_end_dt) cls_i;

      COMMIT;
   END;

   PROCEDURE load_client_geo_sales ( p_start_dt      DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE )
                                                                             , -3 )
                                   , p_end_dt        DATE DEFAULT TRUNC ( SYSDATE ) )
   AS
      TYPE tmp_updates IS RECORD
   (
      id             PLS_INTEGER
    , country_id     PLS_INTEGER
    , start_dt       DATE
    , end_dt         DATE
   );

      TYPE tmp_tbl_action IS TABLE OF u_dw_cl.cls_client_actions%ROWTYPE;

      TYPE tmp_idx IS TABLE OF tmp_updates
                         INDEX BY PLS_INTEGER;

      --TABLES
      --store actions
      tbl_action     tmp_tbl_action;

      tbl_clt_idx    tmp_idx;
      --store insert idx
      tbl_ins_idx    tmp_idx;
      --store updates idx
      tbl_upd_idx    tmp_idx;

      --CURSOR
      CURSOR cls_actions ( p_start_dt      DATE
                         , p_end_dt        DATE )
      IS
         ( SELECT event_dt
                , cnt_opers
                , country_id
                , client_id
             FROM (  SELECT *
                       FROM cls_client_actions
                   ORDER BY event_dt) cls
            WHERE event_dt >= p_start_dt
              AND event_dt <= p_end_dt );

      --OBJECTS
      --r_act          r_client_action;
      --Vars
      lc             NUMBER := 1;
      lc_client_id   NUMBER := 0;
      lc_upd_id      NUMBER := 0;
      lc_i           NUMBER := 1;
      lc_u           NUMBER := 1;
   BEGIN
      OPEN cls_actions ( p_start_dt
                       , p_end_dt );

      LOOP
         --Bulk Load Actions
         FETCH cls_actions
         BULK COLLECT INTO tbl_action
         LIMIT 100;

         ---Log Disabled
         dbms_output.enable;
         --Assgin Local PL/SQL Array to Gloabal Type Array
         g_tbl_action.delete ( );
         g_tbl_action.EXTEND ( tbl_action.COUNT );
         dbms_output.put_line ( 'tbl_action count rows: ' || tbl_action.COUNT );
         dbms_output.put_line ( 'g_tbl_actio count rows: ' || g_tbl_action.COUNT );

         FOR i IN 1 .. tbl_action.COUNT LOOP
            g_tbl_action ( i ) :=
               r_client_action ( tbl_action ( i ).event_dt
                               , tbl_action ( i ).cnt_opers
                               , tbl_action ( i ).country_id
                               , tbl_action ( i ).client_id );
         END LOOP;

           --Using Gloabal Type Array
           SELECT t.client_id AS id
                , NULL AS country_id
                , MAX ( t.start_dt ) AS start_dt
                , NULL AS end_dt
             BULK COLLECT
             INTO tbl_clt_idx
             FROM u_dw_data.t_client_geo_sales t
                , (SELECT DISTINCT tc.client_id
                     FROM TABLE ( g_tbl_action ) tc) tc
            WHERE t.client_id = tc.client_id
              AND is_actual = 'Y'
         GROUP BY t.client_id;

         dbms_output.put_line ( 'tbl_clt_idx count rows: ' || tbl_clt_idx.COUNT );
         lc_i        := 1;
         lc_u        := 1;
         tbl_upd_idx.delete ( );
         tbl_ins_idx.delete ( );

         dbms_output.put_line ( 'tbl_ins_idx count rows: ' || tbl_ins_idx.COUNT );
         dbms_output.put_line ( 'tbl_upd_idx count rows: ' || tbl_upd_idx.COUNT );

        --Loop by Actions
        <<outer_loop>>
         FOR j IN 1 .. g_tbl_action.COUNT LOOP
            --Loop by Clients Info
            dbms_output.put_line ( 'Event_dt: ' || g_tbl_action ( j ).event_dt );
            dbms_output.put_line ( 'Client_id: ' || g_tbl_action ( j ).client_id );
            --Sign that client not founded
            lc_client_id := -1;

            FOR i IN 1 .. tbl_clt_idx.COUNT LOOP
               --Found Max Values
               IF ( tbl_clt_idx ( i ).id = g_tbl_action ( j ).client_id ) THEN
                  lc_client_id := g_tbl_action ( j ).client_id;

                  dbms_output.put_line ( 'Actual Start_dt: ' || tbl_clt_idx ( i ).start_dt );

                  --Check if row Has Data more Neawly
                  IF tbl_clt_idx ( i ).start_dt < g_tbl_action ( j ).event_dt THEN
                     --Remaping New Actual Value for Client_id
                     tbl_clt_idx ( i ).start_dt := g_tbl_action ( j ).event_dt;
                     dbms_output.put_line ( 'Remaping Actual Start_dt to : ' || g_tbl_action ( j ).event_dt );

                     --Search for rows with the same Client_id and loaded by current Bulk
                     IF tbl_ins_idx.COUNT > 0 THEN
                        FOR m IN 1 .. tbl_ins_idx.COUNT LOOP
                           --Check For Current
                           IF ( tbl_ins_idx ( m ).id = lc_client_id
                           AND tbl_ins_idx ( m ).start_dt < g_tbl_action ( j ).event_dt
                           AND tbl_ins_idx ( m ).end_dt IS NULL ) THEN
                              dbms_output.
                              put_line (
                                            'Remaping tbl_ins_idx end_dt to : '
                                         || tbl_ins_idx ( m ).start_dt
                                         || ' - '
                                         || g_tbl_action ( j ).event_dt
                              );
                              tbl_ins_idx ( m ).end_dt := g_tbl_action ( j ).event_dt;
                           END IF;
                        END LOOP;
                     END IF;

                     --Prepare New Actual Row
                     tbl_ins_idx ( lc_i ).id := g_tbl_action ( j ).client_id;
                     tbl_ins_idx ( lc_i ).country_id := g_tbl_action ( j ).country_id;
                     tbl_ins_idx ( lc_i ).start_dt := g_tbl_action ( j ).event_dt;
                     tbl_ins_idx ( lc_i ).end_dt := NULL;
                     --Increase Count of lc_i rows
                     lc_i        := lc_i + 1;

                     /********************/
                     --Update Previous Client_Id actial Row
                     lc_upd_id   := -1; --Sign of Found Update row For Client_id

                     --Seaching Update rows
                     FOR m IN 1 .. tbl_upd_idx.COUNT LOOP
                        IF tbl_upd_idx ( m ).id = lc_client_id THEN
                           lc_upd_id   := m;
                        END IF;
                     END LOOP;

                     --Prepare update array for old Actual Rows
                     IF lc_upd_id = -1 THEN
                        tbl_upd_idx ( lc_u ).id := g_tbl_action ( j ).client_id;
                        tbl_upd_idx ( lc_u ).country_id := NULL;
                        tbl_upd_idx ( lc_u ).start_dt := NULL;
                        tbl_upd_idx ( lc_u ).end_dt := TO_DATE ( g_tbl_action ( j ).event_dt - 1 );
                        lc_u        := lc_u + 1;
                     --                        dbms_output.put_line ( 'Create Update rows end_dt to : ' || g_tbl_action ( j ).event_dt - 1 );
                     END IF;
                  ELSE
                     dbms_output.put_line ( 'Disabled Middle Insertion' );
                  END IF;

                  CONTINUE outer_loop;
               END IF;
            END LOOP;

            --Insert Just First new Actual Row
            IF lc_client_id < 0 THEN
               tbl_ins_idx ( lc_i ).id := g_tbl_action ( j ).client_id;
               tbl_ins_idx ( lc_i ).country_id := g_tbl_action ( j ).country_id;
               tbl_ins_idx ( lc_i ).start_dt := g_tbl_action ( j ).event_dt;
               tbl_ins_idx ( lc_i ).end_dt := NULL;
               --Increase Count of lc_i rows
               lc_i        := lc_i + 1;
            END IF;
         END LOOP;

         dbms_output.put_line ( 'Update rows: ' || tbl_upd_idx.COUNT );

         IF tbl_upd_idx.COUNT > 0 THEN
            --Update Old Actual Values
            FORALL i IN INDICES OF tbl_upd_idx
               UPDATE u_dw_data.t_client_geo_sales t
                  SET is_actual    = 'N'
                    , end_dt       = tbl_upd_idx ( i ).end_dt
                WHERE t.is_actual = 'Y'
                  AND t.client_id = tbl_upd_idx ( i ).id;
         END IF;

         dbms_output.put_line ( 'Insert rows: ' || tbl_ins_idx.COUNT );

         --Insert New Rows
         IF tbl_ins_idx.COUNT > 0 THEN
            FORALL i IN 1 .. tbl_ins_idx.COUNT -- use FORALL statement
               INSERT INTO u_dw_data.t_client_geo_sales ( client_id
                                                        , geo_id
                                                        , country_id
                                                        , geo_sale_type_id
                                                        , is_actual
                                                        , start_dt
                                                        , end_dt )
                    VALUES ( tbl_ins_idx ( i ).id
                           , -1
                           , tbl_ins_idx ( i ).country_id
                           , 1
                           , CASE WHEN tbl_ins_idx ( i ).end_dt IS NULL THEN 'Y' ELSE 'N' END
                           , tbl_ins_idx ( i ).start_dt
                           , NVL ( tbl_ins_idx ( i ).end_dt
                                 , TO_DATE ( '31129999'
                                           , 'ddmmyyyy' ) ) );
         END IF;

         COMMIT;

         EXIT WHEN cls_actions%NOTFOUND;
      END LOOP;

      --Update Geo_id's
      MERGE INTO u_dw_data.t_client_geo_sales trg
           USING (SELECT /*+USE_HASH(cntr src)*/
                        client_id
                       , src.country_id
                       , start_dt
                       , end_dt
                       , cntr.geo_id
                    FROM u_dw_data.t_client_geo_sales src
                       , u_dw_references.cu_countries cntr
                   WHERE src.geo_id = -1
                     AND cntr.country_id(+) = src.country_id) src
              ON ( trg.client_id = src.client_id
              AND trg.country_id = src.country_id
              AND trg.end_dt = src.end_dt )
      WHEN MATCHED THEN
         UPDATE SET trg.geo_id   = src.geo_id;
   END;

   FUNCTION show_tbl_acton
      RETURN tbl_client_action
      PIPELINED
   AS
   BEGIN
      FOR i IN 1 .. g_tbl_action.COUNT LOOP
         PIPE ROW ( g_tbl_action ( i ) );
      END LOOP;

      RETURN;
   END;
BEGIN
   g_tbl_action := tbl_client_action ( );
END pkg_etl_clients_dw;
/