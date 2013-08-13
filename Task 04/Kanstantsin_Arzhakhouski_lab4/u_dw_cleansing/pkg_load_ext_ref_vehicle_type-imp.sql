/* Formatted on 8/13/2013 12:44:49 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_vehicle_type
AS
   --load types (Merge)
   PROCEDURE load_types
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw.t_vehicle_types vt
           USING (  SELECT DISTINCT vehicle_type_id AS vehicle_type_id
                                  , vehicle_type_desc AS vehicle_type_desc
                      FROM u_sa_data.tmp_vehicle_types
                  ORDER BY vehicle_type_desc) cls
              ON ( vt.vehicle_type_id = cls.vehicle_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( vt.vehicle_type_id
                           , vt.vehicle_type_code
                           , vt.vehicle_type_desc
                           , vt.insert_dt )
             VALUES ( u_dw.sq_vehicle_type_id.NEXTVAL
                    , cls.vehicle_type_id
                    , cls.vehicle_type_desc
                    , SYSDATE )
      WHEN MATCHED THEN
         UPDATE SET vt.vehicle_type_desc = cls.vehicle_type_desc
                  , vt.update_dt = SYSDATE
                 WHERE vt.vehicle_type_desc != cls.vehicle_type_desc;

      COMMIT;
   END load_types;
END pkg_load_ext_ref_vehicle_type;