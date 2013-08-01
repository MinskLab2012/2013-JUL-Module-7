/* Formatted on 8/1/2013 12:26:52 AM (QP5 v5.139.911.3011) */
  SELECT MIN ( department_name )
       , last_name
       , man
    FROM (    SELECT LEVEL lev
                   , SYS_CONNECT_BY_PATH ( last_name
                                         , '/' )
                        PATH
                   , department_name
                   , last_name
                   , CONNECT_BY_ROOT last_name man
                FROM structures
          CONNECT BY NOCYCLE PRIOR employee_id = manager_id)
GROUP BY man
       , last_name;