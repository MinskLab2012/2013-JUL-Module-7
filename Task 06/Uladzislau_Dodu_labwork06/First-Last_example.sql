/* Formatted on 7/30/2013 5:25:30 PM (QP5 v5.139.911.3011) */
  SELECT   distinct event_dt, company_name,
 decode(last_value(sum_income) over (partition by event_dt,company_name order by company_name)
 -  first_value(sum_income) over (partition by event_dt,company_name order by company_name),0,'one_record', (last_value(sum_income) over (partition by event_dt,company_name order by company_name)
 -  first_value(sum_income) over (partition by event_dt,company_name order by company_name))) dif_last_first
    FROM u_dw_ext_references.agr_trans
    order by 1
