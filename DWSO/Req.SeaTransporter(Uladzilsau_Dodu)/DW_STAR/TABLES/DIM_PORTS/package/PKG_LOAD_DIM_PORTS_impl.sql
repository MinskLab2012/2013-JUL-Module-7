/* Formatted on 8/12/2013 3:05:56 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_ports
AS
   PROCEDURE load_dim_ports
   AS
      CURSOR cur_c1
      IS
         SELECT t.port_id, t.port_code, t.pier_code, lc.contact_person, lc.port_coutry, lc.port_city, lc.port_address, t.contact_tel, dw.port_id as port
           FROM st.t_ports t
                JOIN st.lc_ports lc
                   ON t.port_id = lc.port_id
                LEFT JOIN dw_star.dim_ports dw
                   ON t.port_id = dw.port_id;


      TYPE port_tab IS TABLE OF cur_c1%ROWTYPE;

      teb            port_tab;
   BEGIN
      OPEN cur_c1;

      FETCH cur_c1
      BULK COLLECT INTO teb;

      FOR i IN teb.FIRST .. teb.LAST LOOP
         IF teb ( i ).port IS NULL THEN
            INSERT INTO dw_star.dim_ports ( port_id
                                              , port_code
                                              , pier_code
                                              , contact_person
                                              , port_country
                                              , port_city
                                              , port_address
                                              , contact_tel
                                              , last_insert_dt )
                 VALUES ( teb ( i ).port_id
                        , teb ( i ).port_code
                        , teb ( i ).pier_code
                        , teb ( i ).contact_person
                        , teb ( i ).port_coutry
                        , teb ( i ).port_city
                        , teb ( i ).port_address
                        , teb ( i ).contact_tel
                        , SYSDATE );

            COMMIT;
         ELSE
            UPDATE dw_star.dim_ports
               SET port_code    = teb ( i ).port_code
                 , pier_code  = teb ( i ).pier_code
                 , contact_person  = teb ( i ).contact_person
                 , port_country = teb ( i ).port_coutry
                 , port_city    = teb ( i ).port_city
                 ,port_address = teb(i).port_address
                 , contact_tel = teb(i).contact_tel
                 , last_update_dt = SYSDATE
             WHERE port_id = teb ( i ).port_id
               AND ( port_code    = teb ( i ).port_code
                 or pier_code  = teb ( i ).pier_code
                 or contact_person  = teb ( i ).contact_person
                 or port_country = teb ( i ).port_coutry
                 or port_city    = teb ( i ).port_city
                 or port_address = teb(i).port_address
                 or contact_tel = teb(i).contact_tel );
         END IF;
      END LOOP;

      COMMIT;
   END load_dim_ports;
END;