create or replace package body pkg_load_ext_delivery_systems
as 
PROCEDURE load_ic_delivery_systems
AS
   cnt_rows_processed PLS_INTEGER;
BEGIN
   cnt_rows_processed := 0;

   FOR pc
      IN ( SELECT --+ parallel(cls 4) 
                       DISTINCT st.delivery_system_id as p_id,
                 cls.delivery_system_code,
                 cls.delivery_system_desc
             FROM tmp_orders cls LEFT JOIN st_data.delivery_systems st ON st.delivery_system_code = cls.delivery_system_code )
              LOOP

      cnt_rows_processed := cnt_rows_processed + 1;

      IF pc.p_id IS NOT NULL THEN

         UPDATE st_data.delivery_systems st
            SET st.delivery_system_code = pc.delivery_system_code
              , st.delivery_system_desc = pc.delivery_system_desc
              , st.update_dt = SYSDATE
          WHERE st.delivery_system_code = pc.delivery_system_code
            AND TRIM ( st.delivery_system_desc ) != TRIM ( pc.delivery_system_desc );
    

      ELSIF pc.p_id IS NULL THEN
         INSERT INTO st_data.delivery_systems ( delivery_system_id
                                             , delivery_system_code
                                             , delivery_system_desc
                                             , insert_dt
                                             , localization_id )
              VALUES ( st_data.delivery_systems_seq.NEXTVAL
                     , pc.delivery_system_code
                     , pc.delivery_system_desc
                     , SYSDATE
                     , 1 );
                         null;                 
      ELSE
         EXIT;
      END IF;

      IF cnt_rows_processed >= 100 THEN
         COMMIT;
         cnt_rows_processed := 0;         
      END IF;

   END LOOP;
   COMMIT;                      
END;
end pkg_load_ext_delivery_systems;