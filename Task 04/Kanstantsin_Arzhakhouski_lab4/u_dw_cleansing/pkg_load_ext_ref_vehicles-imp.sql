/* Formatted on 8/13/2013 12:47:55 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_vehicles
AS
   PROCEDURE load_vehicles
   AS
      CURSOR c_v
      IS
         SELECT DISTINCT vehicle_id
                       , vehicle_type_id
                       , vehicle_desc
                       , vehicle_price
           FROM u_sa_data.tmp_vehicles
          WHERE vehicle_id NOT IN (SELECT vehicle_code
                                     FROM u_dw.t_vehicles);
   BEGIN
      FOR i IN c_v LOOP
         INSERT INTO u_dw.t_vehicles ( vehicle_id
                                     , vehicle_code
                                     , vehicle_type_id
                                     , vehicle_desc
                                     , vehicle_price
                                     , insert_dt )
              VALUES ( u_dw.sq_vehicle_id.NEXTVAL
                     , i.vehicle_id
                     , i.vehicle_type_id
                     , i.vehicle_desc
                     , i.vehicle_price
                     , SYSDATE );

         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_vehicles;
END pkg_load_ext_ref_vehicles;
/