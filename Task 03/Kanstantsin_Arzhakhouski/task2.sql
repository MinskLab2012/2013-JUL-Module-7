/* Formatted on 7/31/2013 1:42:12 PM (QP5 v5.139.911.3011) */
    SELECT LEVEL
         , CONNECT_BY_ROOT vehicle_type AS root
         , vehicle_type
           || SYS_CONNECT_BY_PATH ( vehicle_desc
                                  , ':' )
              PATH
         , CONNECT_BY_ISLEAF
      FROM tmp_vehicles
CONNECT BY PRIOR vehicle_desc = vehicle_type
START WITH vehicle_type IN (SELECT DISTINCT vehicle_type
                              FROM tmp_vehicles);