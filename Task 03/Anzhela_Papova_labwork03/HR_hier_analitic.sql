    SELECT manager_id
         , employee_id
         ,    LPAD ( ' '
                   , 3 * LEVEL )
           || first_name
           || ' '
           || last_name
              AS employee_name
         , LEVEL
         , SYS_CONNECT_BY_PATH ( first_name || ' ' || last_name
                               , ':' )
              AS PATH
         , CONNECT_BY_ISLEAF AS isleaf
         , PRIOR last_name AS parent
         , CONNECT_BY_ROOT last_name AS root
      FROM employees
CONNECT BY PRIOR employee_id = manager_id
START WITH manager_id = 100

