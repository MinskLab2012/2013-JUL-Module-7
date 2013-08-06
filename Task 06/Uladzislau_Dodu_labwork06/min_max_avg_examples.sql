/* Formatted on 7/30/2013 5:25:30 PM (QP5 v5.139.911.3011) */
/* Formatted on 8/6/2013 2:37:13 PM (QP5 v5.139.911.3011) */
  SELECT DISTINCT
         event_dt
       , company_name
       , DECODE (
                  ( MAX ( sum_income ) OVER (PARTITION BY event_dt, company_name)
                   + MIN ( sum_income ) OVER (PARTITION BY event_dt, company_name) )
                  / 2
                , 0, 'single_record'
                , ( MAX ( sum_income ) OVER (PARTITION BY event_dt, company_name)
                   + MIN ( sum_income ) OVER (PARTITION BY event_dt, company_name) )
                  / 2
         )
            diff_div_2
       , AVG ( sum_income ) OVER (PARTITION BY event_dt) avg_moth
    FROM u_dw_ext_references.agr_trans
ORDER BY 1
