
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_delivery
AS
   PROCEDURE load_delivery
   AS
      CURSOR curr
      IS
         SELECT del.event_dt
              , del.delivery_id
              , d.dealer_id
              , v.vehicle_id
              , del.fct_quantity
              , del.fct_amount
           FROM u_sa_data.tmp_delivery del
                JOIN u_dw.t_dealers d
                   ON ( del.dealer_id = d.dealer_code )
                JOIN u_dw.t_vehicles v
                   ON ( del.vehicle_id = v.vehicle_code )
        MINUS
         SELECT event_dt
              , delivery_id
              , dealer_id
              , vehicle_id
              , unit_quantity
              , total_price
           FROM u_dw.t_delivery;

      counter        NUMBER;
   BEGIN
      counter     := 1;

      FOR i IN curr LOOP
         INSERT INTO u_dw.t_delivery
              VALUES ( i.event_dt
                     , u_dw.sq_operation_id.NEXTVAL
                     , i.delivery_id
                     , i.dealer_id
                     , i.vehicle_id
                     , i.fct_quantity
                     , i.fct_amount );

         IF ( MOD ( counter
                  , 10000 ) = 0 ) THEN
            COMMIT;
         END IF;

         counter     := counter + 1;
      END LOOP;

      COMMIT;
   END load_delivery;
END pkg_load_ext_ref_delivery;
