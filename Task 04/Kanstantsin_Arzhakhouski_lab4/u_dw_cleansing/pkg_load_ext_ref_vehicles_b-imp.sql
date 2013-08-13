/* Formatted on 8/13/2013 12:47:17 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_vehicles_b
AS
   PROCEDURE load_vehicles_b
   AS
      CURSOR c1
      IS
         SELECT DISTINCT tv.vehicle_id
                       , md.vehicle_type_id
                       , tv.vehicle_desc
                       , tv.vehicle_price
           FROM u_sa_data.tmp_vehicles tv JOIN u_dw.t_vehicle_types md ON ( tv.vehicle_type_id = md.vehicle_type_code )
          WHERE ( tv.vehicle_id ) NOT IN (SELECT DISTINCT vehicle_code
                                            FROM u_dw.t_vehicles);

      CURSOR c2
      IS
         ( SELECT DISTINCT vehicle_id
                         , vehicle_price
             FROM u_sa_data.tmp_vehicles
          MINUS
          SELECT DISTINCT vehicle_code
                        , vehicle_price
            FROM u_dw.t_vehicles );

      TYPE vset1 IS TABLE OF c1%ROWTYPE;

      TYPE vset2 IS TABLE OF c2%ROWTYPE;

      vcoll1         vset1;
      vcoll2         vset2;
   BEGIN
      OPEN c1;



      FETCH c1
      BULK COLLECT INTO vcoll1;



      FORALL i IN INDICES OF vcoll1
         INSERT INTO u_dw.t_vehicles ( vehicle_id
                                     , vehicle_code
                                     , vehicle_type_id
                                     , vehicle_desc
                                     , vehicle_price
                                     , insert_dt )
              VALUES ( u_dw.sq_vehicle_id.NEXTVAL
                     , vcoll1 ( i ).vehicle_id
                     , vcoll1 ( i ).vehicle_type_id
                     , vcoll1 ( i ).vehicle_desc
                     , vcoll1 ( i ).vehicle_price
                     , SYSDATE );

      OPEN c2;

      FETCH c2
      BULK COLLECT INTO vcoll2;

      FORALL j IN INDICES OF vcoll2
         UPDATE u_dw.t_vehicles cr
            SET cr.vehicle_price = vcoll2 ( j ).vehicle_price
              , cr.update_dt = SYSDATE
          WHERE vcoll2 ( j ).vehicle_id = cr.vehicle_code;

      COMMIT;
   END load_vehicles_b;
END pkg_load_ext_ref_vehicles_b;