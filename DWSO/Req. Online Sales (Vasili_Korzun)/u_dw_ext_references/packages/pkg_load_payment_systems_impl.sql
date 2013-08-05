/* Formatted on 04.08.2013 21:09:50 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_payment_systems
AS
   PROCEDURE load_cursor_ps_types
   AS
   BEGIN
      FOR pc
         IN (SELECT                   /*+USE_MERGE(cls, st) parallel(cls, 4)*/
                   DISTINCT
                    st.payment_system_type_id AS p_id,
                    cls.payment_system_type
               FROM    tmp_orders cls
                    LEFT JOIN
                       st_data.payment_systems_types st
                    ON cls.payment_system_type = st.payment_system_type_desc)
      LOOP
         IF pc.p_id IS NOT NULL
         THEN
            NULL;
         --nothing, because there is only natural key in table, no other columns
         ELSIF pc.p_id IS NULL
         THEN
            INSERT INTO st_data.payment_systems_types (
                                                       payment_system_type_id,
                                                       payment_system_type_desc,
                                                       insert_dt)
                 VALUES (
                    st_data.payment_systems_types_seq.NEXTVAL,
                    pc.payment_system_type,
                    SYSDATE);
         ELSE
            EXIT;
         END IF;
      END LOOP;

      COMMIT;
   END;



   PROCEDURE load_cursor_payment_systems
   AS
      CURSOR cur_ps
      IS
         SELECT                        /*+USE_HASH(cls, st) parallel(cls, 4)*/
               DISTINCT st.payment_system_id AS p_id,
                        cls.payment_system_desc AS payment_system_code,
                        'Code_' || cls.payment_system_desc AS cls_desc,
                        st.payment_system_desc,
                        stt.payment_system_type_id
           FROM tmp_orders cls
                LEFT JOIN st_data.payment_systems st
                   ON st.payment_system_code = cls.payment_system_desc
                JOIN st_data.payment_systems_types stt
                   ON cls.payment_system_type = stt.payment_system_type_desc;
   BEGIN
      FOR pc IN cur_ps
      LOOP
         IF pc.p_id IS NOT NULL
         THEN
            IF pc.payment_system_desc != pc.cls_desc
            THEN
               UPDATE st_data.payment_systems st
                  SET ST.PAYMENT_SYSTEM_DESC = pc.cls_desc,
                      st.update_dt = SYSDATE
                WHERE st.payment_system_code = pc.payment_system_code;

               INSERT INTO st_data.payment_systems_actions (
                                                            action_id,
                                                            action_date,
                                                            payment_system_id,
                                                            action_type_id,
                                                            value_old,
                                                            value_new)
                    VALUES (st_data.payment_systems_actions_seq.NEXTVAL,
                            SYSDATE,
                            pc.p_id,
                            (SELECT action_type_id
                               FROM st_data.payment_systems_action_types
                              WHERE action_type_desc = 'PSDESC'),
                            pc.payment_system_desc,
                            pc.cls_desc);
            END IF;
         ELSIF pc.p_id IS NULL
         THEN
            INSERT INTO st_data.payment_systems (payment_system_id,
                                                 payment_system_code,
                                                 payment_system_desc,
                                                 payment_system_type_id,
                                                 insert_dt)
                 VALUES (st_data.payment_systems_seq.NEXTVAL,
                         pc.payment_system_code,
                         pc.cls_desc,
                         pc.payment_system_type_id,
                         SYSDATE);

            NULL;
         ELSE
            raise_application_error(-20222, 'Something bad is happening with main routine');
         END IF;
      END LOOP;
      COMMIT;
   END;
END;