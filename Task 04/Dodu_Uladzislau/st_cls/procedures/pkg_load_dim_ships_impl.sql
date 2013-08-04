/* Formatted on 8/4/2013 1:49:06 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_ships
AS
   PROCEDURE load_t_ships
   AS
   BEGIN
      DELETE FROM st.t_ships sh
            WHERE sh.ship_code NOT IN (SELECT DISTINCT ship_unique_identifier
                                         FROM u_dw_ext_references.ext_ship);

      MERGE INTO st.t_ships sh
           USING (SELECT DISTINCT *
                    FROM u_dw_ext_references.ext_ship) ext
              ON ( sh.ship_code = ext.ship_unique_identifier )
      WHEN NOT MATCHED THEN
         INSERT            ( sh.ship_id
                           , sh.ship_code
                           , sh.weight
                           , sh.height
                           , sh.water_volume
                           , sh.max_cargo
                           , sh.last_insert_dt )
             VALUES ( st.seq_t_ships.NEXTVAL
                    , ext.ship_unique_identifier
                    , ext.weight
                    , ext.height
                    , ext.water_volume
                    , ext.max_cargo
                    , SYSDATE )
      WHEN MATCHED THEN
         UPDATE SET sh.weight    = ext.weight
                  , sh.height    = ext.height
                  , sh.water_volume = ext.water_volume
                  , sh.max_cargo = ext.max_cargo
                  , sh.last_update_dt = SYSDATE;

      COMMIT;
   END load_t_ships;
end;